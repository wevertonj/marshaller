import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/utils/helpers/app_navigation.dart';
import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/enums/character_status.dart';
import 'package:marshaller/domain/enums/location_type.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/app_card.dart';
import 'package:marshaller/ui/core/widgets/app_shimmer.dart';
import 'package:marshaller/ui/core/widgets/layouts/app_scaffold.dart';
import 'package:marshaller/ui/locations/viewmodels/location_detail_state.dart';
import 'package:marshaller/ui/locations/viewmodels/location_detail_viewmodel.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

class LocationDetailPage extends StatefulWidget {
  final int locationId;
  const LocationDetailPage({super.key, required this.locationId});
  @override
  State<LocationDetailPage> createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {
  late final LocationDetailViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.I<LocationDetailViewModel>();
    _viewModel.loadLocationCommand.execute(widget.locationId);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LocationDetailState>(
      valueListenable: _viewModel.state,
      builder: (context, state, _) {
        return AppScaffold(
          body: switch (state) {
            LocationDetailInitial() => const SizedBox.shrink(),
            LocationDetailLoading() => _buildShimmer(context),
            LocationDetailLoaded() => _buildContent(context, state),
            LocationDetailError(:final message) => _buildError(
              context,
              message,
            ),
          },
        );
      },
    );
  }

