import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:marshaller/config/dependencies.dart';
import 'package:marshaller/config/go_router.dart';
import 'package:marshaller/domain/enums/themes_color.dart';
import 'package:marshaller/ui/core/theme/app_theme.dart';
import 'package:marshaller/ui/settings/viewmodels/settings_viewmodel.dart';
import 'package:marshaller/utils/helpers/app_logger.dart';
import 'package:marshaller/utils/l10n/generated/app_localizations.dart';

Future<bool> _initializeFirebase() async {
  try {
    await Firebase.initializeApp();
    return true;
  } catch (e) {
    return false;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseInitialized = await _initializeFirebase();
  if (!firebaseInitialized) {
    AppLogger.warning(
      '⚠️ Firebase não foi inicializado. '
      'Configure o firebase_options.dart para habilitar Firebase, '
      'Push Notifications e Crashlytics.',
    );
  }

  setupDependencies();
  runApp(const MarshallerApp());
}

class MarshallerApp extends StatefulWidget {
  const MarshallerApp({super.key});
  @override
  State<MarshallerApp> createState() => _MarshallerAppState();
}

class _MarshallerAppState extends State<MarshallerApp> {
  @override
  Widget build(BuildContext context) {
    final settingsViewModel = GetIt.I<SettingsViewModel>();
    return ListenableBuilder(
      listenable: settingsViewModel,
      builder: (context, _) {
        final settings = settingsViewModel.settings;
        final seedColor = Color(
          ThemesColor.values[settings.theme.index].colorValue,
        );
        return MaterialApp.router(
          title: 'Marshaller',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(seedColor),
          darkTheme: AppTheme.dark(seedColor),
          themeMode: settings.darkMode,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
            Locale('en', 'US'),
            Locale('es', 'ES'),
          ],
          locale: settings.locale.toLocale(),
          routerConfig: goRouter,
        );
      },
    );
  }
}
