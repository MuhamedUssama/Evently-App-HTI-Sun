import 'package:evently_hti_sun/features/authentication/login/login_screen.dart';
import 'package:evently_hti_sun/features/authentication/register/register_screen.dart';
import 'package:evently_hti_sun/features/create_event/create_event.dart';
import 'package:evently_hti_sun/features/main_layout/main_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class RoutesManager {
  static const String register = "/register";
  static const String login = "/login";
  static const String mainLayout = "/mainLayout";
  static const String createEvent = "/createEvent";

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case register:
        {
          return CupertinoPageRoute(builder: (context) => RegisterScreen());
        }

      case login:
        {
          return CupertinoPageRoute(builder: (context) => LoginScreen());
        }

      case mainLayout:
        {
          return CupertinoPageRoute(builder: (context) => MainLayout());
        }
      case createEvent:
        {
          return CupertinoPageRoute(builder: (context) => CreateEvent());
        }
    }
  }
}
