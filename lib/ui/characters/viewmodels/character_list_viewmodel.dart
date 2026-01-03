import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/ui/characters/viewmodels/character_list_state.dart';

class CharacterListViewModel extends ChangeNotifier {
  final RickMortyRepository _repository;
  CharacterListViewModel({required RickMortyRepository repository})
    : _repository = repository;
  final state = ValueNotifier<CharacterListState>(const CharacterListInitial());
  late final loadCharactersCommand =
      Command1<
        Unit,
        ({bool forceRefresh, String? species, String? type, String? gender})
      >(_loadCharacters);
  late final loadMoreCommand = Command0(_loadMore);

  AsyncResult<Unit> _loadCharacters(
    ({bool forceRefresh, String? species, String? type, String? gender}) params,
  ) async {
    final forceRefresh = params.forceRefresh;
    final species = params.species;
    final type = params.type;
    final gender = params.gender;
    state.value = const CharacterListLoading();
    final result = await _repository.getCharacters(
      page: 1,
      species: species,
      type: type,
      gender: gender,
      forceRefresh: forceRefresh,
    );
    result.fold(
      (paginatedResult) => state.value = CharacterListLoaded(
        characters: paginatedResult.items,
        hasMore: paginatedResult.hasMore,
        currentPage: 1,
        totalCount: paginatedResult.totalCount,
        species: species,
        type: type,
        gender: gender,
      ),
      (error) => state.value = CharacterListError(error.toString()),
    );
    return result.pure(unit);
  }

  AsyncResult<Unit> _loadMore() async {
    final currentState = state.value;
    if (currentState is! CharacterListLoaded || !currentState.hasMore) {
      return Success(unit);
    }
    state.value = currentState.copyWith(isLoadingMore: true);
    final nextPage = currentState.currentPage + 1;
    final result = await _repository.getCharacters(
      page: nextPage,
      species: currentState.species,
      type: currentState.type,
      gender: currentState.gender,
    );
    result.fold(
      (paginatedResult) => state.value = currentState.copyWith(
        characters: [...currentState.characters, ...paginatedResult.items],
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
