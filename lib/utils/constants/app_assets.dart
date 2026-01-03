class AppAssets {
  static final images = _AppAssetsImages();
  static final animations = _AppAssetsAnimations();
}

class _AppAssetsImages {
  static const String _base = 'assets/images/';
  final String logo = '${_base}runway-logo.png';
}

class _AppAssetsAnimations {
  static const String _base = 'assets/animations/';
  final String alert = '${_base}alert.json';
  final String apiWarning = '${_base}api_warning.json';
  final String login = '${_base}login.json';
  final String biometric = '${_base}biometric.json';
  final String fingerprint = '${_base}fingerprint.json';
  final String systemDown = '${_base}server_down.json';
  final String delete = '${_base}delete.json';
  final String fileScan = '${_base}file_scan.json';
}
