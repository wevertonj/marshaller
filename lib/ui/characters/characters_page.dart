import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/enums/character_gender.dart';
import 'package:marshaller/domain/enums/character_species.dart';
import 'package:marshaller/domain/enums/character_status.dart';
import 'package:marshaller/domain/enums/themes_color.dart';
import 'package:marshaller/ui/characters/viewmodels/character_list_state.dart';
import 'package:marshaller/ui/characters/viewmodels/character_list_viewmodel.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/app_shimmer.dart';
import 'package:marshaller/ui/core/widgets/layouts/app_scaffold.dart';
import 'package:marshaller/ui/core/widgets/app_card.dart';
import 'package:marshaller/utils/helpers/app_navigation.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

class CharactersPage extends StatefulWidget {
  final String? species;
  final String? type;
  final String? gender;

  const CharactersPage({super.key, this.species, this.type, this.gender});
  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late final CharacterListViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.I<CharacterListViewModel>();
    _viewModel.loadCharactersCommand.execute((
      forceRefresh: false,
      species: widget.species,
      type: widget.type,
      gender: widget.gender,
    ));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _viewModel.loadMoreCommand.execute();
    }
  }

  bool get _hasFilter =>
      widget.species != null || widget.type != null || widget.gender != null;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Text? title = Text(l10n.characters);
    if (widget.species != null) {
      title = null;
    } else if (widget.type != null) {
      title = null;
    } else if (widget.gender != null) {
      title = null;
    }

    return AppScaffold(
      title: title,
      scrollable: false,
      body: ValueListenableBuilder<CharacterListState>(
        valueListenable: _viewModel.state,
        builder: (context, state, _) {
          return switch (state) {
            CharacterListInitial() => const SizedBox.shrink(),
            CharacterListLoading() => _buildShimmerList(context),
            CharacterListLoaded() => _buildCharacterList(context, state),
            CharacterListError(:final message) => _buildError(context, message),
          };
        },
      ),
    );
  }

  Widget _buildShimmerList(BuildContext context) {
    final layout = Theme.of(context).layout;
    return ListView.builder(
      padding: EdgeInsets.all(layout.padding.medium),
      itemCount: 10,
      itemBuilder: (context, index) => _buildShimmerCard(context),
    );
  }

  Widget _buildShimmerCard(BuildContext context) {
    final layout = Theme.of(context).layout;
    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing.medium),
      child: AppShimmer(
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(layout.radius.medium),
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterList(BuildContext context, CharacterListLoaded state) {
    final layout = Theme.of(context).layout;
    final l10n = AppLocalizations.of(context);
    final hasHeaderItem = _hasFilter ? 1 : 0;
    return RefreshIndicator(
      onRefresh: () async {
        await _viewModel.loadCharactersCommand.execute((
          forceRefresh: true,
          species: widget.species,
          type: widget.type,
          gender: widget.gender,
        ));
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
            hasHeaderItem + state.characters.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (_hasFilter && index == 0) {
            return _buildFilterHeader(context, state.totalCount, l10n);
          }
          final adjustedIndex = index - hasHeaderItem;
          if (adjustedIndex >= state.characters.length) {
            return _buildLoadingMore(context);
          }
          final character = state.characters[adjustedIndex];
          return Padding(
            padding: EdgeInsets.only(bottom: layout.spacing.medium),
            child: _buildCharacterCard(context, character),
          );
        },
      ),
    );
  }

  Widget _buildCharacterCard(BuildContext context, Character character) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    final l10n = AppLocalizations.of(context);
    return AppCard(
      imageUrl: character.image,
      title: Text(character.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _StatusIndicator(status: character.status),
              SizedBox(width: layout.spacing.small),
              Expanded(
                child: Text(
                  '${_getStatusLabel(character.status, l10n)} - ${_getSpeciesLabel(character.species, l10n)}',
                  style: theme.textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: layout.spacing.tiny),
          Text(
            _translateUnknown(character.location.name, l10n),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: layout.spacing.tiny),
          Text(
            l10n.appearsInEpisodes(character.episode.length),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
      onTap: () => _navigateToDetail(character.id),
    );
  }

  Widget _buildLoadingMore(BuildContext context) {
    final layout = Theme.of(context).layout;
    return Padding(
      padding: EdgeInsets.all(layout.padding.medium),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context);
    final layout = Theme.of(context).layout;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(layout.padding.large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: layout.icon.xlarge,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: layout.spacing.medium),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: layout.spacing.large),
            FilledButton.icon(
              onPressed: () => _viewModel.loadCharactersCommand.execute((
                forceRefresh: false,
                species: widget.species,
                type: widget.type,
                gender: widget.gender,
              )),
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(int id) {
    AppNavigation.pushNamed(
      AppRoutes.characterDetail,
      pathParameters: {'id': id.toString()},
    );
  }

  String _getStatusLabel(CharacterStatus status, AppLocalizations l10n) {
    return switch (status) {
      CharacterStatus.alive => l10n.statusAlive,
      CharacterStatus.dead => l10n.statusDead,
      CharacterStatus.unknown => l10n.statusUnknown,
    };
  }

  String _translateUnknown(String value, AppLocalizations l10n) {
    if (value.toLowerCase() == 'unknown') {
      return l10n.statusUnknown;
    }
    return value;
  }

  String _getGenderLabel(String gender, AppLocalizations l10n) {
    final genderEnum = CharacterGender.fromString(gender);
    return switch (genderEnum) {
      CharacterGender.male => l10n.genderMale,
      CharacterGender.female => l10n.genderFemale,
      CharacterGender.genderless => l10n.genderless,
      CharacterGender.unknown => l10n.statusUnknown,
    };
  }

  String _getSpeciesLabel(String species, AppLocalizations l10n) {
    final speciesEnum = CharacterSpecies.fromApiValue(species);
    return switch (speciesEnum) {
      CharacterSpecies.human => l10n.speciesHuman,
      CharacterSpecies.alien => l10n.speciesAlien,
      CharacterSpecies.humanoid => l10n.speciesHumanoid,
      CharacterSpecies.robot => l10n.speciesRobot,
      CharacterSpecies.animal => l10n.speciesAnimal,
      CharacterSpecies.mythologicalCreature => l10n.speciesMythologicalCreature,
      CharacterSpecies.disease => l10n.speciesDisease,
      CharacterSpecies.cronenberg => l10n.speciesCronenberg,
      CharacterSpecies.poopybutthole => l10n.speciesPoopybutthole,
      CharacterSpecies.unknown => l10n.statusUnknown,
      CharacterSpecies.other => species,
    };
  }

  String _getCharacterTypeLabel(String type, AppLocalizations l10n) {
    if (type.toLowerCase() == 'unknown' || type.isEmpty) {
      return l10n.statusUnknown;
    }
    return type;
  }

  Widget _buildFilterHeader(
    BuildContext context,
    int totalCount,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final layout = theme.layout;

    String filterValue = '';
    String filterLabel = '';
    IconData filterIcon = Icons.filter_list;

    if (widget.species != null) {
      filterValue = _getSpeciesLabel(widget.species!, l10n);
      filterLabel = l10n.species;
      filterIcon = Icons.category_outlined;
    } else if (widget.type != null) {
      filterValue = _getCharacterTypeLabel(widget.type!, l10n);
      filterLabel = l10n.type;
      filterIcon = Icons.label_outline;
    } else if (widget.gender != null) {
      filterValue = _getGenderLabel(widget.gender!, l10n);
      filterLabel = l10n.gender;
      filterIcon = Icons.person_outline;
    }

    final countText = l10n.charactersCount(totalCount);

    return Container(
      padding: EdgeInsets.all(layout.padding.large),
      margin: EdgeInsets.only(bottom: layout.spacing.medium),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
            theme.colorScheme.secondaryContainer.withValues(alpha: 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(layout.radius.large),
      ),
      child: Column(
        children: [
          Icon(filterIcon, size: 48, color: theme.colorScheme.primary),
          SizedBox(height: layout.spacing.medium),
          Text(
            filterValue,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: layout.spacing.tiny),
          Text(
            filterLabel,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: layout.spacing.small),
          Text(
            countText,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final CharacterStatus status;
  const _StatusIndicator({required this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getStatusColor(status),
      ),
    );
  }

  Color _getStatusColor(CharacterStatus status) {
    return switch (status) {
      CharacterStatus.alive => Color(ThemesColor.green.colorValue),
      CharacterStatus.dead => Color(ThemesColor.red.colorValue),
      CharacterStatus.unknown => Color(ThemesColor.gray.colorValue),
    };
  }
}
