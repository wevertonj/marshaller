import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// Título do aplicativo
  ///
  /// In pt, this message translates to:
  /// **'Marshaller'**
  String get appTitle;

  /// Contador de itens com plural
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Nenhum item} =1{1 item} other{{count} itens}}'**
  String itemCount(int count);

  /// Mensagem de erro genérico
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro. Tente novamente.'**
  String get errorGeneric;

  /// Mensagem de erro de conexão
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão com a internet'**
  String get errorNetwork;

  /// Mensagem de erro de sessão expirada
  ///
  /// In pt, this message translates to:
  /// **'Sessão expirada. Faça login novamente.'**
  String get errorUnauthorized;

  /// Mensagem de erro de timeout
  ///
  /// In pt, this message translates to:
  /// **'Tempo de conexão esgotado'**
  String get errorTimeout;

  /// Texto do botão cancelar
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// Texto do botão confirmar
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confirm;

  /// Texto do botão salvar
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get save;

  /// Texto do botão excluir
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get delete;

  /// Texto do botão editar
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get edit;

  /// Texto de loading
  ///
  /// In pt, this message translates to:
  /// **'Carregando...'**
  String get loading;

  /// Texto do botão retry
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get retry;

  /// Texto do botão fechar
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get close;

  /// Texto do botão continuar
  ///
  /// In pt, this message translates to:
  /// **'Continuar'**
  String get continue_;

  /// Texto do botão voltar
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get back;

  /// Texto do botão OK
  ///
  /// In pt, this message translates to:
  /// **'OK'**
  String get ok;

  /// Título de erro
  ///
  /// In pt, this message translates to:
  /// **'Erro'**
  String get error;

  /// Título de informação
  ///
  /// In pt, this message translates to:
  /// **'Informação'**
  String get info;

  /// Texto do botão sim
  ///
  /// In pt, this message translates to:
  /// **'Sim'**
  String get yes;

  /// Texto do botão não
  ///
  /// In pt, this message translates to:
  /// **'Não'**
  String get no;

  /// Título da tela inicial
  ///
  /// In pt, this message translates to:
  /// **'Início'**
  String get home;

  /// Título da tela de configurações
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settings;

  /// Saudação da manhã
  ///
  /// In pt, this message translates to:
  /// **'Bom dia'**
  String get goodMorning;

  /// Saudação da tarde
  ///
  /// In pt, this message translates to:
  /// **'Boa tarde'**
  String get goodAfternoon;

  /// Saudação da noite
  ///
  /// In pt, this message translates to:
  /// **'Boa noite'**
  String get goodEvening;

  /// Saudação da noite (despedida ou tardia)
  ///
  /// In pt, this message translates to:
  /// **'Boa noite'**
  String get goodNight;

  /// Opção de tema escuro
  ///
  /// In pt, this message translates to:
  /// **'Modo Escuro'**
  String get darkMode;

  /// Opção de tema claro
  ///
  /// In pt, this message translates to:
  /// **'Modo Claro'**
  String get lightMode;

  /// Opção de tema do sistema
  ///
  /// In pt, this message translates to:
  /// **'Padrão do Sistema'**
  String get systemMode;

  /// Erro quando chave de tradução não existe
  ///
  /// In pt, this message translates to:
  /// **'Chave de tradução não encontrada'**
  String get keyNotFound;

  /// Erro de armazenamento
  ///
  /// In pt, this message translates to:
  /// **'Erro ao acessar armazenamento seguro'**
  String get storageError;

  /// Erro ao obter info do dispositivo
  ///
  /// In pt, this message translates to:
  /// **'Erro ao obter informações do dispositivo'**
  String get deviceInfoError;

  /// Título da seção de preferências
  ///
  /// In pt, this message translates to:
  /// **'Preferências'**
  String get preferences;

  /// Opção de idioma
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get language;

  /// Opção de tema
  ///
  /// In pt, this message translates to:
  /// **'Tema'**
  String get theme;

  /// Opção sobre o app
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get about;

  /// Label da versão
  ///
  /// In pt, this message translates to:
  /// **'Versão'**
  String get version;

  /// Link para política de privacidade
  ///
  /// In pt, this message translates to:
  /// **'Política de Privacidade'**
  String get privacyPolicy;

  /// Link para termos de serviço
  ///
  /// In pt, this message translates to:
  /// **'Termos de Serviço'**
  String get termsOfService;

  /// Link para licenças open source
  ///
  /// In pt, this message translates to:
  /// **'Licenças Open Source'**
  String get openSourceLicenses;

  /// Opção sistema
  ///
  /// In pt, this message translates to:
  /// **'Sistema'**
  String get system;

  /// Opção tema claro
  ///
  /// In pt, this message translates to:
  /// **'Claro'**
  String get light;

  /// Opção tema escuro
  ///
  /// In pt, this message translates to:
  /// **'Escuro'**
  String get dark;

  /// Descrição dos créditos
  ///
  /// In pt, this message translates to:
  /// **'Este app utiliza dados da API pública de Rick and Morty.'**
  String get creditsDescription;

  /// Prefixo para crédito do desenvolvedor
  ///
  /// In pt, this message translates to:
  /// **'Desenvolvido por '**
  String get creditsDevelopedBy;

  /// Conector para crédito da API
  ///
  /// In pt, this message translates to:
  /// **' usando dados de '**
  String get creditsUsingDataFrom;

  /// Fonte da API
  ///
  /// In pt, this message translates to:
  /// **'API: rickandmortyapi.com'**
  String get creditsApiSource;

  /// Fonte das imagens
  ///
  /// In pt, this message translates to:
  /// **'Imagens: Adult Swim'**
  String get creditsImagesSource;

  /// Fonte das animações
  ///
  /// In pt, this message translates to:
  /// **'Animações: LottieFiles'**
  String get lottieFilesSource;

  /// Cor verde
  ///
  /// In pt, this message translates to:
  /// **'Verde'**
  String get colorGreen;

  /// Cor azul
  ///
  /// In pt, this message translates to:
  /// **'Azul'**
  String get colorBlue;

  /// Cor roxa
  ///
  /// In pt, this message translates to:
  /// **'Roxo'**
  String get colorPurple;

  /// Cor laranja
  ///
  /// In pt, this message translates to:
  /// **'Laranja'**
  String get colorOrange;

  /// Cor vermelha
  ///
  /// In pt, this message translates to:
  /// **'Vermelho'**
  String get colorRed;

  /// Cor verde-azulado
  ///
  /// In pt, this message translates to:
  /// **'Verde-azulado'**
  String get colorTeal;

  /// Cor rosa
  ///
  /// In pt, this message translates to:
  /// **'Rosa'**
  String get colorPink;

  /// Opção de cor do tema
  ///
  /// In pt, this message translates to:
  /// **'Cor do Tema'**
  String get themeColor;

  /// Instrução para selecionar tema
  ///
  /// In pt, this message translates to:
  /// **'Selecione um tema'**
  String get themeSelect;

  /// Título da seção de personagens
  ///
  /// In pt, this message translates to:
  /// **'Personagens'**
  String get characters;

  /// Título da seção de localizações
  ///
  /// In pt, this message translates to:
  /// **'Localizações'**
  String get locations;

  /// Título da seção de episódios
  ///
  /// In pt, this message translates to:
  /// **'Episódios'**
  String get episodes;

  /// Placeholder de busca
  ///
  /// In pt, this message translates to:
  /// **'Buscar'**
  String get search;

  /// Placeholder de busca de personagens
  ///
  /// In pt, this message translates to:
  /// **'Buscar personagens'**
  String get searchCharacters;

  /// Placeholder de busca de localizações
  ///
  /// In pt, this message translates to:
  /// **'Buscar localizações'**
  String get searchLocations;

  /// Placeholder de busca de episódios
  ///
  /// In pt, this message translates to:
  /// **'Buscar episódios'**
  String get searchEpisodes;

  /// Mensagem quando não há resultados
  ///
  /// In pt, this message translates to:
  /// **'Nenhum resultado encontrado'**
  String get noResults;

  /// Botão para tentar novamente
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get tryAgain;

  /// Título de filtros
  ///
  /// In pt, this message translates to:
  /// **'Filtros'**
  String get filters;

  /// Botão para limpar filtros
  ///
  /// In pt, this message translates to:
  /// **'Limpar filtros'**
  String get clearFilters;

  /// Botão para aplicar filtros
  ///
  /// In pt, this message translates to:
  /// **'Aplicar filtros'**
  String get applyFilters;

  /// Label de status
  ///
  /// In pt, this message translates to:
  /// **'Status'**
  String get status;

  /// Label de espécie
  ///
  /// In pt, this message translates to:
  /// **'Espécie'**
  String get species;

  /// Label de gênero
  ///
  /// In pt, this message translates to:
  /// **'Gênero'**
  String get gender;

  /// Label de tipo
  ///
  /// In pt, this message translates to:
  /// **'Tipo'**
  String get type;

  /// Label de dimensão
  ///
  /// In pt, this message translates to:
  /// **'Dimensão'**
  String get dimension;

  /// Label de origem
  ///
  /// In pt, this message translates to:
  /// **'Origem'**
  String get origin;

  /// Label de localização
  ///
  /// In pt, this message translates to:
  /// **'Localização'**
  String get location;

  /// Label de episódio
  ///
  /// In pt, this message translates to:
  /// **'Episódio'**
  String get episode;

  /// Label de personagem
  ///
  /// In pt, this message translates to:
  /// **'Personagem'**
  String get character;

  /// Status vivo
  ///
  /// In pt, this message translates to:
  /// **'Vivo'**
  String get statusAlive;

  /// Status morto
  ///
  /// In pt, this message translates to:
  /// **'Morto'**
  String get statusDead;

  /// Status desconhecido
  ///
  /// In pt, this message translates to:
  /// **'Desconhecido'**
  String get statusUnknown;

  /// Gênero masculino
  ///
  /// In pt, this message translates to:
  /// **'Masculino'**
  String get genderMale;

  /// Gênero feminino
  ///
  /// In pt, this message translates to:
  /// **'Feminino'**
  String get genderFemale;

  /// Sem gênero
  ///
  /// In pt, this message translates to:
  /// **'Sem gênero'**
  String get genderGenderless;

  /// Gênero desconhecido
  ///
  /// In pt, this message translates to:
  /// **'Desconhecido'**
  String get genderUnknown;

  /// Espécie humana
  ///
  /// In pt, this message translates to:
  /// **'Humano'**
  String get speciesHuman;

  /// Espécie alienígena
  ///
  /// In pt, this message translates to:
  /// **'Alienígena'**
  String get speciesAlien;

  /// Espécie humanóide
  ///
  /// In pt, this message translates to:
  /// **'Humanóide'**
  String get speciesHumanoid;

  /// Espécie Poopybutthole
  ///
  /// In pt, this message translates to:
  /// **'Poopybutthole'**
  String get speciesPoopybutthole;

  /// Espécie criatura mitológica
  ///
  /// In pt, this message translates to:
  /// **'Criatura Mitológica'**
  String get speciesMythologicalCreature;

  /// Espécie animal
  ///
  /// In pt, this message translates to:
  /// **'Animal'**
  String get speciesAnimal;

  /// Espécie robô
  ///
  /// In pt, this message translates to:
  /// **'Robô'**
  String get speciesRobot;

  /// Espécie Cronenberg
  ///
  /// In pt, this message translates to:
  /// **'Cronenberg'**
  String get speciesCronenberg;

  /// Espécie doença
  ///
  /// In pt, this message translates to:
  /// **'Doença'**
  String get speciesDisease;

  /// Espécie desconhecida
  ///
  /// In pt, this message translates to:
  /// **'Desconhecido'**
  String get speciesUnknown;

  /// Tipo de localização: Planeta
  ///
  /// In pt, this message translates to:
  /// **'Planeta'**
  String get locationTypePlanet;

  /// Tipo de localização: Grupo
  ///
  /// In pt, this message translates to:
  /// **'Grupo'**
  String get locationTypeCluster;

  /// Tipo de localização: Estação Espacial
  ///
  /// In pt, this message translates to:
  /// **'Estação Espacial'**
  String get locationTypeSpaceStation;

  /// Tipo de localização: Microverso
  ///
  /// In pt, this message translates to:
  /// **'Microverso'**
  String get locationTypeMicroverse;

  /// Tipo de localização: TV
  ///
  /// In pt, this message translates to:
  /// **'TV'**
  String get locationTypeTv;

  /// Tipo de localização: Resort
  ///
  /// In pt, this message translates to:
  /// **'Resort'**
  String get locationTypeResort;

  /// Tipo de localização: Cidade Fantasia
  ///
  /// In pt, this message translates to:
  /// **'Cidade Fantasia'**
  String get locationTypeFantasyTown;

  /// Tipo de localização: Sonho
  ///
  /// In pt, this message translates to:
  /// **'Sonho'**
  String get locationTypeDream;

  /// Tipo de localização: Dimensão
  ///
  /// In pt, this message translates to:
  /// **'Dimensão'**
  String get locationTypeDimension;

  /// Tipo de localização: Desconhecido
  ///
  /// In pt, this message translates to:
  /// **'Desconhecido'**
  String get locationTypeUnknown;

  /// Tipo de localização: Menagerie
  ///
  /// In pt, this message translates to:
  /// **'Menagerie'**
  String get locationTypeMenagerie;

  /// Tipo de localização: Jogo
  ///
  /// In pt, this message translates to:
  /// **'Jogo'**
  String get locationTypeGame;

  /// Tipo de localização: Alfândega
  ///
  /// In pt, this message translates to:
  /// **'Alfândega'**
  String get locationTypeCustoms;

  /// Tipo de localização: Mundo Morto
  ///
  /// In pt, this message translates to:
  /// **'Mundo Morto'**
  String get locationTypeDeadworld;

  /// Tipo de localização: Arcade
  ///
  /// In pt, this message translates to:
  /// **'Arcade'**
  String get locationTypeArcade;

  /// Tipo de localização: Nave Espacial
  ///
  /// In pt, this message translates to:
  /// **'Nave Espacial'**
  String get locationTypeSpacecraft;

  /// Tipo de localização: Gerado Artificialmente
  ///
  /// In pt, this message translates to:
  /// **'Gerado Artificialmente'**
  String get locationTypeArtificiallyGenerated;

  /// Tipo de localização: Máquina
  ///
  /// In pt, this message translates to:
  /// **'Máquina'**
  String get locationTypeMachine;

  /// Tipo de localização: Asteroide
  ///
  /// In pt, this message translates to:
  /// **'Asteroide'**
  String get locationTypeAsteriod;

  /// Tipo de localização: Caixa
  ///
  /// In pt, this message translates to:
  /// **'Caixa'**
  String get locationTypeBox;

  /// Tipo de localização: Elemental
  ///
  /// In pt, this message translates to:
  /// **'Elemental'**
  String get locationTypeElemental;

  /// Tipo de localização: Memória
  ///
  /// In pt, this message translates to:
  /// **'Memória'**
  String get locationTypeMemory;

  /// Tipo de localização: Monte
  ///
  /// In pt, this message translates to:
  /// **'Monte'**
  String get locationTypeMount;

  /// Tipo de localização: Realidade Alternativa Não-Diegética
  ///
  /// In pt, this message translates to:
  /// **'Realidade Alternativa Não-Diegética'**
  String get locationTypeNonDiegeticAlternateReality;

  /// Tipo de localização: Delegacia
  ///
  /// In pt, this message translates to:
  /// **'Delegacia de Polícia'**
  String get locationTypePoliceStation;

  /// Tipo de localização: Quadrante
  ///
  /// In pt, this message translates to:
  /// **'Quadrante'**
  String get locationTypeQuadrant;

  /// Tipo de localização: Realidade
  ///
  /// In pt, this message translates to:
  /// **'Realidade'**
  String get locationTypeReality;

  /// Tipo de localização: Teenyverse
  ///
  /// In pt, this message translates to:
  /// **'Teenyverse'**
  String get locationTypeTeenyverse;

  /// Tipo de personagem: Humano
  ///
  /// In pt, this message translates to:
  /// **'Humano'**
  String get characterTypeHuman;

  /// Tipo de personagem: robô
  ///
  /// In pt, this message translates to:
  /// **'Robô'**
  String get characterTypeRobot;

  /// Tipo de personagem: Alienígena
  ///
  /// In pt, this message translates to:
  /// **'Alienígena'**
  String get characterTypeAlien;

  /// Tipo de personagem: humanóide
  ///
  /// In pt, this message translates to:
  /// **'Humanóide'**
  String get characterTypeHumanoid;

  /// Tipo de personagem: desconhecido
  ///
  /// In pt, this message translates to:
  /// **'Desconhecido'**
  String get characterTypeUnknown;

  /// Tipo de personagem: parasita
  ///
  /// In pt, this message translates to:
  /// **'Parasita'**
  String get characterTypeParasite;

  /// Tipo de personagem: Mitológico
  ///
  /// In pt, this message translates to:
  /// **'Mitológico'**
  String get characterTypeMytholog;

  /// Tipo de personagem: super-humano
  ///
  /// In pt, this message translates to:
  /// **'Super-humano'**
  String get characterTypeSuperhuman;

  /// Tipo de personagem: Animal
  ///
  /// In pt, this message translates to:
  /// **'Animal'**
  String get characterTypeAnimal;

  /// Tipo de personagem: Doença
  ///
  /// In pt, this message translates to:
  /// **'Doença'**
  String get characterTypeDisease;

  /// Tipo de personagem: Cronenberg
  ///
  /// In pt, this message translates to:
  /// **'Cronenberg'**
  String get characterTypeCronenberg;

  /// Tipo de personagem: Microorganismo
  ///
  /// In pt, this message translates to:
  /// **'Microorganismo'**
  String get characterTypeMicroorganism;

  /// Contador de episódios em que o personagem aparece
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{Aparece em 1 episódio} other{Aparece em {count} episódios}}'**
  String appearsInEpisodes(int count);

  /// Contador de residentes de uma localização
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Nenhum residente} =1{1 residente} other{{count} residentes}}'**
  String residentsCount(int count);

  /// Contador de personagens de um episódio
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Nenhum personagem} =1{1 personagem} other{{count} personagens}}'**
  String charactersCount(int count);

  /// Número de locais
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Nenhum local} =1{1 local} other{{count} locais}}'**
  String locationsCount(int count);

  /// Number of episodes in season
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Nenhum episódio} =1{1 episódio} other{{count} episódios}}'**
  String episodesCount(int count);

  /// Mensagem quando não há episódios
  ///
  /// In pt, this message translates to:
  /// **'Nenhum episódio encontrado'**
  String get noEpisodesFound;

  /// Mensagem quando não há residentes
  ///
  /// In pt, this message translates to:
  /// **'Nenhum residente encontrado'**
  String get noResidentsFound;

  /// Mensagem quando não há personagens
  ///
  /// In pt, this message translates to:
  /// **'Nenhum personagem encontrado'**
  String get noCharactersFound;

  /// Label de data de exibição do episódio
  ///
  /// In pt, this message translates to:
  /// **'Data de Exibição'**
  String get airDate;

  /// Formato de temporada e episódio
  ///
  /// In pt, this message translates to:
  /// **'T{season}E{episode}'**
  String seasonEpisode(String season, String episode);

  /// Texto para localização desconhecida
  ///
  /// In pt, this message translates to:
  /// **'Localização desconhecida'**
  String get unknownLocation;

  /// Texto para origem desconhecida
  ///
  /// In pt, this message translates to:
  /// **'Origem desconhecida'**
  String get unknownOrigin;

  /// Label de primeira aparição
  ///
  /// In pt, this message translates to:
  /// **'Primeira aparição em'**
  String get firstAppearedIn;

  /// Label da última localização
  ///
  /// In pt, this message translates to:
  /// **'Última localização conhecida'**
  String get lastKnownLocation;

  /// Título de detalhes
  ///
  /// In pt, this message translates to:
  /// **'Detalhes'**
  String get details;

  /// Botão compartilhar
  ///
  /// In pt, this message translates to:
  /// **'Compartilhar'**
  String get share;

  /// Título de favoritos
  ///
  /// In pt, this message translates to:
  /// **'Favoritos'**
  String get favorites;

  /// Botão adicionar aos favoritos
  ///
  /// In pt, this message translates to:
  /// **'Adicionar aos favoritos'**
  String get addToFavorites;

  /// Botão remover dos favoritos
  ///
  /// In pt, this message translates to:
  /// **'Remover dos favoritos'**
  String get removeFromFavorites;

  /// Mensagem quando não há favoritos
  ///
  /// In pt, this message translates to:
  /// **'Nenhum favorito ainda'**
  String get noFavoritesYet;

  /// Título da seção de residentes
  ///
  /// In pt, this message translates to:
  /// **'Residentes'**
  String get residents;

  /// Aba de aparições
  ///
  /// In pt, this message translates to:
  /// **'Aparições'**
  String get appearancesTab;

  /// Aba de informações
  ///
  /// In pt, this message translates to:
  /// **'Info'**
  String get infoTab;

  /// Label de data de criação
  ///
  /// In pt, this message translates to:
  /// **'Criado em'**
  String get created;

  /// Opção todos nos filtros
  ///
  /// In pt, this message translates to:
  /// **'Todos'**
  String get all;

  /// Título da página de créditos
  ///
  /// In pt, this message translates to:
  /// **'Créditos'**
  String get credits;

  /// Título da seção de segurança
  ///
  /// In pt, this message translates to:
  /// **'Segurança'**
  String get security;

  /// Mensagem de confirmação de logout
  ///
  /// In pt, this message translates to:
  /// **'Deseja realmente sair?'**
  String get logoutConfirmation;

  /// Mensagem detalhada de confirmação de logout
  ///
  /// In pt, this message translates to:
  /// **'Você precisará fazer login novamente para acessar o app.'**
  String get logoutConfirmationMessage;

  /// Título da seção de aparência
  ///
  /// In pt, this message translates to:
  /// **'Aparência'**
  String get appearance;

  /// Título da seção de conta
  ///
  /// In pt, this message translates to:
  /// **'Conta'**
  String get account;

  /// Botão de excluir conta
  ///
  /// In pt, this message translates to:
  /// **'Excluir Conta'**
  String get deleteAccount;

  /// Mensagem de confirmação de exclusão de conta
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja excluir sua conta?'**
  String get deleteAccountConfirmation;

  /// Aviso sobre exclusão de conta
  ///
  /// In pt, this message translates to:
  /// **'Esta ação é irreversível. Todos os seus dados serão perdidos.'**
  String get deleteAccountWarning;

  /// Mensagem quando não há personagens com filtros
  ///
  /// In pt, this message translates to:
  /// **'Nenhum personagem encontrado com os filtros aplicados'**
  String get charactersNotFoundMessage;

  /// Mensagem quando não há localizações com filtros
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma localização encontrada com os filtros aplicados'**
  String get locationsNotFoundMessage;

  /// Mensagem quando não há episódios com filtros
  ///
  /// In pt, this message translates to:
  /// **'Nenhum episódio encontrado com os filtros aplicados'**
  String get episodesNotFoundMessage;

  /// Botão para carregar mais itens
  ///
  /// In pt, this message translates to:
  /// **'Carregar mais'**
  String get loadMore;

  /// Mensagem de fim da lista
  ///
  /// In pt, this message translates to:
  /// **'Fim da lista'**
  String get endOfList;

  /// Mensagem quando não há mais itens
  ///
  /// In pt, this message translates to:
  /// **'Não há mais itens'**
  String get noMoreItems;

  /// Instrução para atualizar
  ///
  /// In pt, this message translates to:
  /// **'Deslize para atualizar'**
  String get swipeToRefresh;

  /// Botão atualizar
  ///
  /// In pt, this message translates to:
  /// **'Atualizar'**
  String get refresh;

  /// Link para ver todos os itens
  ///
  /// In pt, this message translates to:
  /// **'Ver todos'**
  String get seeAll;

  /// Link para ver mais
  ///
  /// In pt, this message translates to:
  /// **'Ver mais'**
  String get seeMore;

  /// Link para ver menos
  ///
  /// In pt, this message translates to:
  /// **'Ver menos'**
  String get seeLess;

  /// Label de nome
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get name;

  /// Mensagem de validação para nome vazio
  ///
  /// In pt, this message translates to:
  /// **'O nome é obrigatório'**
  String get nameRequired;

  /// Mensagem de validação de confirmação de senha
  ///
  /// In pt, this message translates to:
  /// **'Confirmação de senha é obrigatória'**
  String get confirmPasswordRequired;

  /// Mensagem quando senhas não coincidem
  ///
  /// In pt, this message translates to:
  /// **'As senhas não conferem'**
  String get passwordsDoNotMatch;

  /// Mensagem de sucesso no cadastro
  ///
  /// In pt, this message translates to:
  /// **'Cadastro realizado com sucesso!'**
  String get successfullyRegistered;

  /// Mensagem de sucesso no login
  ///
  /// In pt, this message translates to:
  /// **'Login realizado com sucesso!'**
  String get successfullyLoggedIn;

  /// Mensagem de credenciais inválidas
  ///
  /// In pt, this message translates to:
  /// **'Credenciais inválidas'**
  String get invalidCredentials;

  /// Mensagem de conta criada
  ///
  /// In pt, this message translates to:
  /// **'Conta criada com sucesso'**
  String get accountCreated;

  /// Mensagem de erro ao criar conta
  ///
  /// In pt, this message translates to:
  /// **'Erro ao criar conta'**
  String get errorCreatingAccount;

  /// Idioma português
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get portuguese;

  /// Idioma inglês
  ///
  /// In pt, this message translates to:
  /// **'Inglês'**
  String get english;

  /// Idioma espanhol
  ///
  /// In pt, this message translates to:
  /// **'Espanhol'**
  String get spanish;

  /// Mensagem de validação para nome inválido
  ///
  /// In pt, this message translates to:
  /// **'Nome inválido'**
  String get invalidName;

  /// Mensagem de validação para comprimento mínimo da senha
  ///
  /// In pt, this message translates to:
  /// **'A senha deve ter pelo menos 8 caracteres'**
  String get passwordMinLength;

  /// Mensagem de validação para requisito de minúscula
  ///
  /// In pt, this message translates to:
  /// **'A senha deve ter pelo menos uma letra minúscula'**
  String get passwordMustHaveLowercase;

  /// Mensagem de validação para requisito de maiúscula
  ///
  /// In pt, this message translates to:
  /// **'A senha deve ter pelo menos uma letra maiúscula'**
  String get passwordMustHaveUppercase;

  /// Mensagem de validação para requisito de número
  ///
  /// In pt, this message translates to:
  /// **'A senha deve ter pelo menos um número'**
  String get passwordMustHaveNumber;

  /// Mensagem de validação para requisito de caractere especial
  ///
  /// In pt, this message translates to:
  /// **'A senha deve ter pelo menos um caractere especial'**
  String get passwordMustHaveSpecialCharacter;

  /// Mensagem de validação para data de nascimento inválida
  ///
  /// In pt, this message translates to:
  /// **'Data de nascimento inválida'**
  String get invalidBirthDate;

  /// Mensagem de validação para data de nascimento muito antiga
  ///
  /// In pt, this message translates to:
  /// **'Data de nascimento muito antiga'**
  String get tooOldBirthDate;

  /// Label de configuração de modo do tema
  ///
  /// In pt, this message translates to:
  /// **'Modo'**
  String get mode;

  /// Título do diálogo de seleção de modo
  ///
  /// In pt, this message translates to:
  /// **'Selecionar Modo'**
  String get modeSelect;

  /// Opção padrão do sistema para idioma
  ///
  /// In pt, this message translates to:
  /// **'Padrão do Sistema'**
  String get systemDefault;

  /// Título do switch de todas as notificações
  ///
  /// In pt, this message translates to:
  /// **'Todas as Notificações'**
  String get allNotifications;

  /// Descrição do switch de todas as notificações
  ///
  /// In pt, this message translates to:
  /// **'Habilitar ou desabilitar todas as notificações'**
  String get allNotificationsDescription;

  /// Título do switch de notificações gerais
  ///
  /// In pt, this message translates to:
  /// **'Notificações Gerais'**
  String get generalNotifications;

  /// Descrição do switch de notificações gerais
  ///
  /// In pt, this message translates to:
  /// **'Receba atualizações e novidades gerais do app'**
  String get generalNotificationsDescription;

  /// Título do switch de notificações promocionais
  ///
  /// In pt, this message translates to:
  /// **'Notificações Promocionais'**
  String get promotionalNotifications;

  /// Descrição do switch de notificações promocionais
  ///
  /// In pt, this message translates to:
  /// **'Receba ofertas especiais e promoções'**
  String get promotionalNotificationsDescription;

  /// Prefixo de mensagem de erro ao salvar
  ///
  /// In pt, this message translates to:
  /// **'Erro ao salvar'**
  String get errorSaving;

  /// Tipo de licença de animação Lottie
  ///
  /// In pt, this message translates to:
  /// **'Licença Simples do Lottie'**
  String get lottieSimpleLicense;

  /// Título da seção de recursos de terceiros
  ///
  /// In pt, this message translates to:
  /// **'Recursos de Terceiros'**
  String get thirdPartyAssets;

  /// Título da seção de bibliotecas de terceiros
  ///
  /// In pt, this message translates to:
  /// **'Bibliotecas de Terceiros'**
  String get thirdPartyLibraries;

  /// Label de licença
  ///
  /// In pt, this message translates to:
  /// **'Licença'**
  String get license;

  /// Label de fonte
  ///
  /// In pt, this message translates to:
  /// **'Fonte'**
  String get source;

  /// Subtítulo da página inicial
  ///
  /// In pt, this message translates to:
  /// **'Explore o universo de Rick and Morty'**
  String get exploreRickAndMorty;

  /// Descrição da seção de personagens
  ///
  /// In pt, this message translates to:
  /// **'Descubra todos os personagens da série'**
  String get charactersDescription;

  /// Descrição da seção de localizações
  ///
  /// In pt, this message translates to:
  /// **'Explore as localizações do multiverso'**
  String get locationsDescription;

  /// Descrição da seção de episódios
  ///
  /// In pt, this message translates to:
  /// **'Todos os episódios de todas as temporadas'**
  String get episodesDescription;

  /// Descrição da página de boas-vindas
  ///
  /// In pt, this message translates to:
  /// **'Explore o universo de Rick and Morty e descubra todos os personagens, localizações e episódios'**
  String get welcomeDescription;

  /// Título da página de detalhes do personagem
  ///
  /// In pt, this message translates to:
  /// **'Detalhes do Personagem'**
  String get characterDetails;

  /// Label de gênero sem gênero
  ///
  /// In pt, this message translates to:
  /// **'Sem Gênero'**
  String get genderless;

  /// Tipo de personagem: experimento genético
  ///
  /// In pt, this message translates to:
  /// **'Experimento Genético'**
  String get characterTypeGeneticExperiment;

  /// Tipo de personagem: humano com antenas
  ///
  /// In pt, this message translates to:
  /// **'Humano com Antenas'**
  String get characterTypeHumanWithAntennae;

  /// Tipo de personagem: humano com cérebro de formigas
  ///
  /// In pt, this message translates to:
  /// **'Humano com Cérebro de Formigas'**
  String get characterTypeHumanWithAntsBrain;

  /// Tipo de personagem: jogo
  ///
  /// In pt, this message translates to:
  /// **'Jogo'**
  String get characterTypeGame;

  /// Tipo de personagem: clone
  ///
  /// In pt, this message translates to:
  /// **'Clone'**
  String get characterTypeClone;

  /// Tipo de personagem: autoconsciente
  ///
  /// In pt, this message translates to:
  /// **'Autoconsciente'**
  String get characterTypeSelfAware;

  /// Tipo de personagem: ciborgue
  ///
  /// In pt, this message translates to:
  /// **'Ciborgue'**
  String get characterTypeCyborg;

  /// Tipo de personagem: pessoa pássaro
  ///
  /// In pt, this message translates to:
  /// **'Pessoa Pássaro'**
  String get characterTypeBirdPerson;

  /// Tipo de personagem: milho
  ///
  /// In pt, this message translates to:
  /// **'Milho'**
  String get characterTypeCorn;

  /// Tipo de personagem: picles
  ///
  /// In pt, this message translates to:
  /// **'Picles'**
  String get characterTypePickle;

  /// Tipo de personagem: gato
  ///
  /// In pt, this message translates to:
  /// **'Gato'**
  String get characterTypeCat;

  /// Tipo de personagem: carro animado
  ///
  /// In pt, this message translates to:
  /// **'Carro Animado'**
  String get characterTypeAnimatedCar;

  /// Cor amarelo
  ///
  /// In pt, this message translates to:
  /// **'Amarelo'**
  String get colorYellow;

  /// Cor marrom
  ///
  /// In pt, this message translates to:
  /// **'Marrom'**
  String get colorBrown;

  /// Cor cinza
  ///
  /// In pt, this message translates to:
  /// **'Cinza'**
  String get colorGray;

  /// Título da página de detalhes da localização
  ///
  /// In pt, this message translates to:
  /// **'Detalhes da Localização'**
  String get locationDetails;

  /// Tipo de localização: Creche
  ///
  /// In pt, this message translates to:
  /// **'Creche'**
  String get locationTypeDaycare;

  /// Tipo de localização: Spa
  ///
  /// In pt, this message translates to:
  /// **'Spa'**
  String get locationTypeSpa;

  /// Mensagem quando não há localizações
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma localização encontrada'**
  String get noLocationsFound;

  /// Título da página de detalhes do episódio
  ///
  /// In pt, this message translates to:
  /// **'Detalhes do Episódio'**
  String get episodeDetails;

  /// Título da seção de informações
  ///
  /// In pt, this message translates to:
  /// **'Informações'**
  String get information;

  /// Saudação de boas-vindas na página de login
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo de volta!'**
  String get welcomeBack;

  /// Label do campo de data de nascimento
  ///
  /// In pt, this message translates to:
  /// **'Data de Nascimento'**
  String get birthDate;

  /// Mensagem de sucesso de registro
  ///
  /// In pt, this message translates to:
  /// **'Conta criada com sucesso!'**
  String get registerSuccess;

  /// Texto do botão de entrar novamente para login biométrico
  ///
  /// In pt, this message translates to:
  /// **'Entrar novamente'**
  String get enterAgain;

  /// Mensagem de fazer login para continuar
  ///
  /// In pt, this message translates to:
  /// **'Faça login para continuar'**
  String get loginToContinue;

  /// Label do campo de nome
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get nameLabel;

  /// Label de temporada para episódios
  ///
  /// In pt, this message translates to:
  /// **'Temporada'**
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
  // Lookup logic when only language code is specified.
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
