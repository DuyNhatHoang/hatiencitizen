import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
SharedPreferences prefs;
main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  Bloc.observer = SimpleBlocObserver();
  runApp(App(key: appKey,));
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    // print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error.toString());
    super.onError(cubit, error, stackTrace);
  }
}
