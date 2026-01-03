import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/entities/episode.dart';

sealed class EpisodeDetailState {
  const EpisodeDetailState();
}

final class EpisodeDetailInitial extends EpisodeDetailState {
  const EpisodeDetailInitial();
}

final class EpisodeDetailLoading extends EpisodeDetailState {
  const EpisodeDetailLoading();
}

final class EpisodeDetailLoaded extends EpisodeDetailState {
  final Episode episode;
  final List<Character> characters;
  final bool isLoadingCharacters;
  const EpisodeDetailLoaded(
    this.episode, {
    this.characters = const [],
    this.isLoadingCharacters = false,
  });
  EpisodeDetailLoaded copyWith({
    Episode? episode,
    List<Character>? characters,
    bool? isLoadingCharacters,
  }) {
    return EpisodeDetailLoaded(
      episode ?? this.episode,
      characters: characters ?? this.characters,
      isLoadingCharacters: isLoadingCharacters ?? this.isLoadingCharacters,
    );
  }
}

final class EpisodeDetailError extends EpisodeDetailState {
  final String message;
  const EpisodeDetailError(this.message);
}
