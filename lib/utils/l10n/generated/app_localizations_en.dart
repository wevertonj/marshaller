// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Marshaller';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get errorGeneric => 'An error occurred. Please try again.';

  @override
  String get errorNetwork => 'No internet connection';

  @override
  String get errorUnauthorized => 'Session expired. Please sign in again.';

  @override
  String get errorTimeout => 'Connection timed out';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get loading => 'Loading...';

  @override
  String get retry => 'Try Again';

  @override
  String get close => 'Close';

  @override
  String get continue_ => 'Continue';

  @override
  String get back => 'Back';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String get info => 'Information';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get goodAfternoon => 'Good afternoon';

  @override
  String get goodEvening => 'Good evening';

  @override
  String get goodNight => 'Good night';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get systemMode => 'System';

  @override
  String get keyNotFound => 'Translation key not found';

  @override
  String get storageError => 'Error accessing secure storage';

  @override
  String get deviceInfoError => 'Error getting device information';

  @override
  String get preferences => 'Preferences';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get openSourceLicenses => 'Open Source Licenses';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get creditsDescription =>
      'This app uses data from the Rick and Morty public API.';

  @override
  String get creditsDevelopedBy => 'Developed by ';

  @override
  String get creditsUsingDataFrom => ' using data from ';

  @override
  String get creditsApiSource => 'API: rickandmortyapi.com';

  @override
  String get creditsImagesSource => 'Images: Adult Swim';

  @override
  String get lottieFilesSource => 'Animations: LottieFiles';

  @override
  String get colorGreen => 'Green';

  @override
  String get colorBlue => 'Blue';

  @override
  String get colorPurple => 'Purple';

  @override
  String get colorOrange => 'Orange';

  @override
  String get colorRed => 'Red';

  @override
  String get colorTeal => 'Teal';

  @override
  String get colorPink => 'Pink';

  @override
  String get themeColor => 'Theme Color';

  @override
  String get themeSelect => 'Select a theme';

  @override
  String get characters => 'Characters';

  @override
  String get locations => 'Locations';

  @override
  String get episodes => 'Episodes';

  @override
  String get search => 'Search';

  @override
  String get searchCharacters => 'Search characters';

  @override
  String get searchLocations => 'Search locations';

  @override
  String get searchEpisodes => 'Search episodes';

  @override
  String get noResults => 'No results found';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get filters => 'Filters';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get status => 'Status';

  @override
  String get species => 'Species';

  @override
  String get gender => 'Gender';

  @override
  String get type => 'Type';

  @override
  String get dimension => 'Dimension';

  @override
  String get origin => 'Origin';

  @override
  String get location => 'Location';

  @override
  String get episode => 'Episode';

  @override
  String get character => 'Character';

  @override
  String get statusAlive => 'Alive';

  @override
  String get statusDead => 'Dead';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderGenderless => 'Genderless';

  @override
  String get genderUnknown => 'Unknown';

  @override
  String get speciesHuman => 'Human';

  @override
  String get speciesAlien => 'Alien';

  @override
  String get speciesHumanoid => 'Humanoid';

  @override
  String get speciesPoopybutthole => 'Poopybutthole';

  @override
  String get speciesMythologicalCreature => 'Mythological Creature';

  @override
  String get speciesAnimal => 'Animal';

  @override
  String get speciesRobot => 'Robot';

  @override
  String get speciesCronenberg => 'Cronenberg';

  @override
  String get speciesDisease => 'Disease';

  @override
  String get speciesUnknown => 'Unknown';

  @override
  String get locationTypePlanet => 'Planet';

  @override
  String get locationTypeCluster => 'Cluster';

  @override
  String get locationTypeSpaceStation => 'Space Station';

  @override
  String get locationTypeMicroverse => 'Microverse';

  @override
  String get locationTypeTv => 'TV';

  @override
  String get locationTypeResort => 'Resort';

  @override
  String get locationTypeFantasyTown => 'Fantasy Town';

  @override
  String get locationTypeDream => 'Dream';

  @override
  String get locationTypeDimension => 'Dimension';

  @override
  String get locationTypeUnknown => 'Unknown';

  @override
  String get locationTypeMenagerie => 'Menagerie';

  @override
  String get locationTypeGame => 'Game';

  @override
  String get locationTypeCustoms => 'Customs';

  @override
  String get locationTypeDeadworld => 'Dead World';

  @override
  String get locationTypeArcade => 'Arcade';

  @override
  String get locationTypeSpacecraft => 'Spacecraft';

  @override
  String get locationTypeArtificiallyGenerated =>
      'Artificially Generated World';

  @override
  String get locationTypeMachine => 'Machine';

  @override
  String get locationTypeAsteriod => 'Asteroid';

  @override
  String get locationTypeBox => 'Box';

  @override
  String get locationTypeElemental => 'Elemental';

  @override
  String get locationTypeMemory => 'Memory';

  @override
  String get locationTypeMount => 'Mount';

  @override
  String get locationTypeNonDiegeticAlternateReality =>
      'Non-Diegetic Alternate Reality';

  @override
  String get locationTypePoliceStation => 'Police Station';

  @override
  String get locationTypeQuadrant => 'Quadrant';

  @override
  String get locationTypeReality => 'Reality';

  @override
  String get locationTypeTeenyverse => 'Teenyverse';

  @override
  String get characterTypeHuman => 'Human';

  @override
  String get characterTypeRobot => 'Robot';

  @override
  String get characterTypeAlien => 'Alien';

  @override
  String get characterTypeHumanoid => 'Humanoid';

  @override
  String get characterTypeUnknown => 'Unknown';

  @override
  String get characterTypeParasite => 'Parasite';

  @override
  String get characterTypeMytholog => 'Mythological';

  @override
  String get characterTypeSuperhuman => 'Superhuman';

  @override
  String get characterTypeAnimal => 'Animal';

  @override
  String get characterTypeDisease => 'Disease';

  @override
  String get characterTypeCronenberg => 'Cronenberg';

  @override
  String get characterTypeMicroorganism => 'Microorganism';

  @override
  String appearsInEpisodes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Appears in $count episodes',
      one: 'Appears in 1 episode',
    );
    return '$_temp0';
  }

  @override
  String residentsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count residents',
      one: '1 resident',
      zero: 'No residents',
    );
    return '$_temp0';
  }

  @override
  String charactersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count characters',
      one: '1 character',
      zero: 'No characters',
    );
    return '$_temp0';
  }

  @override
  String locationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count locations',
      one: '1 location',
      zero: 'No locations',
    );
    return '$_temp0';
  }

  @override
  String episodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count episodes',
      one: '1 episode',
      zero: 'No episodes',
    );
    return '$_temp0';
  }

  @override
  String get noEpisodesFound => 'No episodes found';

  @override
  String get noResidentsFound => 'No residents found';

  @override
  String get noCharactersFound => 'No characters found';

  @override
  String get airDate => 'Air Date';

  @override
  String seasonEpisode(String season, String episode) {
    return 'S${season}E$episode';
  }

  @override
  String get unknownLocation => 'Unknown Location';

  @override
  String get unknownOrigin => 'Unknown Origin';

  @override
  String get firstAppearedIn => 'First appeared in';

  @override
  String get lastKnownLocation => 'Last Known Location';

  @override
  String get details => 'Details';

  @override
  String get share => 'Share';

  @override
  String get favorites => 'Favorites';

  @override
  String get addToFavorites => 'Add to Favorites';

  @override
  String get removeFromFavorites => 'Remove from Favorites';

  @override
  String get noFavoritesYet => 'No favorites yet';

  @override
  String get residents => 'Residents';

  @override
  String get appearancesTab => 'Appearances';

  @override
  String get infoTab => 'Info';

  @override
  String get created => 'Created';

  @override
  String get all => 'All';

  @override
  String get credits => 'Credits';

  @override
  String get security => 'Security';

  @override
  String get logoutConfirmation => 'Are you sure you want to sign out?';

  @override
  String get logoutConfirmationMessage =>
      'You will need to sign in again to access the app.';

  @override
  String get appearance => 'Appearance';

  @override
  String get account => 'Account';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirmation =>
      'Are you sure you want to delete your account?';

  @override
  String get deleteAccountWarning =>
      'This action is irreversible. All your data will be lost.';

  @override
  String get charactersNotFoundMessage =>
      'No characters found with the applied filters';

  @override
  String get locationsNotFoundMessage =>
      'No locations found with the applied filters';

  @override
  String get episodesNotFoundMessage =>
      'No episodes found with the applied filters';

  @override
  String get loadMore => 'Load More';

  @override
  String get endOfList => 'End of list';

  @override
  String get noMoreItems => 'No more items';

  @override
  String get swipeToRefresh => 'Swipe to refresh';

  @override
  String get refresh => 'Refresh';

  @override
  String get seeAll => 'See All';

  @override
  String get seeMore => 'See More';

  @override
  String get seeLess => 'See Less';

  @override
  String get name => 'Name';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get confirmPasswordRequired => 'Password confirmation is required';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get successfullyRegistered => 'Successfully registered!';

  @override
  String get successfullyLoggedIn => 'Successfully logged in!';

  @override
  String get invalidCredentials => 'Invalid credentials';

  @override
  String get accountCreated => 'Account created successfully';

  @override
  String get errorCreatingAccount => 'Error creating account';

  @override
  String get portuguese => 'Portuguese';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Spanish';

  @override
  String get invalidName => 'Invalid name';

  @override
  String get passwordMinLength => 'Password must have at least 8 characters';

  @override
  String get passwordMustHaveLowercase =>
      'Password must have at least one lowercase letter';

  @override
  String get passwordMustHaveUppercase =>
      'Password must have at least one uppercase letter';

  @override
  String get passwordMustHaveNumber => 'Password must have at least one number';

  @override
  String get passwordMustHaveSpecialCharacter =>
      'Password must have at least one special character';

  @override
  String get invalidBirthDate => 'Invalid birth date';

  @override
  String get tooOldBirthDate => 'Birth date is too old';

  @override
  String get mode => 'Mode';

  @override
  String get modeSelect => 'Select Mode';

  @override
  String get systemDefault => 'System Default';

  @override
  String get allNotifications => 'All Notifications';

  @override
  String get allNotificationsDescription =>
      'Enable or disable all notifications';

  @override
  String get generalNotifications => 'General Notifications';

  @override
  String get generalNotificationsDescription =>
      'Receive general app updates and news';

  @override
  String get promotionalNotifications => 'Promotional Notifications';

  @override
  String get promotionalNotificationsDescription =>
      'Receive special offers and promotions';

  @override
  String get errorSaving => 'Error saving';

  @override
  String get lottieSimpleLicense => 'Lottie Simple License';

  @override
  String get thirdPartyAssets => 'Third-Party Assets';

  @override
  String get thirdPartyLibraries => 'Third-Party Libraries';

  @override
  String get license => 'License';

  @override
  String get source => 'Source';

  @override
  String get exploreRickAndMorty => 'Explore the Rick and Morty universe';

  @override
  String get charactersDescription => 'Discover all characters from the show';

  @override
  String get locationsDescription => 'Explore the multiverse locations';

  @override
  String get episodesDescription => 'All episodes from every season';

  @override
  String get welcomeDescription =>
      'Explore the Rick and Morty universe and discover all characters, locations, and episodes';

  @override
  String get characterDetails => 'Character Details';

  @override
  String get genderless => 'Genderless';

  @override
  String get characterTypeGeneticExperiment => 'Genetic Experiment';

  @override
  String get characterTypeHumanWithAntennae => 'Human with Antennae';

  @override
  String get characterTypeHumanWithAntsBrain => 'Human with Ants Brain';

  @override
  String get characterTypeGame => 'Game';

  @override
  String get characterTypeClone => 'Clone';

  @override
  String get characterTypeSelfAware => 'Self-Aware';

  @override
  String get characterTypeCyborg => 'Cyborg';

  @override
  String get characterTypeBirdPerson => 'Bird-Person';

  @override
  String get characterTypeCorn => 'Corn';

  @override
  String get characterTypePickle => 'Pickle';

  @override
  String get characterTypeCat => 'Cat';

  @override
  String get characterTypeAnimatedCar => 'Animated Car';

  @override
  String get colorYellow => 'Yellow';

  @override
  String get colorBrown => 'Brown';

  @override
  String get colorGray => 'Gray';

  @override
  String get locationDetails => 'Location Details';

  @override
  String get locationTypeDaycare => 'Daycare';

  @override
  String get locationTypeSpa => 'Spa';

  @override
  String get noLocationsFound => 'No locations found';

  @override
  String get episodeDetails => 'Episode Details';

  @override
  String get information => 'Information';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get birthDate => 'Date of Birth';

  @override
  String get registerSuccess => 'Account created successfully!';

  @override
  String get enterAgain => 'Enter again';

  @override
  String get loginToContinue => 'Login to continue';

  @override
  String get nameLabel => 'Name';

  @override
  String get season => 'Season';
}
