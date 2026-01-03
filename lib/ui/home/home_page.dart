import 'package:flutter/material.dart';
import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/config/go_router.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/layouts/app_scaffold.dart';
import 'package:marshaller/ui/core/widgets/app_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  String _getGreeting(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 12) {
      return l10n.goodMorning;
    } else if (hour >= 12 && hour < 18) {
      return l10n.goodAfternoon;
    } else if (hour >= 18 && hour < 22) {
      return l10n.goodEvening;
    } else {
      return l10n.goodNight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final layout = Theme.of(context).layout;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return AppScaffold(
      showBackButton: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_getGreeting(context), style: textTheme.headlineMedium),
            SizedBox(height: layout.spacing.small),
            Text(
              l10n.exploreRickAndMorty,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: layout.spacing.xlarge),
            _buildNavigationCard(
              context,
              title: l10n.characters,
              subtitle: l10n.charactersDescription,
              icon: Icons.person,
              color: colorScheme.inversePrimary,
              iconColor: colorScheme.onPrimaryContainer,
              onTap: () => goRouter.pushNamed(AppRoutes.characters),
            ),
            SizedBox(height: layout.spacing.medium),
            _buildNavigationCard(
              context,
              title: l10n.locations,
              subtitle: l10n.locationsDescription,
              icon: Icons.location_on,
              color: colorScheme.secondaryContainer,
              iconColor: colorScheme.onSecondaryContainer,
              onTap: () => goRouter.pushNamed(AppRoutes.locations),
            ),
            SizedBox(height: layout.spacing.medium),
            _buildNavigationCard(
              context,
              title: l10n.episodes,
              subtitle: l10n.episodesDescription,
              icon: Icons.movie,
              color: colorScheme.tertiaryContainer,
              iconColor: colorScheme.onTertiaryContainer,
              onTap: () => goRouter.pushNamed(AppRoutes.episodes),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return AppCard(
      leading: Container(
        width: 100,
        decoration: BoxDecoration(color: color),
        child: Center(child: Icon(icon, size: 40, color: iconColor)),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}
