import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:localization/localization.dart';
import 'package:rocket_launcher_app/data/launches_response.dart';
import 'package:rocket_launcher_app/utils/routeNames.dart';
import 'package:rocket_launcher_app/utils/routes.dart';
import 'package:rocket_launcher_app/utils/utils.dart';
import 'package:rocket_launcher_app/views/homeView/launch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/appTheme.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await LaunchService.fetchUpcomingLaunches();
  // await LaunchService.fetchPastLaunches();
  await selectedAppTheme.init();
  await selectedAppLanguage.init();
  await selectedFontSizeFactor.init();
  var delegate = await LocalizationDelegate.create(
    preferences: TranslatePreferences(),
    fallbackLocale: selectedAppLanguage.getMode()??'en',
    supportedLocales: [
      'en',
      'es',
      'hi',
    ]);
  runApp(LocalizedApp(delegate, MyApp()));
  // runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    // LocalJsonLocalization.delegate.directories = ['assets/i18n'];
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black
    ));

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          localizationDelegate
          // LocalJsonLocalization.delegate,
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        title: 'Rocket Launcher Visualizer',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        initialRoute: RouteNames.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

class TranslatePreferences implements ITranslatePreferences {
  static const String _selectedLocaleKey = 'selected_locale';

  @override
  Future<Locale?> getPreferredLocale() async {
    final preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey(_selectedLocaleKey)) return null;

    var locale = preferences.getString(_selectedLocaleKey);

    return localeFromString(locale.toString());
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_selectedLocaleKey, localeToString(locale));
  }
}

