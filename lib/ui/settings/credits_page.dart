import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:marshaller/domain/entities/credit_entity.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/ui/core/widgets/layouts/app_scaffold.dart';
import 'package:marshaller/utils/constants/app_assets.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});
  static List<CreditEntity> _getCredits(AppLocalizations l10n) => [
    CreditEntity(
      name: 'Alert Animation',
      author: 'Ashleyy',
      license: l10n.lottieSimpleLicense,
      source: l10n.lottieFilesSource,
      url: 'https://lottiefiles.com/',
      type: CreditType.animation,
      image: AppAssets.animations.alert,
    ),
    CreditEntity(
      name: 'Biometric Animation',
      author: 'Karam Ibrahim',
      license: l10n.lottieSimpleLicense,
      source: l10n.lottieFilesSource,
      url: 'https://lottiefiles.com/',
      type: CreditType.animation,
      image: AppAssets.animations.biometric,
    ),
    CreditEntity(
      name: 'Delete Animation',
      author: 'Pragati Bansal',
      license: l10n.lottieSimpleLicense,
      source: l10n.lottieFilesSource,
      url: 'https://lottiefiles.com/',
      type: CreditType.animation,
      image: AppAssets.animations.delete,
    ),
    CreditEntity(
      name: 'Fingerprint Animation',
      author: 'Mahendra',
      license: l10n.lottieSimpleLicense,
      source: l10n.lottieFilesSource,
      url: 'https://lottiefiles.com/',
      type: CreditType.animation,
      image: AppAssets.animations.fingerprint,
    ),
    CreditEntity(
      name: 'Marketing Animation',
      author: 'Mahendra Bhunwal',
      license: l10n.lottieSimpleLicense,
      source: l10n.lottieFilesSource,
      url: 'https://lottiefiles.com/',
      type: CreditType.animation,
      image: AppAssets.animations.apiWarning,
    ),
    CreditEntity(
      name: 'Register Animation',
      author: 'Avinash Reddy',
      license: l10n.lottieSimpleLicense,
      source: l10n.lottieFilesSource,
      url: 'https://lottiefiles.com/',
      type: CreditType.animation,
      image: AppAssets.animations.login,
    ),
    CreditEntity(
      name: 'The Rick and Morty API',
      author: 'Axel Fuhrmann',
      license: 'BSD-3-Clause',
      source: 'API',
      url: 'https://rickandmortyapi.com/',
      type: CreditType.library,
    ),
    CreditEntity(
      name: 'Flutter Framework',
      author: 'Google',
      license: 'BSD 3-Clause License',
      source: 'GitHub',
      url: 'https://github.com/flutter/flutter',
      type: CreditType.library,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = theme.layout.spacing;
    final l10n = AppLocalizations.of(context);
    final credits = _getCredits(l10n);
    return AppScaffold(
      title: Text(l10n.credits),
      showMenuButton: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spacing.large),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing.medium),
              child: Text.rich(
                TextSpan(
                  style: theme.textTheme.bodyMedium,
                  children: [
                    TextSpan(text: l10n.creditsDevelopedBy),
                    TextSpan(
                      text: 'Weverton Silva',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            _launchUrl('https://github.com/wevertonj'),
                    ),
                    TextSpan(text: l10n.creditsUsingDataFrom),
                    TextSpan(
                      text: 'The Rick and Morty API',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            _launchUrl('https://rickandmortyapi.com/'),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
            SizedBox(height: spacing.large),
            _buildSectionTitle(context, l10n.thirdPartyLibraries),
            ...credits
                .where((c) => c.type == CreditType.library)
                .map((credit) => _buildCreditListTile(context, credit, l10n)),
            SizedBox(height: spacing.large),
            _buildSectionTitle(context, l10n.thirdPartyAssets),
            ...credits
                .where((c) => c.type == CreditType.animation)
                .map((credit) => _buildCreditListTile(context, credit, l10n)),
            SizedBox(height: spacing.large),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.layout.spacing.medium,
        vertical: theme.layout.spacing.small,
      ),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildCreditListTile(
    BuildContext context,
    CreditEntity credit,
    AppLocalizations l10n,
  ) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: _buildAnimationOrIcon(context, credit),
      ),
      title: Text(
        credit.name,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'por ${credit.author}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _buildInfoChip(context, l10n.license, credit.license),
              if (credit.source != null)
                _buildInfoChip(context, l10n.source, credit.source!),
            ],
          ),
          if (credit.url != null) ...[
            SizedBox(height: 4),
            Text(
              credit.url!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
      isThreeLine: true,
    );
  }

  Widget _buildAnimationOrIcon(BuildContext context, CreditEntity credit) {
    if (credit.image != null) {
      final imagePath = credit.image!;
      if (imagePath.endsWith('.json')) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Lottie.asset(
            imagePath,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
            repeat: true,
            animate: true,
          ),
        );
      }
    }
    return Icon(
      _getIconForType(credit.type),
      size: 20,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildInfoChip(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForType(CreditType type) {
    switch (type) {
      case CreditType.animation:
        return Icons.play_circle_outline_rounded;
      case CreditType.library:
        return Icons.code_rounded;
      case CreditType.asset:
        return Icons.image_outlined;
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
