import 'package:marshaller/domain/entities/episode.dart';

sealed class EpisodeListState {
  const EpisodeListState();
}

final class EpisodeListInitial extends EpisodeListState {
  const EpisodeListInitial();
}

final class EpisodeListLoading extends EpisodeListState {
  const EpisodeListLoading();
}

final class EpisodeListLoaded extends EpisodeListState {
  final List<Episode> episodes;
  final bool hasMore;
  final bool isLoadingMore;
  final int currentPage;
  final String? name;
  const EpisodeListLoaded({
    required this.episodes,
    required this.hasMore,
    this.isLoadingMore = false,
    required this.currentPage,
    this.name,
  });
  EpisodeListLoaded copyWith({
    List<Episode>? episodes,
    bool? hasMore,
    bool? isLoadingMore,
    int? currentPage,
    String? name,
  }) {
    return EpisodeListLoaded(
      episodes: episodes ?? this.episodes,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      name: name ?? this.name,
    );
  }
}

final class EpisodeListError extends EpisodeListState {
  final String message;
  const EpisodeListError(this.message);
}
