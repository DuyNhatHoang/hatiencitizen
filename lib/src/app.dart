import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ha_tien_app/src/ui/add_image/add_images_screen.dart';
import 'package:ha_tien_app/src/ui/detail_event/detail_event_screen.dart';
import 'package:ha_tien_app/src/ui/detail_notification/detail_notification_screen.dart';
import 'package:ha_tien_app/src/ui/home/dssc/detail_employee_event_screen.dart';
import 'package:ha_tien_app/src/ui/home/dssc/update_event_screen.dart';
import 'package:ha_tien_app/src/ui/home/home_screen.dart';
import 'package:ha_tien_app/src/ui/login/login_screen.dart';
import 'package:ha_tien_app/src/ui/map/tracking_location_screen.dart';
import 'package:ha_tien_app/src/ui/photo_view/photo_view_screen.dart';
import 'package:ha_tien_app/src/ui/register/register_screen.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'ui/splash/splash_screen.dart';
import 'utils/my_colors.dart';
import 'package:google_map_location_picker/generated/l10n.dart'
    as location_picker;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  final  Locale locate;

  const MyApp({Key key, this.locate}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale locate;

  void setLocale(Locale value) {
    setState(() {
      locate = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locate = widget.locate;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locate,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        const Locale('en'),
        const Locale('vi'),
      ],
      title: 'Cán Bộ Hà Tiên',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
          iconTheme: IconThemeData(color: kPrimaryColor)),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == LoginScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return LoginScreen();
          });
        } else if (settings.name == HomeScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return HomeScreen();
          });
        } else if (settings.name == AddImageScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return AddImageScreen(images: settings.arguments);
          });
        } else if (settings.name == DetailEventScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return DetailEventScreen(
              item: settings.arguments,
            );
          });
        } else if (settings.name == RegisterScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return RegisterScreen();
          });
        } else if (settings.name == DetailEmployeeEventScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return DetailEmployeeEventScreen(
              argument: settings.arguments,
            );
          });
        } else if (settings.name == TrackingLocationScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return TrackingLocationScreen(
              event: settings.arguments,
            );
          });
        } else if (settings.name == UpdateEventScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return UpdateEventScreen(
              argument: settings.arguments,
            );
          });
        } else if (settings.name == PhotoViewScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return PhotoViewScreen(
              files: settings.arguments,
            );
          });
        } else if (settings.name == DetailNotificationScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return DetailNotificationScreen(
              notificationId: settings.arguments,
            );
          });
        }
        return null;
      },
      routes: {
        // '/': (context) => EnforcementReport(),
        '/': (context) => SplashScreen(),
      },
    );
  }
}


