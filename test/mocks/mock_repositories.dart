import 'package:mocktail/mocktail.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/data/repositories/settings/app_settings_repository.dart';

class MockRickMortyRepository extends Mock implements RickMortyRepository {}

class MockAppSettingsRepository extends Mock implements AppSettingsRepository {}
