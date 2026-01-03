import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/entities/episode.dart';

sealed class CharacterDetailState {
  const CharacterDetailState();
}

final class CharacterDetailInitial extends CharacterDetailState {
  const CharacterDetailInitial();
}

final class CharacterDetailLoading extends CharacterDetailState {
  const CharacterDetailLoading();
}

final class CharacterDetailLoaded extends CharacterDetailState {
  final Character character;
  final List<Episode> episodes;
  final bool loadingEpisodes;
  const CharacterDetailLoaded(
    this.character, {
    this.episodes = const [],
    this.loadingEpisodes = true,
  });
  CharacterDetailLoaded copyWith({
    Character? character,
    List<Episode>? episodes,
    bool? loadingEpisodes,
  }) {
    return CharacterDetailLoaded(
      character ?? this.character,
      episodes: episodes ?? this.episodes,
      loadingEpisodes: loadingEpisodes ?? this.loadingEpisodes,
    );
  }
}

final class CharacterDetailError extends CharacterDetailState {
  final String message;
  const CharacterDetailError(this.message);
}
