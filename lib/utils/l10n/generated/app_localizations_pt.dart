// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Marshaller';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count itens',
      one: '1 item',
      zero: 'Nenhum item',
    );
    return '$_temp0';
  }

  @override
  String get errorGeneric => 'Ocorreu um erro. Tente novamente.';

  @override
  String get errorNetwork => 'Sem conexão com a internet';

  @override
  String get errorUnauthorized => 'Sessão expirada. Faça login novamente.';

  @override
  String get errorTimeout => 'Tempo de conexão esgotado';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get save => 'Salvar';

  @override
  String get delete => 'Excluir';

  @override
  String get edit => 'Editar';

  @override
  String get loading => 'Carregando...';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get close => 'Fechar';

  @override
  String get continue_ => 'Continuar';

  @override
  String get back => 'Voltar';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Erro';

  @override
  String get info => 'Informação';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get home => 'Início';

  @override
  String get settings => 'Configurações';

  @override
  String get goodMorning => 'Bom dia';

  @override
  String get goodAfternoon => 'Boa tarde';

  @override
  String get goodEvening => 'Boa noite';

  @override
  String get goodNight => 'Boa noite';

  @override
  String get darkMode => 'Modo Escuro';

  @override
  String get lightMode => 'Modo Claro';

  @override
  String get systemMode => 'Padrão do Sistema';

  @override
  String get keyNotFound => 'Chave de tradução não encontrada';

  @override
  String get storageError => 'Erro ao acessar armazenamento seguro';

  @override
  String get deviceInfoError => 'Erro ao obter informações do dispositivo';

  @override
  String get preferences => 'Preferências';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get about => 'Sobre';

  @override
  String get version => 'Versão';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get openSourceLicenses => 'Licenças Open Source';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get creditsDescription =>
      'Este app utiliza dados da API pública de Rick and Morty.';

  @override
  String get creditsDevelopedBy => 'Desenvolvido por ';

  @override
  String get creditsUsingDataFrom => ' usando dados de ';

  @override
  String get creditsApiSource => 'API: rickandmortyapi.com';

  @override
  String get creditsImagesSource => 'Imagens: Adult Swim';

  @override
  String get lottieFilesSource => 'Animações: LottieFiles';

  @override
  String get colorGreen => 'Verde';

  @override
  String get colorBlue => 'Azul';

  @override
  String get colorPurple => 'Roxo';

  @override
  String get colorOrange => 'Laranja';

  @override
  String get colorRed => 'Vermelho';

  @override
  String get colorTeal => 'Verde-azulado';

  @override
  String get colorPink => 'Rosa';

  @override
  String get themeColor => 'Cor do Tema';

  @override
  String get themeSelect => 'Selecione um tema';

  @override
  String get characters => 'Personagens';

  @override
  String get locations => 'Localizações';

  @override
  String get episodes => 'Episódios';

  @override
  String get search => 'Buscar';

  @override
  String get searchCharacters => 'Buscar personagens';

  @override
  String get searchLocations => 'Buscar localizações';

  @override
  String get searchEpisodes => 'Buscar episódios';

  @override
  String get noResults => 'Nenhum resultado encontrado';

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get filters => 'Filtros';

  @override
  String get clearFilters => 'Limpar filtros';

  @override
  String get applyFilters => 'Aplicar filtros';

  @override
  String get status => 'Status';

  @override
  String get species => 'Espécie';

  @override
  String get gender => 'Gênero';

  @override
  String get type => 'Tipo';

  @override
  String get dimension => 'Dimensão';

  @override
  String get origin => 'Origem';

  @override
  String get location => 'Localização';

  @override
  String get episode => 'Episódio';

  @override
  String get character => 'Personagem';

  @override
  String get statusAlive => 'Vivo';

  @override
  String get statusDead => 'Morto';

  @override
  String get statusUnknown => 'Desconhecido';

  @override
  String get genderMale => 'Masculino';

  @override
  String get genderFemale => 'Feminino';

  @override
  String get genderGenderless => 'Sem gênero';

  @override
  String get genderUnknown => 'Desconhecido';

  @override
  String get speciesHuman => 'Humano';

  @override
  String get speciesAlien => 'Alienígena';

  @override
  String get speciesHumanoid => 'Humanóide';

  @override
  String get speciesPoopybutthole => 'Poopybutthole';

  @override
  String get speciesMythologicalCreature => 'Criatura Mitológica';

  @override
  String get speciesAnimal => 'Animal';

  @override
  String get speciesRobot => 'Robô';

  @override
  String get speciesCronenberg => 'Cronenberg';

  @override
  String get speciesDisease => 'Doença';

  @override
  String get speciesUnknown => 'Desconhecido';

  @override
  String get locationTypePlanet => 'Planeta';

  @override
  String get locationTypeCluster => 'Grupo';

  @override
  String get locationTypeSpaceStation => 'Estação Espacial';

  @override
  String get locationTypeMicroverse => 'Microverso';

  @override
  String get locationTypeTv => 'TV';

  @override
  String get locationTypeResort => 'Resort';

  @override
  String get locationTypeFantasyTown => 'Cidade Fantasia';

  @override
  String get locationTypeDream => 'Sonho';

  @override
  String get locationTypeDimension => 'Dimensão';

  @override
  String get locationTypeUnknown => 'Desconhecido';

  @override
  String get locationTypeMenagerie => 'Menagerie';

  @override
  String get locationTypeGame => 'Jogo';

  @override
  String get locationTypeCustoms => 'Alfândega';

  @override
  String get locationTypeDeadworld => 'Mundo Morto';

  @override
  String get locationTypeArcade => 'Arcade';

  @override
  String get locationTypeSpacecraft => 'Nave Espacial';

  @override
  String get locationTypeArtificiallyGenerated => 'Gerado Artificialmente';

  @override
  String get locationTypeMachine => 'Máquina';

  @override
  String get locationTypeAsteriod => 'Asteroide';

  @override
  String get locationTypeBox => 'Caixa';

  @override
  String get locationTypeElemental => 'Elemental';

  @override
  String get locationTypeMemory => 'Memória';

  @override
  String get locationTypeMount => 'Monte';

  @override
  String get locationTypeNonDiegeticAlternateReality =>
      'Realidade Alternativa Não-Diegética';

  @override
  String get locationTypePoliceStation => 'Delegacia de Polícia';

  @override
  String get locationTypeQuadrant => 'Quadrante';

  @override
  String get locationTypeReality => 'Realidade';

  @override
  String get locationTypeTeenyverse => 'Teenyverse';

  @override
  String get characterTypeHuman => 'Humano';

  @override
  String get characterTypeRobot => 'Robô';

  @override
  String get characterTypeAlien => 'Alienígena';

  @override
  String get characterTypeHumanoid => 'Humanóide';

  @override
  String get characterTypeUnknown => 'Desconhecido';

  @override
  String get characterTypeParasite => 'Parasita';

  @override
  String get characterTypeMytholog => 'Mitológico';

  @override
  String get characterTypeSuperhuman => 'Super-humano';

  @override
  String get characterTypeAnimal => 'Animal';

  @override
  String get characterTypeDisease => 'Doença';

  @override
  String get characterTypeCronenberg => 'Cronenberg';

  @override
  String get characterTypeMicroorganism => 'Microorganismo';

  @override
  String appearsInEpisodes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Aparece em $count episódios',
      one: 'Aparece em 1 episódio',
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
      zero: 'Nenhum residente',
    );
    return '$_temp0';
  }

  @override
  String charactersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count personagens',
      one: '1 personagem',
      zero: 'Nenhum personagem',
    );
    return '$_temp0';
  }

  @override
  String locationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count locais',
      one: '1 local',
      zero: 'Nenhum local',
    );
    return '$_temp0';
  }

  @override
  String episodesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count episódios',
      one: '1 episódio',
      zero: 'Nenhum episódio',
    );
    return '$_temp0';
  }

  @override
  String get noEpisodesFound => 'Nenhum episódio encontrado';

  @override
  String get noResidentsFound => 'Nenhum residente encontrado';

  @override
  String get noCharactersFound => 'Nenhum personagem encontrado';

  @override
  String get airDate => 'Data de Exibição';

  @override
  String seasonEpisode(String season, String episode) {
    return 'T${season}E$episode';
  }

  @override
  String get unknownLocation => 'Localização desconhecida';

  @override
  String get unknownOrigin => 'Origem desconhecida';

  @override
  String get firstAppearedIn => 'Primeira aparição em';

  @override
  String get lastKnownLocation => 'Última localização conhecida';

  @override
  String get details => 'Detalhes';

  @override
  String get share => 'Compartilhar';

  @override
  String get favorites => 'Favoritos';

  @override
  String get addToFavorites => 'Adicionar aos favoritos';

  @override
  String get removeFromFavorites => 'Remover dos favoritos';

  @override
  String get noFavoritesYet => 'Nenhum favorito ainda';

  @override
  String get residents => 'Residentes';

  @override
  String get appearancesTab => 'Aparições';

  @override
  String get infoTab => 'Info';

  @override
  String get created => 'Criado em';

  @override
  String get all => 'Todos';

  @override
  String get credits => 'Créditos';

  @override
  String get security => 'Segurança';

  @override
  String get logoutConfirmation => 'Deseja realmente sair?';

  @override
  String get logoutConfirmationMessage =>
      'Você precisará fazer login novamente para acessar o app.';

  @override
  String get appearance => 'Aparência';

  @override
  String get account => 'Conta';

  @override
  String get deleteAccount => 'Excluir Conta';

  @override
  String get deleteAccountConfirmation =>
      'Tem certeza que deseja excluir sua conta?';

  @override
  String get deleteAccountWarning =>
      'Esta ação é irreversível. Todos os seus dados serão perdidos.';

  @override
  String get charactersNotFoundMessage =>
      'Nenhum personagem encontrado com os filtros aplicados';

  @override
  String get locationsNotFoundMessage =>
      'Nenhuma localização encontrada com os filtros aplicados';

  @override
  String get episodesNotFoundMessage =>
      'Nenhum episódio encontrado com os filtros aplicados';

  @override
  String get loadMore => 'Carregar mais';

  @override
  String get endOfList => 'Fim da lista';

  @override
  String get noMoreItems => 'Não há mais itens';

  @override
  String get swipeToRefresh => 'Deslize para atualizar';

  @override
  String get refresh => 'Atualizar';

  @override
  String get seeAll => 'Ver todos';

  @override
  String get seeMore => 'Ver mais';

  @override
  String get seeLess => 'Ver menos';

  @override
  String get name => 'Nome';

  @override
  String get nameRequired => 'O nome é obrigatório';

  @override
  String get confirmPasswordRequired => 'Confirmação de senha é obrigatória';

  @override
  String get passwordsDoNotMatch => 'As senhas não conferem';

  @override
  String get successfullyRegistered => 'Cadastro realizado com sucesso!';

  @override
  String get successfullyLoggedIn => 'Login realizado com sucesso!';

  @override
  String get invalidCredentials => 'Credenciais inválidas';

  @override
  String get accountCreated => 'Conta criada com sucesso';

  @override
  String get errorCreatingAccount => 'Erro ao criar conta';

  @override
  String get portuguese => 'Português';

  @override
  String get english => 'Inglês';

  @override
  String get spanish => 'Espanhol';

  @override
  String get invalidName => 'Nome inválido';

  @override
  String get passwordMinLength => 'A senha deve ter pelo menos 8 caracteres';

  @override
  String get passwordMustHaveLowercase =>
      'A senha deve ter pelo menos uma letra minúscula';

  @override
  String get passwordMustHaveUppercase =>
      'A senha deve ter pelo menos uma letra maiúscula';

  @override
  String get passwordMustHaveNumber => 'A senha deve ter pelo menos um número';

  @override
  String get passwordMustHaveSpecialCharacter =>
      'A senha deve ter pelo menos um caractere especial';

  @override
  String get invalidBirthDate => 'Data de nascimento inválida';

  @override
  String get tooOldBirthDate => 'Data de nascimento muito antiga';

  @override
  String get mode => 'Modo';

  @override
  String get modeSelect => 'Selecionar Modo';

  @override
  String get systemDefault => 'Padrão do Sistema';

  @override
  String get allNotifications => 'Todas as Notificações';

  @override
  String get allNotificationsDescription =>
      'Habilitar ou desabilitar todas as notificações';

  @override
  String get generalNotifications => 'Notificações Gerais';

  @override
  String get generalNotificationsDescription =>
      'Receba atualizações e novidades gerais do app';

  @override
  String get promotionalNotifications => 'Notificações Promocionais';

  @override
  String get promotionalNotificationsDescription =>
      'Receba ofertas especiais e promoções';

  @override
  String get errorSaving => 'Erro ao salvar';

  @override
  String get lottieSimpleLicense => 'Licença Simples do Lottie';

  @override
  String get thirdPartyAssets => 'Recursos de Terceiros';

  @override
  String get thirdPartyLibraries => 'Bibliotecas de Terceiros';

  @override
  String get license => 'Licença';

  @override
  String get source => 'Fonte';

  @override
  String get exploreRickAndMorty => 'Explore o universo de Rick and Morty';

  @override
  String get charactersDescription => 'Descubra todos os personagens da série';

  @override
  String get locationsDescription => 'Explore as localizações do multiverso';

  @override
  String get episodesDescription => 'Todos os episódios de todas as temporadas';

  @override
  String get welcomeDescription =>
      'Explore o universo de Rick and Morty e descubra todos os personagens, localizações e episódios';

  @override
  String get characterDetails => 'Detalhes do Personagem';

  @override
  String get genderless => 'Sem Gênero';

  @override
  String get characterTypeGeneticExperiment => 'Experimento Genético';

  @override
  String get characterTypeHumanWithAntennae => 'Humano com Antenas';

  @override
  String get characterTypeHumanWithAntsBrain =>
      'Humano com Cérebro de Formigas';

  @override
  String get characterTypeGame => 'Jogo';

  @override
  String get characterTypeClone => 'Clone';

  @override
  String get characterTypeSelfAware => 'Autoconsciente';

  @override
  String get characterTypeCyborg => 'Ciborgue';

  @override
  String get characterTypeBirdPerson => 'Pessoa Pássaro';

  @override
  String get characterTypeCorn => 'Milho';

  @override
  String get characterTypePickle => 'Picles';

  @override
  String get characterTypeCat => 'Gato';

  @override
  String get characterTypeAnimatedCar => 'Carro Animado';

  @override
  String get colorYellow => 'Amarelo';

  @override
  String get colorBrown => 'Marrom';

  @override
  String get colorGray => 'Cinza';

  @override
  String get locationDetails => 'Detalhes da Localização';

  @override
  String get locationTypeDaycare => 'Creche';

  @override
  String get locationTypeSpa => 'Spa';

  @override
  String get noLocationsFound => 'Nenhuma localização encontrada';

  @override
  String get episodeDetails => 'Detalhes do Episódio';

  @override
  String get information => 'Informações';

  @override
  String get welcomeBack => 'Bem-vindo de volta!';

  @override
  String get birthDate => 'Data de Nascimento';

  @override
  String get registerSuccess => 'Conta criada com sucesso!';

  @override
  String get enterAgain => 'Entrar novamente';

  @override
  String get loginToContinue => 'Faça login para continuar';

  @override
  String get nameLabel => 'Nome';

  @override
  String get season => 'Temporada';
}
