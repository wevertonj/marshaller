// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Marshaller';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementos',
      one: '1 elemento',
      zero: 'Ningún elemento',
    );
    return '$_temp0';
  }

  @override
  String get errorGeneric => 'Ocurrió un error. Inténtelo de nuevo.';

  @override
  String get errorNetwork => 'Sin conexión a Internet';

  @override
  String get errorUnauthorized => 'Sesión expirada. Inicie sesión nuevamente.';

  @override
  String get errorTimeout => 'Tiempo de conexión agotado';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get loading => 'Cargando...';

  @override
  String get retry => 'Intentar de nuevo';

  @override
  String get close => 'Cerrar';

  @override
  String get continue_ => 'Continuar';

  @override
  String get back => 'Volver';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String get info => 'Información';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get home => 'Inicio';

  @override
  String get settings => 'Configuración';

  @override
  String get goodMorning => 'Buenos días';

  @override
  String get goodAfternoon => 'Buenas tardes';

  @override
  String get goodEvening => 'Buenas noches';

  @override
  String get goodNight => 'Buenas noches';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get systemMode => 'Predeterminado del sistema';

  @override
  String get keyNotFound => 'Clave de traducción no encontrada';

  @override
  String get storageError => 'Error al acceder al almacenamiento seguro';

  @override
  String get deviceInfoError => 'Error al obtener información del dispositivo';

  @override
  String get preferences => 'Preferencias';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get about => 'Acerca de';

  @override
  String get version => 'Versión';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get openSourceLicenses => 'Licencias de código abierto';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get creditsDescription =>
      'Esta aplicación utiliza datos de la API pública de Rick y Morty.';

  @override
  String get creditsDevelopedBy => 'Desarrollado por ';

  @override
  String get creditsUsingDataFrom => ' usando datos de ';

  @override
  String get creditsApiSource => 'API: rickandmortyapi.com';

  @override
  String get creditsImagesSource => 'Imágenes: Adult Swim';

  @override
  String get lottieFilesSource => 'Animaciones: LottieFiles';

  @override
  String get colorGreen => 'Verde';

  @override
  String get colorBlue => 'Azul';

  @override
  String get colorPurple => 'Púrpura';

  @override
  String get colorOrange => 'Naranja';

  @override
  String get colorRed => 'Rojo';

  @override
  String get colorTeal => 'Verde azulado';

  @override
  String get colorPink => 'Rosa';

  @override
  String get themeColor => 'Color del tema';

  @override
  String get themeSelect => 'Seleccione un tema';

  @override
  String get characters => 'Personajes';

  @override
  String get locations => 'Ubicaciones';

  @override
  String get episodes => 'Episodios';

  @override
  String get search => 'Buscar';

  @override
  String get searchCharacters => 'Buscar personajes';

  @override
  String get searchLocations => 'Buscar ubicaciones';

  @override
  String get searchEpisodes => 'Buscar episodios';

  @override
  String get noResults => 'No se encontraron resultados';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get filters => 'Filtros';

  @override
  String get clearFilters => 'Limpiar filtros';

  @override
  String get applyFilters => 'Aplicar filtros';

  @override
  String get status => 'Estado';

  @override
  String get species => 'Especie';

  @override
  String get gender => 'Género';

  @override
  String get type => 'Tipo';

  @override
  String get dimension => 'Dimensión';

  @override
  String get origin => 'Origen';

  @override
  String get location => 'Ubicación';

  @override
  String get episode => 'Episodio';

  @override
  String get character => 'Personaje';

  @override
  String get statusAlive => 'Vivo';

  @override
  String get statusDead => 'Muerto';

  @override
  String get statusUnknown => 'Desconocido';

  @override
  String get genderMale => 'Masculino';

  @override
  String get genderFemale => 'Femenino';

  @override
  String get genderGenderless => 'Sin género';

  @override
  String get genderUnknown => 'Desconocido';

  @override
  String get speciesHuman => 'Humano';

  @override
  String get speciesAlien => 'Alienígena';

  @override
  String get speciesHumanoid => 'Humanoide';

  @override
  String get speciesPoopybutthole => 'Poopybutthole';

  @override
  String get speciesMythologicalCreature => 'Criatura mitológica';

  @override
  String get speciesAnimal => 'Animal';

  @override
  String get speciesRobot => 'Robot';

  @override
  String get speciesCronenberg => 'Cronenberg';

  @override
  String get speciesDisease => 'Enfermedad';

  @override
  String get speciesUnknown => 'Desconocido';

  @override
  String get locationTypePlanet => 'Planeta';

  @override
  String get locationTypeCluster => 'Grupo';

  @override
  String get locationTypeSpaceStation => 'Estación espacial';

  @override
  String get locationTypeMicroverse => 'Microverso';

  @override
  String get locationTypeTv => 'TV';

  @override
  String get locationTypeResort => 'Resort';

  @override
  String get locationTypeFantasyTown => 'Pueblo Fantástico';

  @override
  String get locationTypeDream => 'Sueño';

  @override
  String get locationTypeDimension => 'Dimensión';

  @override
  String get locationTypeUnknown => 'Desconocido';

  @override
  String get locationTypeMenagerie => 'Menagerie';

  @override
  String get locationTypeGame => 'Juego';

  @override
  String get locationTypeCustoms => 'Aduana';

  @override
  String get locationTypeDeadworld => 'Mundo muerto';

  @override
  String get locationTypeArcade => 'Arcade';

  @override
  String get locationTypeSpacecraft => 'Nave Espacial';

  @override
  String get locationTypeArtificiallyGenerated => 'Generado artificialmente';

  @override
  String get locationTypeMachine => 'Máquina';

  @override
  String get locationTypeAsteriod => 'Asteroide';

  @override
  String get locationTypeBox => 'Caja';

  @override
  String get locationTypeElemental => 'Elemental';

  @override
  String get locationTypeMemory => 'Memoria';

  @override
  String get locationTypeMount => 'Montaña';

  @override
  String get locationTypeNonDiegeticAlternateReality =>
      'Realidad alternativa no diegética';

  @override
  String get locationTypePoliceStation => 'Estación de Policía';

  @override
  String get locationTypeQuadrant => 'Cuadrante';

  @override
  String get locationTypeReality => 'Realidad';

  @override
  String get locationTypeTeenyverse => 'Teenyverse';

  @override
  String get characterTypeHuman => 'Humano';

  @override
  String get characterTypeRobot => 'Robot';

  @override
  String get characterTypeAlien => 'Alienígena';

  @override
  String get characterTypeHumanoid => 'Humanoide';

  @override
  String get characterTypeUnknown => 'Desconocido';

  @override
  String get characterTypeParasite => 'Parásito';

  @override
  String get characterTypeMytholog => 'Mitológico';

  @override
  String get characterTypeSuperhuman => 'Superhumano';

  @override
  String get characterTypeAnimal => 'Animal';

  @override
  String get characterTypeDisease => 'Enfermedad';

  @override
  String get characterTypeCronenberg => 'Cronenberg';

  @override
  String get characterTypeMicroorganism => 'Microorganismo';

  @override
  String appearsInEpisodes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Aparece en $count episodios',
      one: 'Aparece en 1 episodio',
    );
    return '$_temp0';
  }

  @override
  String residentsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count residentes',
      one: '1 residente',
      zero: 'Ningún residente',
    );
    return '$_temp0';
  }

  @override
  String charactersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count personajes',
      one: '1 personaje',
      zero: 'Ningún personaje',
    );
    return '$_temp0';
  }

  @override
  String locationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ubicaciones',
      one: '1 ubicación',
      zero: 'Ninguna ubicación',
    );
    return '$_temp0';
  }

  @override
  String episodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count episodios',
      one: '1 episodio',
      zero: 'Sin episodios',
    );
    return '$_temp0';
  }

  @override
  String get noEpisodesFound => 'No se encontraron episodios';

  @override
  String get noResidentsFound => 'No se encontraron residentes';

  @override
  String get noCharactersFound => 'No se encontraron personajes';

  @override
  String get airDate => 'Fecha de Emisión';

  @override
  String seasonEpisode(String season, String episode) {
    return 'T${season}E$episode';
  }

  @override
  String get unknownLocation => 'Ubicación desconocida';

  @override
  String get unknownOrigin => 'Origen desconocido';

  @override
  String get firstAppearedIn => 'Primera aparición en';

  @override
  String get lastKnownLocation => 'Última ubicación conocida';

  @override
  String get details => 'Detalles';

  @override
  String get share => 'Compartir';

  @override
  String get favorites => 'Favoritos';

  @override
  String get addToFavorites => 'Añadir a favoritos';

  @override
  String get removeFromFavorites => 'Eliminar de favoritos';

  @override
  String get noFavoritesYet => 'Aún no hay favoritos';

  @override
  String get residents => 'Residentes';

  @override
  String get appearancesTab => 'Apariciones';

  @override
  String get infoTab => 'Info';

  @override
  String get created => 'Creado el';

  @override
  String get all => 'Todos';

  @override
  String get credits => 'Créditos';

  @override
  String get security => 'Seguridad';

  @override
  String get logoutConfirmation => '¿Realmente desea cerrar sesión?';

  @override
  String get logoutConfirmationMessage =>
      'Necesitará iniciar sesión nuevamente para acceder a la aplicación.';

  @override
  String get appearance => 'Apariencia';

  @override
  String get account => 'Cuenta';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountConfirmation =>
      '¿Está seguro de que desea eliminar su cuenta?';

  @override
  String get deleteAccountWarning =>
      'Esta acción es irreversible. Todos sus datos se perderán.';

  @override
  String get charactersNotFoundMessage =>
      'No se encontraron personajes con los filtros aplicados';

  @override
  String get locationsNotFoundMessage =>
      'No se encontraron ubicaciones con los filtros aplicados';

  @override
  String get episodesNotFoundMessage =>
      'No se encontraron episodios con los filtros aplicados';

  @override
  String get loadMore => 'Cargar más';

  @override
  String get endOfList => 'Fin de la lista';

  @override
  String get noMoreItems => 'No hay más elementos';

  @override
  String get swipeToRefresh => 'Deslice para actualizar';

  @override
  String get refresh => 'Actualizar';

  @override
  String get seeAll => 'Ver todos';

  @override
  String get seeMore => 'Ver más';

  @override
  String get seeLess => 'Ver menos';

  @override
  String get name => 'Nombre';

  @override
  String get nameRequired => 'El nombre es obligatorio';

  @override
  String get confirmPasswordRequired =>
      'La confirmación de contraseña es obligatoria';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get successfullyRegistered => '¡Registro realizado con éxito!';

  @override
  String get successfullyLoggedIn => '¡Inicio de sesión realizado con éxito!';

  @override
  String get invalidCredentials => 'Credenciales no válidas';

  @override
  String get accountCreated => 'Cuenta creada con éxito';

  @override
  String get errorCreatingAccount => 'Error al crear cuenta';

  @override
  String get portuguese => 'Portugués';

  @override
  String get english => 'Inglés';

  @override
  String get spanish => 'Español';

  @override
  String get invalidName => 'Nombre no válido';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get passwordMustHaveLowercase =>
      'La contraseña debe tener al menos una letra minúscula';

  @override
  String get passwordMustHaveUppercase =>
      'La contraseña debe tener al menos una letra mayúscula';

  @override
  String get passwordMustHaveNumber =>
      'La contraseña debe tener al menos un número';

  @override
  String get passwordMustHaveSpecialCharacter =>
      'La contraseña debe tener al menos un carácter especial';

  @override
  String get invalidBirthDate => 'Fecha de nacimiento no válida';

  @override
  String get tooOldBirthDate => 'Fecha de nacimiento demasiado antigua';

  @override
  String get mode => 'Modo';

  @override
  String get modeSelect => 'Seleccionar Modo';

  @override
  String get systemDefault => 'Predeterminado del Sistema';

  @override
  String get allNotifications => 'Todas las Notificaciones';

  @override
  String get allNotificationsDescription =>
      'Habilitar o deshabilitar todas las notificaciones';

  @override
  String get generalNotifications => 'Notificaciones Generales';

  @override
  String get generalNotificationsDescription =>
      'Reciba actualizaciones y noticias generales de la aplicación';

  @override
  String get promotionalNotifications => 'Notificaciones Promocionales';

  @override
  String get promotionalNotificationsDescription =>
      'Reciba ofertas especiales y promociones';

  @override
  String get errorSaving => 'Error al guardar';

  @override
  String get lottieSimpleLicense => 'Licencia Simple de Lottie';

  @override
  String get thirdPartyAssets => 'Recursos de Terceros';

  @override
  String get thirdPartyLibraries => 'Bibliotecas de Terceros';

  @override
  String get license => 'Licencia';

  @override
  String get source => 'Fuente';

  @override
  String get exploreRickAndMorty => 'Explora el universo de Rick y Morty';

  @override
  String get charactersDescription =>
      'Descubre todos los personajes del programa';

  @override
  String get locationsDescription => 'Explora las ubicaciones del multiverso';

  @override
  String get episodesDescription =>
      'Todos los episodios de todas las temporadas';

  @override
  String get welcomeDescription =>
      'Explora el universo de Rick y Morty y descubre todos los personajes, ubicaciones y episodios';

  @override
  String get characterDetails => 'Detalles del Personaje';

  @override
  String get genderless => 'Sin Género';

  @override
  String get characterTypeGeneticExperiment => 'Experimento Genético';

  @override
  String get characterTypeHumanWithAntennae => 'Humano con Antenas';

  @override
  String get characterTypeHumanWithAntsBrain =>
      'Humano con Cerebro de Hormigas';

  @override
  String get characterTypeGame => 'Juego';

  @override
  String get characterTypeClone => 'Clon';

  @override
  String get characterTypeSelfAware => 'Autoconsciente';

  @override
  String get characterTypeCyborg => 'Cyborg';

  @override
  String get characterTypeBirdPerson => 'Persona Pájaro';

  @override
  String get characterTypeCorn => 'Maíz';

  @override
  String get characterTypePickle => 'Pepinillo';

  @override
  String get characterTypeCat => 'Gato';

  @override
  String get characterTypeAnimatedCar => 'Auto Animado';

  @override
  String get colorYellow => 'Amarillo';

  @override
  String get colorBrown => 'Marrón';

  @override
  String get colorGray => 'Gris';

  @override
  String get locationDetails => 'Detalles de Ubicación';

  @override
  String get locationTypeDaycare => 'Guardería';

  @override
  String get locationTypeSpa => 'Spa';

  @override
  String get noLocationsFound => 'No se encontraron ubicaciones';

  @override
  String get episodeDetails => 'Detalles del Episodio';

  @override
  String get information => 'Información';

  @override
  String get welcomeBack => '¡Bienvenido de nuevo!';

  @override
  String get birthDate => 'Fecha de Nacimiento';

  @override
  String get registerSuccess => '¡Cuenta creada exitosamente!';

  @override
  String get enterAgain => 'Ingresar de nuevo';

  @override
  String get loginToContinue => 'Inicie sesión para continuar';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get season => 'Temporada';
}
