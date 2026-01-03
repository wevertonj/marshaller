import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/entities/episode.dart';

sealed class SeasonDetailState {
  const SeasonDetailState();
}

final class SeasonDetailInitial extends SeasonDetailState {
  const SeasonDetailInitial();
}

final class SeasonDetailLoading extends SeasonDetailState {
  const SeasonDetailLoading();
}

final class SeasonDetailLoaded extends SeasonDetailState {
  final String seasonCode;
  final List<Episode> episodes;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<Character> characters;
  final bool isLoadingCharacters;

  const SeasonDetailLoaded({
    required this.seasonCode,
    required this.episodes,
    this.startDate,
    this.endDate,
    this.characters = const [],
    this.isLoadingCharacters = false,
  });

  SeasonDetailLoaded copyWith({
    String? seasonCode,
    List<Episode>? episodes,
    DateTime? startDate,
    DateTime? endDate,
    List<Character>? characters,
    bool? isLoadingCharacters,
  }) {
    return SeasonDetailLoaded(
      seasonCode: seasonCode ?? this.seasonCode,
      episodes: episodes ?? this.episodes,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      characters: characters ?? this.characters,
      isLoadingCharacters: isLoadingCharacters ?? this.isLoadingCharacters,
    );
  }
}

final class SeasonDetailError extends SeasonDetailState {
  final String message;
  const SeasonDetailError(this.message);
}
