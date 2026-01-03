import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final bool isLoading;
  final ValueChanged<bool>? onChanged;
  final Widget? leading;
  const AppSwitch({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    this.isLoading = false,
    this.onChanged,
    this.leading,
  });
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ListTile(
        leading: leading,
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: _AppSwitchLoading(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }
    return SwitchListTile(
      secondary: leading,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      value: value,
      onChanged: onChanged,
    );
  }
}

class _AppSwitchLoading extends StatelessWidget {
  final Color color;
  const _AppSwitchLoading({required this.color});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 51,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
