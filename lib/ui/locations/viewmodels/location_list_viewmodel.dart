import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/ui/locations/viewmodels/location_list_state.dart';

class LocationListViewModel extends ChangeNotifier {
  final RickMortyRepository _repository;
  LocationListViewModel({required RickMortyRepository repository})
    : _repository = repository;
  final state = ValueNotifier<LocationListState>(const LocationListInitial());
  late final loadLocationsCommand =
      Command1<Unit, ({bool forceRefresh, String? type, String? dimension})>(
        _loadLocations,
      );
  late final loadMoreCommand = Command0(_loadMore);

  AsyncResult<Unit> _loadLocations(
    ({bool forceRefresh, String? type, String? dimension}) params,
  ) async {
    final forceRefresh = params.forceRefresh;
    final type = params.type;
    final dimension = params.dimension;
    state.value = const LocationListLoading();
    final result = await _repository.getLocations(
      page: 1,
      type: type,
      dimension: dimension,
      forceRefresh: forceRefresh,
    );
    result.fold(
      (paginatedResult) => state.value = LocationListLoaded(
        locations: paginatedResult.items,
        hasMore: paginatedResult.hasMore,
        currentPage: 1,
        totalCount: paginatedResult.totalCount,
        type: type,
        dimension: dimension,
      ),
      (error) => state.value = LocationListError(error.toString()),
    );
    return result.pure(unit);
  }

  AsyncResult<Unit> _loadMore() async {
    final currentState = state.value;
    if (currentState is! LocationListLoaded || !currentState.hasMore) {
      return Success(unit);
    }
    state.value = currentState.copyWith(isLoadingMore: true);
    final nextPage = currentState.currentPage + 1;
    final result = await _repository.getLocations(
      page: nextPage,
      type: currentState.type,
      dimension: currentState.dimension,
    );
    result.fold(
      (paginatedResult) => state.value = currentState.copyWith(
        locations: [...currentState.locations, ...paginatedResult.items],
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
