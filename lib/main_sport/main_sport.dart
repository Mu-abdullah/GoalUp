import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/app/language/language_cubit/language_cubit.dart';
import '../core/app/no_internet/connection_controller/connection_controller.dart';
import '../core/app/user/app_user_cubit/app_user_cubit.dart';
import '../core/functions/custom_scroll.dart';
import '../core/language/app_localizations_setup.dart';
import '../core/language/lang_keys.dart';
import '../core/routes/routes.dart';
import '../core/routes/routes_name.dart';
import '../core/style/color/app_color.dart';
import '../core/style/widgets/app_text.dart';

class MainSport extends StatefulWidget {
  const MainSport({super.key});

  static void updateAppLocale(BuildContext context, Locale locale) {
    final state = context.findAncestorStateOfType<_MainSportState>();
    state?._updateLocale(locale);
  }

  @override
  State<MainSport> createState() => _MainSportState();
}

class _MainSportState extends State<MainSport> {
  Locale _locale = const Locale('ar');
  bool? _wasConnected;
  bool _isConnected = true;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
  _snackBarController;
  void _updateLocale(Locale locale) {
    if (_locale != locale && mounted) {
      setState(() {
        _locale = locale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ConnectionController.instance.isConnected,
      builder: (_, isConnected, __) {
        if (_wasConnected != null && _wasConnected != isConnected) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (isConnected) {
              _snackBarController?.close();
              _scaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(
                  content: AppText(
                    LangKeys.internetRestored,
                    isTitle: true,
                    isBold: true,
                    color: AppColors.white,
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          });
        }

        _wasConnected = isConnected;
        _isConnected = isConnected;

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LanguageCubit()),
            BlocProvider(create: (_) => AppUserCubit()),
          ],
          child: IgnorePointer(
            ignoring: !isConnected,
            child: BlocBuilder<LanguageCubit, String>(
              builder: (context, language) {
                _syncLocaleWithLanguage(language);
                return _buildMaterialApp(
                  initialRoute: _getConnectedInitialRoute(),
                  builder: _appBuilder,
                );
              },
            ),
          ),
        );
      },
    );
  }

  MaterialApp _buildMaterialApp({
    Widget? home,
    String? initialRoute,
    Widget Function(BuildContext, Widget?)? builder,
  }) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      locale: _locale,
      scrollBehavior: MyCustomScrollBehavior(),
      supportedLocales: AppLocalizationsSetup.supportedLocales,
      localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
      localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
      theme: _appTheme,
      builder: builder ?? (_, child) => child!,
      onGenerateRoute: onGenerateRoute,
      initialRoute: initialRoute,
      home: home,
    );
  }

  Widget _appBuilder(BuildContext context, Widget? child) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          // Main content
          child!,

          // Disconnected overlay
          if (!_isConnected)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: AppText(
                    LangKeys.noInternet,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _syncLocaleWithLanguage(String language) {
    final newLocale = Locale(language);
    if (_locale.languageCode != language) {
      _locale = newLocale;
    }
  }

  String _getConnectedInitialRoute() {
    final user = Supabase.instance.client.auth.currentUser;
    return user != null ? RoutesNames.coachHome : RoutesNames.userAuthScreen;
  }

  ThemeData get _appTheme => ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppColors.white,
  );
}
