import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/domain/entities/episode.dart';
import 'package:marshaller/ui/episodes/viewmodels/episode_detail_state.dart';

class EpisodeDetailViewModel extends ChangeNotifier {
  final RickMortyRepository _repository;
  EpisodeDetailViewModel({required RickMortyRepository repository})
    : _repository = repository;
  final state = ValueNotifier<EpisodeDetailState>(const EpisodeDetailInitial());
  late final loadEpisodeCommand = Command1(_loadEpisode);
  AsyncResult<Episode> _loadEpisode(int id) async {
    state.value = const EpisodeDetailLoading();
    final result = await _repository.getEpisode(id);
    result.fold((episode) {
      state.value = EpisodeDetailLoaded(episode, isLoadingCharacters: true);
      _loadCharacters(episode);
    }, (error) => state.value = EpisodeDetailError(error.toString()));
    return result;
  }

  Future<void> _loadCharacters(Episode episode) async {
    if (episode.characterIds.isEmpty) {
      final currentState = state.value;
      if (currentState is EpisodeDetailLoaded) {
        state.value = currentState.copyWith(isLoadingCharacters: false);
      }
      return;
    }
    final result = await _repository.getMultipleCharacters(
      episode.characterIds,
    );
    result.fold(
      (characters) {
        final currentState = state.value;
        if (currentState is EpisodeDetailLoaded) {
          state.value = currentState.copyWith(
            characters: characters,
            isLoadingCharacters: false,
          );
        }
      },
      (error) {
        final currentState = state.value;
        if (currentState is EpisodeDetailLoaded) {
          state.value = currentState.copyWith(isLoadingCharacters: false);
        }
      },
    );
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
