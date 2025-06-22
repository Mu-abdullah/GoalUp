import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app/env_variable.dart';
import 'core/app/no_internet/connection_controller/connection_controller.dart';
import 'core/routes/bloc_observer.dart';
import 'core/services/get_it/git_it.dart';
import 'core/services/shared_pref/shared_pref.dart';
import 'core/services/supabase/supabase_init.dart';
import 'main_sport/main_sport.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvVariable.instance.init(envType: EnvTypeEnum.prod);
  await ConnectionController.instance.init();
  await SupabaseInit().initSupabase();
  await SharedPref.init();
  setupLocator();
  Bloc.observer = AppBlocObserver();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MainSport());
  });
}
