import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/domain/entities/character.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/app_card.dart';
import 'package:marshaller/ui/core/widgets/app_shimmer.dart';
import 'package:marshaller/ui/core/widgets/layouts/app_scaffold.dart';
import 'package:marshaller/ui/seasons/viewmodels/season_detail_state.dart';
import 'package:marshaller/ui/seasons/viewmodels/season_detail_viewmodel.dart';
import 'package:marshaller/utils/formatters/date_formatter.dart';
import 'package:marshaller/utils/helpers/app_navigation.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

class SeasonDetailPage extends StatefulWidget {
  final String seasonCode;
  const SeasonDetailPage({super.key, required this.seasonCode});

  @override
  State<SeasonDetailPage> createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  late final SeasonDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.I<SeasonDetailViewModel>();
    _viewModel.loadSeasonCommand.execute(widget.seasonCode);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ValueListenableBuilder<SeasonDetailState>(
        valueListenable: _viewModel.state,
        builder: (context, state, _) {
          return switch (state) {
            SeasonDetailInitial() => const SizedBox.shrink(),
            SeasonDetailLoading() => _buildShimmer(context),
            SeasonDetailLoaded() => _buildContent(context, state),
            SeasonDetailError(:final message) => _buildError(context, message),
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
          SizedBox(height: layout.spacing.large),
          AppShimmer(
            child: Container(
              height: 400,
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

  Widget _buildContent(BuildContext context, SeasonDetailLoaded state) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    final l10n = AppLocalizations.of(context);

    final characters = state.characters;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(layout.padding.large),
            margin: EdgeInsets.only(bottom: layout.padding.large),
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
                Icon(Icons.tv, size: 64, color: theme.colorScheme.primary),
                SizedBox(height: layout.spacing.medium),
                Text(
                  '${l10n.season} ${state.seasonCode.replaceAll('S', '')}',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: layout.spacing.small),
                if (state.startDate != null && state.endDate != null)
                  Text(
                    '${DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(state.startDate!)} - ${DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(state.endDate!)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                SizedBox(height: layout.spacing.small),
                Text(
                  l10n.episodesCount(state.episodes.length),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.episodes,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: layout.spacing.medium),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.episodes.length,
                separatorBuilder: (_, _) =>
                    SizedBox(height: layout.spacing.small),
                itemBuilder: (context, index) {
                  final episode = state.episodes[index];
                  return AppCard(
                    leading: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiaryContainer,
                      ),
                      child: Center(
                        child: Text(
                          episode.episodeNumber.toString(),
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onTertiaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(episode.name),
                    subtitle: Text(
                      DateFormatter.formatDate(episode.airDate),
                      style: theme.textTheme.bodySmall,
                    ),
                    onTap: () => AppNavigation.pushNamed(
                      AppRoutes.episodeDetail,
                      pathParameters: {'id': episode.id.toString()},
                    ),
                  );
                },
              ),
              SizedBox(height: layout.spacing.large),
              Text(
                l10n.characters,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: layout.spacing.medium),
              if (state.isLoadingCharacters)
                _buildCharactersShimmer(context)
              else if (characters.isEmpty)
                Text(l10n.noCharactersFound)
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: characters.length,
                  separatorBuilder: (_, _) =>
                      SizedBox(height: layout.spacing.small),
                  itemBuilder: (context, index) {
                    final character = characters[index];
                    return _CharacterCard(character: character);
                  },
                ),
              SizedBox(height: layout.spacing.large),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCharactersShimmer(BuildContext context) {
    return const AppShimmer(
      child: SizedBox(height: 100, width: double.infinity),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(child: Text(message));
  }
}

class _CharacterCard extends StatelessWidget {
  final Character character;
  const _CharacterCard({required this.character});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      imageUrl: character.image,
      title: Text(character.name),
      subtitle: Text(
        '${character.status.name} - ${character.species}',
        style: theme.textTheme.bodySmall,
      ),
      onTap: () => AppNavigation.pushNamed(
        AppRoutes.characterDetail,
        pathParameters: {'id': character.id.toString()},
      ),
    );
  }
}
