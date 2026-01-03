import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/domain/entities/location.dart';
import 'package:marshaller/domain/enums/location_type.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/app_shimmer.dart';
import 'package:marshaller/ui/core/widgets/layouts/app_scaffold.dart';
import 'package:marshaller/ui/core/widgets/app_card.dart';
import 'package:marshaller/ui/locations/viewmodels/location_list_state.dart';
import 'package:marshaller/ui/locations/viewmodels/location_list_viewmodel.dart';
import 'package:marshaller/utils/helpers/app_navigation.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';
import 'package:marshaller/ui/core/widgets/inputs/app_input_search.dart';

class LocationsPage extends StatefulWidget {
  final String? type;
  final String? dimension;

  const LocationsPage({super.key, this.type, this.dimension});
  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  late final LocationListViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.I<LocationListViewModel>();
    _viewModel.loadLocationsCommand.execute((
      forceRefresh: false,
      type: widget.type,
      dimension: widget.dimension,
      name: null,
    ));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
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
    Text? title = Text(l10n.locations);
    if (widget.type != null) {
      title = null;
    } else if (widget.dimension != null) {
      title = null;
    }
    return AppScaffold(
      title: title,
      scrollable: false,
      body: ValueListenableBuilder<LocationListState>(
        valueListenable: _viewModel.state,
        builder: (context, state, _) {
          return switch (state) {
            LocationListInitial() => const SizedBox.shrink(),
            LocationListLoading() => _buildShimmerList(context),
            LocationListLoaded() => _buildLocationList(context, state),
            LocationListError(:final message) => _buildError(context, message),
          };
        },
      ),
    );
  }

  Widget _buildShimmerList(BuildContext context) {
    final layout = Theme.of(context).layout;
    return ListView.builder(
      itemCount: 11,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.only(bottom: layout.spacing.medium),
            child: AppShimmer(
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(layout.radius.small),
                ),
              ),
            ),
          );
        }
        return _buildShimmerCard(context);
      },
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

  Widget _buildLocationList(BuildContext context, LocationListLoaded state) {
    final layout = Theme.of(context).layout;
    final l10n = AppLocalizations.of(context);
    final hasFilter = widget.type != null || widget.dimension != null;
    final hasHeaderItem = hasFilter ? 1 : 0;
    final hasSearchItem = 1;
    final hasEmptyResults = state.locations.isEmpty;
    final hasEmptyItem = hasEmptyResults ? 1 : 0;
    final specialItems = hasHeaderItem + hasSearchItem + hasEmptyItem;

    return RefreshIndicator(
      onRefresh: () async {
        await _viewModel.loadLocationsCommand.execute((
          forceRefresh: true,
          type: widget.type,
          dimension: widget.dimension,
          name: _searchController.text.isEmpty ? null : _searchController.text,
        ));
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
            specialItems + state.locations.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (hasFilter && index == 0) {
            return _buildFilterHeader(context, state.totalCount, l10n);
          }
          final searchIndex = hasFilter ? 1 : 0;
          if (index == searchIndex) {
            return Padding(
              padding: EdgeInsets.only(bottom: layout.spacing.medium),
              child: AppInputSearch(
                controller: _searchController,
                hintText: l10n.searchLocations,
                onSubmitted: _handleSearch,
                onCleared: () => _handleSearch(''),
              ),
            );
          }
          final emptyIndex = searchIndex + 1;
          if (hasEmptyResults && index == emptyIndex) {
            return _buildEmptyResults(context, l10n);
          }
          final adjustedIndex = index - specialItems;
          if (adjustedIndex >= state.locations.length) {
            return _buildLoadingMore(context);
          }
          final location = state.locations[adjustedIndex];
          return Padding(
            padding: EdgeInsets.only(bottom: layout.spacing.medium),
            child: _buildLocationCard(context, location),
          );
        },
      ),
    );
  }

  void _handleSearch(String query) {
    _viewModel.loadLocationsCommand.execute((
      forceRefresh: true,
      type: widget.type,
      dimension: widget.dimension,
      name: query.isEmpty ? null : query,
    ));
  }

  Widget _buildEmptyResults(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: layout.padding.large),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: layout.icon.xlarge,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: layout.spacing.medium),
            Text(
              l10n.noResults,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
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

    if (widget.type != null) {
      filterValue = _getTypeLabel(widget.type!, l10n);
      filterLabel = l10n.type;
      filterIcon = Icons.category_outlined;
    } else if (widget.dimension != null) {
      filterValue = _translateUnknown(widget.dimension!, l10n);
      filterLabel = l10n.dimension;
      filterIcon = Icons.public;
    }

    final countText = l10n.locationsCount(totalCount);

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

  Widget _buildLocationCard(BuildContext context, Location location) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    final l10n = AppLocalizations.of(context);
    return AppCard(
      leading: Container(
        width: 100,
        decoration: BoxDecoration(color: theme.colorScheme.primaryContainer),
        child: Center(
          child: Icon(
            Icons.location_on,
            color: theme.colorScheme.onPrimaryContainer,
            size: layout.icon.xlarge,
          ),
        ),
      ),
      title: Text(location.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location.type,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: layout.spacing.tiny),
          Row(
            children: [
              Icon(
                Icons.public,
                size: layout.icon.small,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: layout.spacing.tiny),
              Expanded(
                child: Text(
                  _translateUnknown(location.dimension, l10n),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: layout.spacing.tiny),
          Text(
            l10n.residentsCount(location.residents.length),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      onTap: () => _navigateToDetail(location.id),
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
              onPressed: () => _viewModel.loadLocationsCommand.execute((
                forceRefresh: false,
                type: widget.type,
                dimension: widget.dimension,
                name: _searchController.text.isEmpty
                    ? null
                    : _searchController.text,
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
      AppRoutes.locationDetail,
      pathParameters: {'id': id.toString()},
    );
  }

  String _translateUnknown(String value, AppLocalizations l10n) {
    if (value.toLowerCase() == 'unknown') {
      return l10n.statusUnknown;
    }
    return value;
  }

  String _getTypeLabel(String type, AppLocalizations l10n) {
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
}
