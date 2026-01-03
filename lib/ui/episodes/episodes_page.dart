import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/domain/entities/episode.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/utils/formatters/date_formatter.dart';
import 'package:marshaller/ui/core/widgets/app_shimmer.dart';
import 'package:marshaller/ui/core/widgets/layouts/app_scaffold.dart';
import 'package:marshaller/ui/core/widgets/app_card.dart';
import 'package:marshaller/ui/episodes/viewmodels/episode_list_state.dart';
import 'package:marshaller/ui/episodes/viewmodels/episode_list_viewmodel.dart';
import 'package:marshaller/utils/helpers/app_navigation.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({super.key});
  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  late final EpisodeListViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.I<EpisodeListViewModel>();
    _viewModel.loadEpisodesCommand.execute(false);
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: Text(l10n.episodes),
      scrollable: false,
      body: ValueListenableBuilder<EpisodeListState>(
        valueListenable: _viewModel.state,
        builder: (context, state, _) {
          return switch (state) {
            EpisodeListInitial() => const SizedBox.shrink(),
            EpisodeListLoading() => _buildShimmerList(context),
            EpisodeListLoaded() => _buildEpisodeList(context, state),
            EpisodeListError(:final message) => _buildError(context, message),
          };
        },
      ),
    );
  }

  Widget _buildShimmerList(BuildContext context) {
    return ListView.builder(
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

  Widget _buildEpisodeList(BuildContext context, EpisodeListLoaded state) {
    final layout = Theme.of(context).layout;
    return RefreshIndicator(
      onRefresh: () async {
        await _viewModel.loadEpisodesCommand.execute(true);
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: state.episodes.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.episodes.length) {
            return _buildLoadingMore(context);
          }
          final episode = state.episodes[index];
          return Padding(
            padding: EdgeInsets.only(bottom: layout.spacing.medium),
            child: _buildEpisodeCard(context, episode),
          );
        },
      ),
    );
  }

  Widget _buildEpisodeCard(BuildContext context, Episode episode) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    final l10n = AppLocalizations.of(context);
    return AppCard(
      leading: Container(
        width: 100,
        decoration: BoxDecoration(color: theme.colorScheme.tertiaryContainer),
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
      onTap: () => _navigateToDetail(episode.id),
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
              onPressed: () => _viewModel.loadEpisodesCommand.execute(false),
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
      AppRoutes.episodeDetail,
      pathParameters: {'id': id.toString()},
    );
  }
}
