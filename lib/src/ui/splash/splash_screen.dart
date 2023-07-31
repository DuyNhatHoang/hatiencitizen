import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_tien_app/src/blocs/auth/auth_bloc.dart';
import 'package:ha_tien_app/src/repositories/remote/auths/auth_repo.dart';
import 'package:ha_tien_app/src/ui/home/home_screen.dart';
import 'package:ha_tien_app/src/ui/login/login_screen.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) {
          return AuthBloc()..add(AuthStarted());
        },
        child: Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (BuildContext context, AuthState state) {
              if (state is AuthSuccess) {
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              } else if (state is AuthFailure) {
                showSnackBar(context, "Phiên đăng nhập quá hạn");
                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
              }
            },
            builder: (context, state) {
              return Center(
                child: Image(
                  image: AssetImage('assets/icons/splash.png'),
                  width: (size.width * 0.8),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
