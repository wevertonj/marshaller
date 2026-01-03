import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';


abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  String get appTitle;

  String itemCount(int count);

  String get errorGeneric;

  String get errorNetwork;

  String get errorUnauthorized;

  String get errorTimeout;

  String get cancel;

  String get confirm;

  String get save;

  String get delete;

  String get edit;

  String get loading;

  String get retry;

  String get close;

  String get continue_;

  String get back;

  String get ok;

  String get error;

  String get info;

  String get yes;

  String get no;

  String get home;

  String get settings;

  String get goodMorning;

  String get goodAfternoon;

  String get goodEvening;

  String get goodNight;

  String get darkMode;

  String get lightMode;

  String get systemMode;

  String get keyNotFound;

  String get storageError;

  String get deviceInfoError;

  String get preferences;

  String get language;

  String get theme;

  String get about;

  String get version;

  String get privacyPolicy;

  String get termsOfService;

  String get openSourceLicenses;

  String get system;

  String get light;

  String get dark;

  String get creditsDescription;

  String get creditsDevelopedBy;

  String get creditsUsingDataFrom;

  String get creditsApiSource;

  String get creditsImagesSource;

  String get lottieFilesSource;

  String get colorGreen;

  String get colorBlue;

  String get colorPurple;

  String get colorOrange;

  String get colorRed;

  String get colorTeal;

  String get colorPink;

  String get themeColor;

  String get themeSelect;

  String get characters;

  String get locations;

  String get episodes;

  String get search;

  String get searchCharacters;

  String get searchLocations;

  String get searchEpisodes;

  String get noResults;

  String get tryAgain;

  String get filters;

  String get clearFilters;

  String get applyFilters;

  String get status;

  String get species;

  String get gender;

  String get type;

  String get dimension;

  String get origin;

  String get location;

  String get episode;

  String get character;

  String get statusAlive;

  String get statusDead;

  String get statusUnknown;

  String get genderMale;

  String get genderFemale;

  String get genderGenderless;

  String get genderUnknown;

  String get speciesHuman;

  String get speciesAlien;

  String get speciesHumanoid;

  String get speciesPoopybutthole;

  String get speciesMythologicalCreature;

  String get speciesAnimal;

  String get speciesRobot;

  String get speciesCronenberg;

  String get speciesDisease;

  String get speciesUnknown;

  String get locationTypePlanet;

  String get locationTypeCluster;

  String get locationTypeSpaceStation;

  String get locationTypeMicroverse;

  String get locationTypeTv;

  String get locationTypeResort;

  String get locationTypeFantasyTown;

  String get locationTypeDream;

  String get locationTypeDimension;

  String get locationTypeUnknown;

  String get locationTypeMenagerie;

  String get locationTypeGame;

  String get locationTypeCustoms;

  String get locationTypeDeadworld;

  String get locationTypeArcade;

  String get locationTypeSpacecraft;

  String get locationTypeArtificiallyGenerated;

  String get locationTypeMachine;

  String get locationTypeAsteriod;

  String get locationTypeBox;

  String get locationTypeElemental;

  String get locationTypeMemory;

  String get locationTypeMount;

  String get locationTypeNonDiegeticAlternateReality;

  String get locationTypePoliceStation;

  String get locationTypeQuadrant;

  String get locationTypeReality;

  String get locationTypeTeenyverse;

  String get characterTypeHuman;

  String get characterTypeRobot;

  String get characterTypeAlien;

  String get characterTypeHumanoid;

  String get characterTypeUnknown;

  String get characterTypeParasite;

  String get characterTypeMytholog;

  String get characterTypeSuperhuman;

  String get characterTypeAnimal;

  String get characterTypeDisease;

  String get characterTypeCronenberg;

  String get characterTypeMicroorganism;

  String appearsInEpisodes(int count);

  String residentsCount(int count);

  String charactersCount(int count);

  String locationsCount(int count);

  String episodesCount(int count);

  String get noEpisodesFound;

  String get noResidentsFound;

  String get noCharactersFound;

  String get airDate;

  String seasonEpisode(String season, String episode);

  String get unknownLocation;

  String get unknownOrigin;

  String get firstAppearedIn;

  String get lastKnownLocation;

  String get details;

  String get share;

  String get favorites;

  String get addToFavorites;

  String get removeFromFavorites;

  String get noFavoritesYet;

  String get residents;

  String get appearancesTab;

  String get infoTab;

  String get created;

  String get all;

  String get credits;

  String get security;

  String get logoutConfirmation;

  String get logoutConfirmationMessage;

  String get appearance;

  String get account;

  String get deleteAccount;

  String get deleteAccountConfirmation;

  String get deleteAccountWarning;

  String get charactersNotFoundMessage;

  String get locationsNotFoundMessage;

  String get episodesNotFoundMessage;

  String get loadMore;

  String get endOfList;

  String get noMoreItems;

  String get swipeToRefresh;

  String get refresh;

  String get seeAll;

  String get seeMore;

  String get seeLess;

  String get name;

  String get nameRequired;

  String get confirmPasswordRequired;

  String get passwordsDoNotMatch;

  String get successfullyRegistered;

  String get successfullyLoggedIn;

  String get invalidCredentials;

  String get accountCreated;

  String get errorCreatingAccount;

  String get portuguese;

  String get english;

  String get spanish;

  String get invalidName;

  String get passwordMinLength;

  String get passwordMustHaveLowercase;

  String get passwordMustHaveUppercase;

  String get passwordMustHaveNumber;

  String get passwordMustHaveSpecialCharacter;

  String get invalidBirthDate;

  String get tooOldBirthDate;

  String get mode;

  String get modeSelect;

  String get systemDefault;

  String get allNotifications;

  String get allNotificationsDescription;

  String get generalNotifications;

  String get generalNotificationsDescription;

  String get promotionalNotifications;

  String get promotionalNotificationsDescription;

  String get errorSaving;

  String get lottieSimpleLicense;

  String get thirdPartyAssets;

  String get thirdPartyLibraries;

  String get license;

  String get source;

  String get exploreRickAndMorty;

  String get charactersDescription;

  String get locationsDescription;

  String get episodesDescription;

  String get welcomeDescription;

  String get characterDetails;

  String get genderless;

  String get characterTypeGeneticExperiment;

  String get characterTypeHumanWithAntennae;

  String get characterTypeHumanWithAntsBrain;

  String get characterTypeGame;

  String get characterTypeClone;

  String get characterTypeSelfAware;

  String get characterTypeCyborg;

  String get characterTypeBirdPerson;

  String get characterTypeCorn;

  String get characterTypePickle;

  String get characterTypeCat;

  String get characterTypeAnimatedCar;

  String get colorYellow;

  String get colorBrown;

  String get colorGray;

  String get locationDetails;

  String get locationTypeDaycare;

  String get locationTypeSpa;

  String get noLocationsFound;

  String get episodeDetails;

  String get information;

  String get welcomeBack;

  String get birthDate;

  String get registerSuccess;

  String get enterAgain;

  String get loginToContinue;

  String get nameLabel;

  String get season;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
