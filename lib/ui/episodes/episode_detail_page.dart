import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/domain/enums/character_status.dart';
import 'package:marshaller/domain/enums/themes_color.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/app_card.dart';
import 'package:marshaller/ui/core/widgets/app_shimmer.dart';
import 'package:marshaller/ui/core/widgets/layouts/app_scaffold.dart';
import 'package:marshaller/ui/episodes/viewmodels/episode_detail_state.dart';
import 'package:marshaller/ui/episodes/viewmodels/episode_detail_viewmodel.dart';
import 'package:marshaller/utils/helpers/app_navigation.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

class EpisodeDetailPage extends StatefulWidget {
  final int episodeId;
  const EpisodeDetailPage({super.key, required this.episodeId});
  @override
  State<EpisodeDetailPage> createState() => _EpisodeDetailPageState();
}

class _EpisodeDetailPageState extends State<EpisodeDetailPage> {
  late final EpisodeDetailViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.I<EpisodeDetailViewModel>();
    _viewModel.loadEpisodeCommand.execute(widget.episodeId);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ValueListenableBuilder<EpisodeDetailState>(
        valueListenable: _viewModel.state,
        builder: (context, state, _) {
          return switch (state) {
            EpisodeDetailInitial() => const SizedBox.shrink(),
            EpisodeDetailLoading() => _buildShimmer(context),
            EpisodeDetailLoaded() => _buildContent(context, state),
            EpisodeDetailError(:final message) => _buildError(context, message),
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
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(layout.radius.medium),
              ),
            ),
          ),
          SizedBox(height: layout.spacing.medium),
          AppShimmer(
            child: Container(
              height: 150,
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

  Widget _buildContent(BuildContext context, EpisodeDetailLoaded state) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    final l10n = AppLocalizations.of(context);
    final episode = state.episode;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(layout.padding.large),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(layout.radius.large),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.movie_outlined,
                  size: 48,
                  color: theme.colorScheme.primary,
                ),
                SizedBox(height: layout.spacing.medium),
                Text(
                  episode.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: layout.spacing.small),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: layout.padding.medium,
                    vertical: layout.padding.tiny,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(layout.radius.small),
                  ),
                  child: Text(
                    episode.episodeCode,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
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
                _BuildInfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: l10n.airDate,
                  value: DateFormat.yMMMd(
                    Localizations.localeOf(context).toString(),
                  ).format(episode.airDate),
                  layout: layout,
                  theme: theme,
                ),
                SizedBox(height: layout.spacing.medium),
                _BuildInfoRow(
                  icon: Icons.tv_outlined,
                  label: l10n.season,
                  value: episode.seasonNumber.toString(),
                  layout: layout,
                  theme: theme,
                  onTap: () {
                    final seasonCode =
                        'S${episode.seasonNumber.toString().padLeft(2, '0')}';
                    AppNavigation.pushNamed(
                      AppRoutes.seasonDetail,
                      pathParameters: {'seasonCode': seasonCode},
                    );
                  },
                ),
                SizedBox(height: layout.spacing.medium),
                _BuildInfoRow(
                  icon: Icons.format_list_numbered_outlined,
                  label: l10n.episode,
                  value: episode.episodeNumber.toString(),
                  layout: layout,
                  theme: theme,
                ),
              ],
            ),
          ),
          SizedBox(height: layout.spacing.medium),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.people_outline,
                    size: layout.icon.medium,
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(width: layout.spacing.small),
                  Text(
                    l10n.characters,
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
                      '${state.characters.length}',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: layout.spacing.medium),
              if (state.isLoadingCharacters)
                _buildCharactersShimmer(context)
              else if (state.characters.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(layout.padding.medium),
                    child: Text(
                      l10n.noCharactersFound,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.characters.length,
                  separatorBuilder: (_, _) =>
                      SizedBox(height: layout.spacing.small),
                  itemBuilder: (context, index) {
                    final character = state.characters[index];
                    return _CharacterCard(character: character);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCharactersShimmer(BuildContext context) {
    final layout = Theme.of(context).layout;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, _) => SizedBox(height: layout.spacing.small),
      itemBuilder: (_, _) => const AppShimmer(child: _CharacterCardShimmer()),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(layout.padding.large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: layout.icon.large * 2,
              color: theme.colorScheme.error,
            ),
            SizedBox(height: layout.spacing.medium),
            Text(
              message,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: layout.spacing.medium),
            FilledButton.icon(
              onPressed: () =>
                  _viewModel.loadEpisodeCommand.execute(widget.episodeId),
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final dynamic layout;
  final ThemeData theme;
  final VoidCallback? onTap;

  const _BuildInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.layout,
    required this.theme,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(layout.radius.medium),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: layout.padding.small),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(layout.padding.small),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(layout.radius.medium),
              ),
              child: Icon(
                icon,
                size: layout.icon.small,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(width: layout.spacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: onTap != null ? theme.colorScheme.primary : null,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.chevron_right,
                size: layout.icon.small,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
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
}

class _StatusIndicator extends StatelessWidget {
  final CharacterStatus status;
  const _StatusIndicator({required this.status});
  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      CharacterStatus.alive => Color(ThemesColor.green.colorValue),
      CharacterStatus.dead => Color(ThemesColor.red.colorValue),
      CharacterStatus.unknown => Color(ThemesColor.gray.colorValue),
    };
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _CharacterCardShimmer extends StatelessWidget {
  const _CharacterCardShimmer();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(layout.padding.small),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(layout.radius.small),
              ),
            ),
            SizedBox(width: layout.spacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 16,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(layout.radius.small),
                    ),
                  ),
                  SizedBox(height: layout.spacing.tiny),
                  Container(
                    width: 80,
                    height: 12,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(layout.radius.small),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
