import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/ui/episodes/viewmodels/episode_list_state.dart';

class EpisodeListViewModel extends ChangeNotifier {
  final RickMortyRepository _repository;
  EpisodeListViewModel({required RickMortyRepository repository})
    : _repository = repository;
  final state = ValueNotifier<EpisodeListState>(const EpisodeListInitial());
  late final loadEpisodesCommand =
      Command1<Unit, ({bool forceRefresh, String? name})>(_loadEpisodes);
  late final loadMoreCommand = Command0(_loadMore);
  AsyncResult<Unit> _loadEpisodes(
    ({bool forceRefresh, String? name}) params,
  ) async {
    state.value = const EpisodeListLoading();
    final result = await _repository.getEpisodes(
      page: 1,
      forceRefresh: params.forceRefresh,
      name: params.name,
    );
    result.fold(
      (paginatedResult) => state.value = EpisodeListLoaded(
        episodes: paginatedResult.items,
        hasMore: paginatedResult.hasMore,
        currentPage: 1,
        name: params.name,
      ),
      (error) => state.value = EpisodeListError(error.toString()),
    );
    return result.pure(unit);
  }

  AsyncResult<Unit> _loadMore() async {
    final currentState = state.value;
    if (currentState is! EpisodeListLoaded || !currentState.hasMore) {
      return Success(unit);
    }
    state.value = currentState.copyWith(isLoadingMore: true);
    final nextPage = currentState.currentPage + 1;
    final result = await _repository.getEpisodes(
      page: nextPage,
      name: currentState.name,
    );
    result.fold(
      (paginatedResult) => state.value = currentState.copyWith(
        episodes: [...currentState.episodes, ...paginatedResult.items],
        hasMore: paginatedResult.hasMore,
        currentPage: nextPage,
        isLoadingMore: false,
      ),
      (error) => state.value = currentState.copyWith(isLoadingMore: false),
    );
    return result.pure(unit);
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
