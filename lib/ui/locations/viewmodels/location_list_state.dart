import 'package:marshaller/domain/entities/location.dart';

sealed class LocationListState {
  const LocationListState();
}

final class LocationListInitial extends LocationListState {
  const LocationListInitial();
}

final class LocationListLoading extends LocationListState {
  const LocationListLoading();
}

final class LocationListLoaded extends LocationListState {
  final List<Location> locations;
  final bool hasMore;
  final bool isLoadingMore;
  final int currentPage;
  final int totalCount;
  final String? type;
  final String? dimension;
  const LocationListLoaded({
    required this.locations,
    required this.hasMore,
    this.isLoadingMore = false,
    required this.currentPage,
    this.totalCount = 0,
    this.type,
    this.dimension,
  });
  LocationListLoaded copyWith({
    List<Location>? locations,
    bool? hasMore,
    bool? isLoadingMore,
    int? currentPage,
    int? totalCount,
    String? type,
    String? dimension,
  }) {
    return LocationListLoaded(
      locations: locations ?? this.locations,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      totalCount: totalCount ?? this.totalCount,
      type: type ?? this.type,
      dimension: dimension ?? this.dimension,
    );
  }
}

final class LocationListError extends LocationListState {
  final String message;
  const LocationListError(this.message);
}
