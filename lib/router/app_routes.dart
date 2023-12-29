import 'package:englishlearning_app/presentation/screens/home_screen.dart';
import 'package:englishlearning_app/presentation/screens/signin_screen.dart';
import 'package:englishlearning_app/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String signInScreen = '/sign_in_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String homeScreen = '/home_screen';

  static Map<String, WidgetBuilder> routes = {
    signInScreen: (context) => SignInScreen(),
    signUpScreen: (context) => SignUpScreen(),
    homeScreen: (context) => const HomeScreen(),
  };
}
