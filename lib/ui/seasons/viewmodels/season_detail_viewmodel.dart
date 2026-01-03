import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';

import 'package:marshaller/domain/entities/episode.dart';
import 'package:marshaller/ui/seasons/viewmodels/season_detail_state.dart';

class SeasonDetailViewModel extends ChangeNotifier {
  final RickMortyRepository _repository;

  SeasonDetailViewModel({required RickMortyRepository repository})
    : _repository = repository;

  final state = ValueNotifier<SeasonDetailState>(const SeasonDetailInitial());

  late final loadSeasonCommand = Command1<Unit, String>(_loadSeason);

  AsyncResult<Unit> _loadSeason(String seasonCode) async {
    state.value = const SeasonDetailLoading();

    final seasonNumber = int.tryParse(seasonCode.replaceAll('S', '')) ?? 1;

    final List<int> episodeIds;
    if (seasonNumber == 1) {
      episodeIds = List.generate(11, (i) => i + 1);
    } else {
      final startId = 12 + (seasonNumber - 2) * 10;
      episodeIds = List.generate(10, (i) => startId + i);
    }

    final result = await _repository.getMultipleEpisodes(episodeIds);

    if (result.isError()) {
      state.value = SeasonDetailError(result.exceptionOrNull().toString());
      return result.pure(unit);
    }

    final episodes = result.getOrThrow();

    episodes.sort((a, b) => a.airDate.compareTo(b.airDate));

    final startDate = episodes.isNotEmpty ? episodes.first.airDate : null;
    final endDate = episodes.isNotEmpty ? episodes.last.airDate : null;

    state.value = SeasonDetailLoaded(
      seasonCode: seasonCode,
      episodes: episodes,
      startDate: startDate,
      endDate: endDate,
      isLoadingCharacters: true,
    );

    await _loadCharacters(episodes);

    return Success(unit);
  }

  Future<void> _loadCharacters(List<Episode> episodes) async {
    final currentState = state.value;
    if (currentState is! SeasonDetailLoaded) return;

    final characterUrls = episodes.expand((e) => e.characters).toSet();

    final characterIds = characterUrls
        .map((url) => int.tryParse(url.split('/').last))
        .whereType<int>()
        .toList();

    if (characterIds.isEmpty) {
      state.value = currentState.copyWith(isLoadingCharacters: false);
      return;
    }

    final result = await _repository.getMultipleCharacters(characterIds);

    result.fold(
      (characters) {
        state.value = currentState.copyWith(
          characters: characters,
          isLoadingCharacters: false,
        );
      },
      (error) {
        state.value = currentState.copyWith(isLoadingCharacters: false);
      },
    );
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
