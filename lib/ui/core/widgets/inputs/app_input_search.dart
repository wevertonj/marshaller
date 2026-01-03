import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/widgets/inputs/app_input_container.dart';
import 'package:marshaller/ui/core/widgets/inputs/app_input_decoration.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

class AppInputSearch extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onCleared;
  final String? hintText;

  const AppInputSearch({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.onCleared,
    this.hintText,
  });

  @override
  State<AppInputSearch> createState() => _AppInputSearchState();
}

class _AppInputSearchState extends State<AppInputSearch> {
  late final ValueNotifier<bool> _showClearButton;

  @override
  void initState() {
    super.initState();
    _showClearButton = ValueNotifier(widget.controller.text.isNotEmpty);
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _showClearButton.value = widget.controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _showClearButton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return AppInputContainer(
      child: ValueListenableBuilder<bool>(
        valueListenable: _showClearButton,
        builder: (context, showClear, _) {
          return TextField(
            controller: widget.controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              FocusScope.of(context).unfocus();
              widget.onSubmitted?.call(value);
            },
            decoration:
                AppInputDecoration.build(
                  context: context,
                  labelText: widget.hintText ?? l10n.search,
                  prefixText: null,
                ).copyWith(
                  prefixIcon: Icon(
                    Icons.search,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  suffixIcon: showClear
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          color: theme.colorScheme.onSurfaceVariant,
                          onPressed: () {
                            widget.controller.clear();
                            widget.onCleared?.call();
                            widget.onSubmitted?.call('');
                            FocusScope.of(context).unfocus();
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        )
                      : null,
                ),
          );
        },
      ),
    );
  }
}
