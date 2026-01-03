import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/menus/mobile_menu.dart';
import 'package:marshaller/utils/helpers/app_navigation.dart';

class AppScaffold extends StatelessWidget {
  final Text? title;
  final bool showBackButton;
  final List<Widget>? actions;
  final bool? isFullWidth;
  final Widget body;
  final bool scrollable;
  final Future<void> Function()? onRefresh;
  final bool? showMenuButton;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.showBackButton = true,
    this.actions,
    this.isFullWidth,
    this.scrollable = true,
    this.onRefresh,
    this.showMenuButton = true,
    this.backgroundColor,
    this.floatingActionButton,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = theme.layout;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: title,
        backgroundColor: backgroundColor,
        leading: showBackButton && AppNavigation.canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => AppNavigation.pop(),
              )
            : null,
        actions: [
          if (actions != null) ...?actions,
          if (showMenuButton == true)
            Builder(
              builder: (context) => Padding(
                padding: EdgeInsets.only(right: layout.padding.medium),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              ),
            ),
        ],
      ),
      drawer: const MobileMenu(),
      body: SafeArea(child: _buildBody(context)),
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _buildBody(BuildContext context) {
    Widget contentWidget = scrollable
        ? SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: body,
          )
        : body;
    if (isFullWidth != true) {
      contentWidget = Padding(
        padding: EdgeInsets.all(Theme.of(context).layout.padding.medium),
        child: contentWidget,
      );
    }
    if (onRefresh != null) {
      contentWidget = RefreshIndicator(
        onRefresh: onRefresh!,
        child: contentWidget,
      );
    }
    return contentWidget;
  }
}
