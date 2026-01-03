import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/app_shimmer.dart';

class AppCard extends StatelessWidget {
  final String? imageUrl;

  final Widget? leading;

  final Widget title;

  final Widget? subtitle;

  final Widget? trailing;

  final VoidCallback? onTap;

  final bool showTrailingChevron;

  static const double _leadingWidth = 100.0;

  const AppCard({
    super.key,
    this.imageUrl,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showTrailingChevron = true,
  }) : assert(
         imageUrl != null || leading != null,
         'Either imageUrl or leading must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = theme.layout;

    return Card(
      color: theme.colorScheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLeading(context),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(layout.padding.medium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        child: title,
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: layout.spacing.tiny),
                        DefaultTextStyle(
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          child: subtitle!,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (trailing != null || showTrailingChevron)
                Padding(
                  padding: EdgeInsets.only(right: layout.padding.small),
                  child: Center(
                    child:
                        trailing ??
                        Icon(
                          Icons.chevron_right,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    final theme = Theme.of(context);
    final layout = theme.layout;

    if (imageUrl != null) {
      return SizedBox(
        width: _leadingWidth,
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              AppShimmer(child: Container(color: Colors.white)),
          errorWidget: (context, url, error) => Container(
            color: theme.colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.image_not_supported,
              size: layout.icon.large,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return SizedBox(width: _leadingWidth, child: leading);
  }
}
