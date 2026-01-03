import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/ui/characters/viewmodels/character_detail_state.dart';

class CharacterDetailViewModel extends ChangeNotifier {
  final RickMortyRepository _repository;
  CharacterDetailViewModel({required RickMortyRepository repository})
    : _repository = repository;
  final state = ValueNotifier<CharacterDetailState>(
    const CharacterDetailInitial(),
  );
  late final loadCharacterCommand = Command1(_loadCharacter);
  AsyncResult<Character> _loadCharacter(int id) async {
    state.value = const CharacterDetailLoading();
    final result = await _repository.getCharacter(id);
    result.fold((character) {
      state.value = CharacterDetailLoaded(character);
      _loadEpisodes(character);
    }, (error) => state.value = CharacterDetailError(error.toString()));
    return result;
  }

  Future<void> _loadEpisodes(Character character) async {
    if (character.episodeIds.isEmpty) {
      final currentState = state.value;
      if (currentState is CharacterDetailLoaded) {
        state.value = currentState.copyWith(loadingEpisodes: false);
      }
      return;
    }
    final result = await _repository.getMultipleEpisodes(character.episodeIds);
    result.fold(
      (episodes) {
        final currentState = state.value;
        if (currentState is CharacterDetailLoaded) {
          state.value = currentState.copyWith(
            episodes: episodes,
            loadingEpisodes: false,
          );
        }
      },
      (_) {
        final currentState = state.value;
        if (currentState is CharacterDetailLoaded) {
          state.value = currentState.copyWith(loadingEpisodes: false);
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
