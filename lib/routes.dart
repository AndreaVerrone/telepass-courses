import 'package:flutter/material.dart';
import 'package:telepass_courses/view/authentication/register_page.dart';

class Routes {
  static const routeRegister = "/register";

  static final Map<String, Widget Function(BuildContext)> _routes = {
    routeRegister: (_) => const RegisterPage(),
  };

  static Map<String, Widget Function(BuildContext)> get routes => {..._routes};
}
