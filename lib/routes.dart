import 'package:flutter/material.dart';
import 'package:telepass_courses/view/authentication/login_page.dart';
import 'package:telepass_courses/view/authentication/register_page.dart';

class Routes {
  static const routeLogin = "/login";
  static const routeRegister = "/register";
  static const routeHome = "/home";

  static final Map<String, Widget Function(BuildContext)> _routes = {
    routeLogin: (_) => const LoginPage(),
    routeRegister: (_) => const RegisterPage(),
    routeHome: (_) => const Placeholder(),
  };

  static Map<String, Widget Function(BuildContext)> get routes => {..._routes};
}
