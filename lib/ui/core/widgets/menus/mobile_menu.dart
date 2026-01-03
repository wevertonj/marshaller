import 'package:flutter/material.dart';
import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/utils/helpers/app_navigation.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

class MobileMenu extends StatelessWidget {
  const MobileMenu({super.key});
  Widget _buildDivider(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    return Divider(
      color: Colors.grey.shade600,
      thickness: 1.5,
      indent: mediaWidth * 0.05,
      endIndent: mediaWidth * 0.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    final l10n = AppLocalizations.of(context);
    return Drawer(
      backgroundColor: const Color(0xFF1E1E1E),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: layout.spacing.medium),
              _MenuItem(
                icon: Icons.home,
                title: l10n.home,
                onTap: () => AppNavigation.goNamed(AppRoutes.home),
              ),
              _MenuItem(
                icon: Icons.person,
                title: l10n.characters,
                onTap: () => AppNavigation.pushNamed(AppRoutes.characters),
              ),
              _MenuItem(
                icon: Icons.location_on,
                title: l10n.locations,
                onTap: () => AppNavigation.pushNamed(AppRoutes.locations),
              ),
              _MenuItem(
                icon: Icons.movie,
                title: l10n.episodes,
                onTap: () => AppNavigation.pushNamed(AppRoutes.episodes),
              ),
              _buildDivider(context),
              _MenuItem(
                icon: Icons.info_outline,
                title: l10n.credits,
                onTap: () => AppNavigation.pushNamed(AppRoutes.credits),
              ),
              _MenuItem(
                icon: Icons.settings,
                title: l10n.settings,
                onTap: () => AppNavigation.pushNamed(AppRoutes.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;
  const _MenuItem({required this.icon, required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      onTap: () {
        if (onTap != null) {
          Navigator.of(context).pop();
          Future.delayed(
            const Duration(milliseconds: 100),
          ).then((_) => onTap!());
        }
      },
    );
  }
}
