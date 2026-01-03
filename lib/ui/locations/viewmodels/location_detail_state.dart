import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/entities/location.dart';

sealed class LocationDetailState {
  const LocationDetailState();
}

final class LocationDetailInitial extends LocationDetailState {
  const LocationDetailInitial();
}

final class LocationDetailLoading extends LocationDetailState {
  const LocationDetailLoading();
}

final class LocationDetailLoaded extends LocationDetailState {
  final Location location;
  final List<Character> residents;
  final bool isLoadingResidents;
  const LocationDetailLoaded(
    this.location, {
    this.residents = const [],
    this.isLoadingResidents = false,
  });
  LocationDetailLoaded copyWith({
    Location? location,
    List<Character>? residents,
    bool? isLoadingResidents,
  }) {
    return LocationDetailLoaded(
      location ?? this.location,
      residents: residents ?? this.residents,
      isLoadingResidents: isLoadingResidents ?? this.isLoadingResidents,
    );
  }
}

final class LocationDetailError extends LocationDetailState {
  final String message;
  const LocationDetailError(this.message);
}
