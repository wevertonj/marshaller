import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/domain/entities/location.dart';
import 'package:marshaller/ui/locations/viewmodels/location_detail_state.dart';

class LocationDetailViewModel extends ChangeNotifier {
  final RickMortyRepository _repository;
  LocationDetailViewModel({required RickMortyRepository repository})
    : _repository = repository;
  final state = ValueNotifier<LocationDetailState>(
    const LocationDetailInitial(),
  );
  late final loadLocationCommand = Command1(_loadLocation);
  AsyncResult<Location> _loadLocation(int id) async {
    state.value = const LocationDetailLoading();
    final result = await _repository.getLocation(id);
    result.fold((location) {
      state.value = LocationDetailLoaded(
        location,
        isLoadingResidents: location.residentIds.isNotEmpty,
      );
      _loadResidents(location.residentIds);
    }, (error) => state.value = LocationDetailError(error.toString()));
    return result;
  }

  Future<void> _loadResidents(List<int> ids) async {
    if (ids.isEmpty) return;
    final currentState = state.value;
    if (currentState is! LocationDetailLoaded) return;
    final result = await _repository.getMultipleCharacters(ids);
    result.fold(
      (characters) {
        state.value = currentState.copyWith(
          residents: characters,
          isLoadingResidents: false,
        );
      },
      (_) {
        state.value = currentState.copyWith(isLoadingResidents: false);
      },
    );
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
