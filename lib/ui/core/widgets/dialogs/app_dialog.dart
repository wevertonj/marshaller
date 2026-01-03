import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

class AppDialog {
  final BuildContext _context;
  static bool _isDialogOpen = false;
  AppDialog(this._context);
  static AppDialog of(BuildContext context) => AppDialog(context);
  void base(
    String message, {
    void Function()? onPressed,
    required String title,
    List<Widget>? actions,
  }) {
    if (_isDialogOpen) return;
    _isDialogOpen = true;
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Theme.of(context).layout.radius.medium,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(message),
        actions:
            actions ??
            [
              TextButton(
                onPressed: () {
                  _isDialogOpen = false;
                  Navigator.of(context).pop();
                  if (onPressed != null) onPressed();
                },
                child: Text(
                  AppLocalizations.of(context).ok,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
      ),
    ).then((_) {
      _isDialogOpen = false;
    });
  }

  void error(String message, {void Function()? onPressed, String? textButton}) {
    final l10n = AppLocalizations.of(_context);
    base(
      message,
      title: l10n.error,
      onPressed: null,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(_context).pop();
            if (onPressed != null) {
              onPressed();
            }
          },
          child: Text(
            textButton ?? l10n.ok,
            style: TextStyle(color: Theme.of(_context).colorScheme.primary),
          ),
        ),
      ],
    );
  }

  void info(String message, {void Function()? onPressed, String? textButton}) {
    final l10n = AppLocalizations.of(_context);
    base(
      message,
      title: l10n.info,
      onPressed: null,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(_context).pop();
            if (onPressed != null) {
              onPressed();
            }
          },
          child: Text(
            textButton ?? l10n.close,
            style: TextStyle(color: Theme.of(_context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
