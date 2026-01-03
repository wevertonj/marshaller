import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:marshaller/config/go_router.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository.dart';
import 'package:marshaller/data/repositories/rick_morty/rick_morty_repository_impl.dart';
import 'package:marshaller/data/repositories/settings/app_settings_repository.dart';
import 'package:marshaller/data/repositories/settings/app_settings_repository_impl.dart';
import 'package:marshaller/data/services/app_settings/app_settings_local_storage.dart';
import 'package:marshaller/data/services/http/client_http.dart';
import 'package:marshaller/data/services/http/http_error_handler.dart';
import 'package:marshaller/data/services/http/rick_morty_client_http.dart';
import 'package:marshaller/data/services/cache/api_cache_service.dart';
import 'package:marshaller/data/services/database/database_service.dart';
import 'package:marshaller/data/services/storage/local_storage.dart';
import 'package:marshaller/data/services/storage/secure_local_storage.dart';
import 'package:marshaller/ui/characters/viewmodels/character_detail_viewmodel.dart';
import 'package:marshaller/ui/characters/viewmodels/character_list_viewmodel.dart';
import 'package:marshaller/ui/episodes/viewmodels/episode_detail_viewmodel.dart';
import 'package:marshaller/ui/episodes/viewmodels/episode_list_viewmodel.dart';
import 'package:marshaller/ui/home/viewmodels/home_viewmodel.dart';
import 'package:marshaller/ui/locations/viewmodels/location_detail_viewmodel.dart';
import 'package:marshaller/ui/locations/viewmodels/location_list_viewmodel.dart';
import 'package:marshaller/ui/settings/viewmodels/settings_viewmodel.dart';
import 'package:marshaller/ui/seasons/viewmodels/season_detail_viewmodel.dart';

final getIt = GetIt.instance;
void setupDependencies() {
  _registerCoreServices();
  _registerRepositories();
  _registerViewModels();
}

void _registerCoreServices() {
  getIt.registerLazySingleton<GoRouter>(() => goRouter);
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
  getIt.registerLazySingleton<SecureLocalStorage>(
    () => SecureLocalStorage(const FlutterSecureStorage()),
  );
  getIt.registerLazySingleton<AppSettingsLocalStorage>(
    () => AppSettingsLocalStorage(),
  );
  getIt.registerLazySingleton<DatabaseService>(() => DatabaseService());
  getIt.registerLazySingleton<ApiCacheService>(() => ApiCacheService());
  getIt.registerLazySingleton<HttpErrorHandler>(() => HttpErrorHandler());
  getIt.registerLazySingleton<ClientHttp>(
    () => ClientHttp(errorHandler: getIt<HttpErrorHandler>()),
  );
  getIt.registerLazySingleton<RickMortyClientHttp>(
    () => RickMortyClientHttp(errorHandler: getIt<HttpErrorHandler>()),
  );
}

void _registerRepositories() {
  getIt.registerLazySingleton<AppSettingsRepository>(
    () => AppSettingsRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<RickMortyRepository>(
    () => RickMortyRepositoryImpl(),
  );
}

void _registerViewModels() {
  getIt.registerFactory<HomeViewModel>(() => HomeViewModel());
  getIt.registerLazySingleton<SettingsViewModel>(
    () => SettingsViewModel(settingsRepository: getIt<AppSettingsRepository>()),
  );
  getIt.registerFactory<CharacterListViewModel>(
    () => CharacterListViewModel(repository: getIt<RickMortyRepository>()),
  );
  getIt.registerFactory<CharacterDetailViewModel>(
    () => CharacterDetailViewModel(repository: getIt<RickMortyRepository>()),
  );
  getIt.registerFactory<LocationListViewModel>(
    () => LocationListViewModel(repository: getIt<RickMortyRepository>()),
  );
  getIt.registerFactory<LocationDetailViewModel>(
    () => LocationDetailViewModel(repository: getIt<RickMortyRepository>()),
  );
  getIt.registerFactory<EpisodeListViewModel>(
    () => EpisodeListViewModel(repository: getIt<RickMortyRepository>()),
  );
  getIt.registerFactory<EpisodeDetailViewModel>(
    () => EpisodeDetailViewModel(repository: getIt<RickMortyRepository>()),
  );
  getIt.registerFactory<SeasonDetailViewModel>(
    () => SeasonDetailViewModel(repository: getIt<RickMortyRepository>()),
  );
}
