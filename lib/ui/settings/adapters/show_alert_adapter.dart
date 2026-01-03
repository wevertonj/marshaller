import 'package:marshaller/ui/settings/adapters/settings_option_adapter.dart';

class ShowAlertAdapter extends SettingsOptionAdapter<bool> {
  ShowAlertAdapter({required super.context, required super.settings});
  @override
  String getLabel(bool value) {
    return value ? l10n.yes : l10n.no;
  }

  @override
  bool getSelected() {
    return settings.showAlertPage;
  }

  @override
  void onTap() {
    viewmodel.showAlertPageCommand.execute(!getSelected());
  }
}