  Widget _buildShimmer(BuildContext context) {
    final layout = Theme.of(context).layout;
    return SingleChildScrollView(
      child: Column(
        children: [
          AppShimmer(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(layout.radius.large),
              ),
            ),
          ),
          SizedBox(height: layout.spacing.large),
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

  Widget _buildContent(BuildContext context, LocationDetailLoaded state) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    final l10n = AppLocalizations.of(context);
    final location = state.location;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: layout.padding.large,
              horizontal: layout.padding.large,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                  theme.colorScheme.secondaryContainer.withValues(alpha: 0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(layout.radius.large),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 64,
                  color: theme.colorScheme.primary,
                ),
                SizedBox(height: layout.spacing.medium),
                Text(
                  location.name,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: layout.spacing.medium),
                _TypeChip(type: location.type, l10n: l10n),
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
                  label: l10n.type,
                  value: _getLocationTypeLabel(location.type, l10n),
                  onTap: () => AppNavigation.pushNamed(
                    AppRoutes.locationsByType,
                    pathParameters: {'type': location.type},
                  ),
                ),
                SizedBox(height: layout.spacing.medium),
                _InfoRow(
                  icon: Icons.public,
                  label: l10n.dimension,
                  value: _translateUnknown(location.dimension, l10n),
                  onTap: () => AppNavigation.pushNamed(
                    AppRoutes.locationsByDimension,
                    pathParameters: {'dimension': location.dimension},
                  ),
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
                  Icon(Icons.people, color: theme.colorScheme.primary),
                  SizedBox(width: layout.spacing.small),
                  Text(
                    l10n.residents,
                    style: theme.textTheme.titleLarge?.copyWith(
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
                      '${location.residents.length}',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: layout.spacing.medium),
              if (state.isLoadingResidents)
                _buildResidentsShimmer(context)
              else if (state.residents.isEmpty)
                Container(
                  padding: EdgeInsets.all(layout.padding.medium),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(layout.radius.medium),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_off,
                        size: layout.icon.large,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: layout.spacing.small),
                      Text(
                        l10n.noResidentsFound,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.residents.length,
                  separatorBuilder: (_, _) =>
                      SizedBox(height: layout.spacing.small),
                  itemBuilder: (context, index) {
                    final character = state.residents[index];
                    return _CharacterCard(character: character);
                  },
                ),
            ],
          ),
          SizedBox(height: layout.spacing.large),
        ],
      ),
    );
  }

  Widget _buildResidentsShimmer(BuildContext context) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: layout.spacing.small),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(layout.radius.medium),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(layout.radius.medium),
                      bottomLeft: Radius.circular(layout.radius.medium),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(layout.padding.small),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 16,
                          width: 120,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(
                              layout.radius.small,
                            ),
                          ),
                        ),
                        SizedBox(height: layout.spacing.small),
                        Container(
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(
                              layout.radius.small,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
                  _viewModel.loadLocationCommand.execute(widget.locationId),
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}

String _getLocationTypeLabel(String type, AppLocalizations l10n) {
  final locationType = LocationType.fromApiValue(type);
  return switch (locationType) {
    LocationType.planet => l10n.locationTypePlanet,
    LocationType.spaceStation => l10n.locationTypeSpaceStation,
    LocationType.microverse => l10n.locationTypeMicroverse,
    LocationType.tv => l10n.locationTypeTv,
    LocationType.resort => l10n.locationTypeResort,
    LocationType.dimension => l10n.locationTypeDimension,
    LocationType.dream => l10n.locationTypeDream,
    LocationType.fantasyTown => l10n.locationTypeFantasyTown,
    LocationType.menagerie => l10n.locationTypeMenagerie,
    LocationType.game => l10n.locationTypeGame,
    LocationType.customs => l10n.locationTypeCustoms,
    LocationType.daycare => l10n.locationTypeDaycare,
    LocationType.spa => l10n.locationTypeSpa,
    LocationType.policeStation => l10n.locationTypePoliceStation,
    LocationType.arcade => l10n.locationTypeArcade,
    LocationType.quadrant => l10n.locationTypeQuadrant,
    LocationType.spacecraft => l10n.locationTypeSpacecraft,
    LocationType.mount => l10n.locationTypeMount,
    LocationType.cluster => l10n.locationTypeCluster,
    LocationType.unknown => l10n.locationTypeUnknown,
    LocationType.other => type,
  };
}

String _translateUnknown(String value, AppLocalizations l10n) {
  if (value.toLowerCase() == 'unknown') {
    return l10n.statusUnknown;
  }
  return value;
}

class _TypeChip extends StatelessWidget {
  final String type;
  final AppLocalizations l10n;
  const _TypeChip({required this.type, required this.l10n});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = _getLocationTypeLabel(type, l10n);
    return Chip(
      avatar: Icon(
        Icons.category,
        size: 16,
        color: theme.colorScheme.onSecondaryContainer,
      ),
      label: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.onSecondaryContainer,
        ),
      ),
      backgroundColor: theme.colorScheme.secondaryContainer,
      side: BorderSide.none,
    );
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
        Icon(icon, size: layout.icon.medium, color: theme.colorScheme.primary),
        SizedBox(width: layout.spacing.small),
        Text(
          '$label:',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(width: layout.spacing.small),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: isClickable
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
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

class _CharacterCard extends StatelessWidget {
  final Character character;
  const _CharacterCard({required this.character});
  @override
  Widget build(BuildContext context) {
    final layout = Theme.of(context).layout;
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
              SizedBox(width: layout.spacing.tiny),
              Expanded(
                child: Text(
                  '${_getStatusLabel(character.status, l10n)} - ${_translateUnknown(character.species, l10n)}',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: layout.spacing.tiny),
          Text(
            _translateUnknown(character.location.name, l10n),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: layout.spacing.tiny),
          Text(
            l10n.appearsInEpisodes(character.episode.length),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      onTap: () => AppNavigation.pushNamed(
        AppRoutes.characterDetail,
        pathParameters: {'id': character.id.toString()},
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final CharacterStatus status;
  const _StatusIndicator({required this.status});
  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      CharacterStatus.alive => Colors.green,
      CharacterStatus.dead => Colors.red,
      CharacterStatus.unknown => Colors.grey,
    };
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

String _getStatusLabel(CharacterStatus status, AppLocalizations l10n) {
  return switch (status) {
    CharacterStatus.alive => l10n.statusAlive,
    CharacterStatus.dead => l10n.statusDead,
    CharacterStatus.unknown => l10n.statusUnknown,
  };
}
