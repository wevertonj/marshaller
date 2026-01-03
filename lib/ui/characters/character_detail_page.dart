import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_it/get_it.dart';
import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/domain/enums/character_gender.dart';
import 'package:marshaller/domain/enums/character_species.dart';
import 'package:marshaller/domain/enums/character_status.dart';
import 'package:marshaller/domain/enums/character_type.dart';
import 'package:marshaller/domain/enums/themes_color.dart';
import 'package:marshaller/ui/characters/viewmodels/character_detail_state.dart';
import 'package:marshaller/ui/characters/viewmodels/character_detail_viewmodel.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/app_shimmer.dart';
import 'package:marshaller/ui/core/widgets/app_card.dart';
import 'package:marshaller/ui/core/widgets/layouts/app_scaffold.dart';
import 'package:marshaller/utils/formatters/date_formatter.dart';
import 'package:marshaller/utils/helpers/app_navigation.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

class CharacterDetailPage extends StatefulWidget {
  final int characterId;
  const CharacterDetailPage({super.key, required this.characterId});
  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  late final CharacterDetailViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.I<CharacterDetailViewModel>();
    _viewModel.loadCharacterCommand.execute(widget.characterId);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ValueListenableBuilder<CharacterDetailState>(
        valueListenable: _viewModel.state,
        builder: (context, state, _) {
          return switch (state) {
            CharacterDetailInitial() => const SizedBox.shrink(),
            CharacterDetailLoading() => _buildShimmer(context),
            CharacterDetailLoaded() => _buildContent(context, state),
            CharacterDetailError(:final message) => _buildError(
              context,
              message,
            ),
          };
        },
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    final layout = Theme.of(context).layout;
    return SingleChildScrollView(
      padding: EdgeInsets.all(layout.padding.medium),
      child: Column(
        children: [
          AppShimmer(
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(layout.radius.medium),
              ),
            ),
          ),
          SizedBox(height: layout.spacing.medium),
          AppShimmer(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(layout.radius.medium),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, CharacterDetailLoaded state) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    final l10n = AppLocalizations.of(context);
    final character = state.character;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Column(
              children: [
                Hero(
                  tag: 'character_${character.id}',
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.surfaceContainerHighest,
                        width: 4,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: CachedNetworkImageProvider(
                        character.image,
                      ),
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
                SizedBox(height: layout.spacing.medium),
                Text(
                  character.name,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: layout.spacing.small),
                _StatusChip(status: character.status),
              ],
            ),
          ),
          SizedBox(height: layout.spacing.large),
          Container(
            padding: EdgeInsets.all(layout.padding.large),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(layout.radius.large),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.information,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: layout.spacing.medium),
                _InfoRow(
                  icon: Icons.category_outlined,
                  label: l10n.species,
                  value: _getSpeciesLabel(character.species, l10n),
                  onTap: () => AppNavigation.pushNamed(
                    AppRoutes.charactersBySpecies,
                    pathParameters: {'species': character.species},
                  ),
                ),
                if (character.type.isNotEmpty) ...[
                  SizedBox(height: layout.spacing.medium),
                  _InfoRow(
                    icon: Icons.label_outline,
                    label: l10n.type,
                    value: _getCharacterTypeLabel(character.type, l10n),
                    onTap: () => AppNavigation.pushNamed(
                      AppRoutes.charactersByType,
                      pathParameters: {'type': character.type},
                    ),
                  ),
                ],
                SizedBox(height: layout.spacing.medium),
                _InfoRow(
                  icon: Icons.person_outline,
                  label: l10n.gender,
                  value: _getGenderLabel(character.gender, l10n),
                  onTap: () => AppNavigation.pushNamed(
                    AppRoutes.charactersByGender,
                    pathParameters: {'gender': character.gender.name},
                  ),
                ),
                SizedBox(height: layout.spacing.medium),
                _InfoRow(
                  icon: Icons.home_outlined,
                  label: l10n.origin,
                  value: _translateUnknown(character.origin.name, l10n),
                  onTap: character.origin.id != null
                      ? () => AppNavigation.pushNamed(
                          AppRoutes.locationDetail,
                          pathParameters: {
                            'id': character.origin.id.toString(),
                          },
                        )
                      : null,
                ),
                SizedBox(height: layout.spacing.medium),
                _InfoRow(
                  icon: Icons.location_on_outlined,
                  label: l10n.location,
                  value: _translateUnknown(character.location.name, l10n),
                  onTap: character.location.id != null
                      ? () => AppNavigation.pushNamed(
                          AppRoutes.locationDetail,
                          pathParameters: {
                            'id': character.location.id.toString(),
                          },
                        )
                      : null,
                ),
              ],
            ),
          ),
          SizedBox(height: layout.spacing.large),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.movie,
                    size: layout.icon.medium,
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(width: layout.spacing.small),
                  Text(
                    l10n.episodes,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: layout.padding.small,
                      vertical: layout.padding.tiny,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(layout.radius.small),
                    ),
                    child: Text(
                      '${character.episode.length}',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: layout.spacing.medium),
              if (state.loadingEpisodes)
                const Center(child: CircularProgressIndicator())
              else if (state.episodes.isEmpty)
                Text(
                  l10n.noEpisodesFound,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              else
                ...state.episodes.map(
                  (episode) => Padding(
                    padding: EdgeInsets.only(bottom: layout.spacing.small),
                    child: AppCard(
                      leading: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.tertiaryContainer,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.movie,
                              color: theme.colorScheme.onTertiaryContainer,
                              size: layout.icon.large,
                            ),
                            SizedBox(height: layout.spacing.tiny),
                            Text(
                              episode.episodeCode,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.onTertiaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: Text(episode.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: layout.icon.small,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              SizedBox(width: layout.spacing.tiny),
                              Text(
                                DateFormatter.formatDate(episode.airDate),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: layout.spacing.tiny),
                          Text(
                            l10n.charactersCount(episode.characters.length),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => AppNavigation.pushNamed(
                        AppRoutes.episodeDetail,
                        pathParameters: {'id': episode.id.toString()},
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
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
              onPressed: () =>
                  _viewModel.loadCharacterCommand.execute(widget.characterId),
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  String _getGenderLabel(CharacterGender gender, AppLocalizations l10n) {
    return switch (gender) {
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
      CharacterSpecies.unknown => l10n.speciesUnknown,
      CharacterSpecies.other => species,
    };
  }

  String _getCharacterTypeLabel(String type, AppLocalizations l10n) {
    final characterType = CharacterType.fromApiValue(type);
    return switch (characterType) {
      CharacterType.empty => '',
      CharacterType.parasite => l10n.characterTypeParasite,
      CharacterType.robot => l10n.characterTypeRobot,
      CharacterType.humanoid => l10n.characterTypeHumanoid,
      CharacterType.geneticExperiment => l10n.characterTypeGeneticExperiment,
      CharacterType.superhuman => l10n.characterTypeSuperhuman,
      CharacterType.humanWithAntennae => l10n.characterTypeHumanWithAntennae,
      CharacterType.humanWithAntsBrain => l10n.characterTypeHumanWithAntsBrain,
      CharacterType.game => l10n.characterTypeGame,
      CharacterType.clone => l10n.characterTypeClone,
      CharacterType.selfAware => l10n.characterTypeSelfAware,
      CharacterType.cyborg => l10n.characterTypeCyborg,
      CharacterType.birdPerson => l10n.characterTypeBirdPerson,
      CharacterType.corn => l10n.characterTypeCorn,
      CharacterType.pickle => l10n.characterTypePickle,
      CharacterType.cat => l10n.characterTypeCat,
      CharacterType.animatedCar => l10n.characterTypeAnimatedCar,
      CharacterType.unknown => l10n.characterTypeUnknown,
      CharacterType.other => type,
    };
  }

  String _translateUnknown(String value, AppLocalizations l10n) {
    if (value.toLowerCase() == 'unknown') {
      return l10n.statusUnknown;
    }
    return value;
  }
}

class _StatusChip extends StatelessWidget {
  final CharacterStatus status;
  const _StatusChip({required this.status});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Chip(
      avatar: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getStatusColor(status),
        ),
      ),
      label: Text(_getStatusLabel(status, l10n)),
      backgroundColor: _getStatusColor(status).withValues(alpha: 0.1),
      side: BorderSide.none,
    );
  }

  Color _getStatusColor(CharacterStatus status) {
    return switch (status) {
      CharacterStatus.alive => Color(ThemesColor.green.colorValue),
      CharacterStatus.dead => Color(ThemesColor.red.colorValue),
      CharacterStatus.unknown => Color(ThemesColor.gray.colorValue),
    };
  }

  String _getStatusLabel(CharacterStatus status, AppLocalizations l10n) {
    return switch (status) {
      CharacterStatus.alive => l10n.statusAlive,
      CharacterStatus.dead => l10n.statusDead,
      CharacterStatus.unknown => l10n.statusUnknown,
    };
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    final isClickable = onTap != null;
    final content = Row(
      children: [
        Icon(icon, size: layout.icon.small, color: theme.colorScheme.primary),
        SizedBox(width: layout.spacing.small),
        Text(
          '$label: ',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isClickable
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              decoration: null,
              decorationColor: null,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isClickable)
          Icon(
            Icons.chevron_right,
            size: layout.icon.small,
            color: theme.colorScheme.primary,
          ),
      ],
    );
    if (isClickable) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius.small),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: layout.spacing.tiny),
          child: content,
        ),
      );
    }
    return content;
  }
}
