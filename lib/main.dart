import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/routes.dart';
import 'package:telepass_courses/services/auth_handler.dart';
import 'package:telepass_courses/view/authentication/login_page.dart';
import 'package:telepass_courses/view/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthHandler(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(color: primaryColorDark);
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(toolbarHeight: 75),
        iconTheme: const IconThemeData(size: 22),
        textTheme: TextTheme(bodyMedium: textStyle),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(primaryColorDark),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateColor.fromMap({
              WidgetState.disabled: Colors.grey.shade700,
              WidgetState.hovered: primaryColorDark,
              WidgetState.any: primaryColor,
            }),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            shadowColor: const WidgetStatePropertyAll(Colors.transparent),

            backgroundColor: WidgetStateColor.fromMap({
              WidgetState.disabled: Colors.grey.shade200,
              WidgetState.hovered: primaryColor.withAlpha(60 * 255 ~/ 100),
              WidgetState.any: Colors.white,
            }),
            side: const WidgetStateBorderSide.fromMap({
              WidgetState.disabled: BorderSide(color: Colors.grey),
              WidgetState.hovered: BorderSide(color: primaryColor),
              WidgetState.any: BorderSide(color: Colors.grey),
            }),
            foregroundColor: const WidgetStateColor.fromMap({
              WidgetState.disabled: Colors.grey,
              WidgetState.hovered: Colors.white,
              WidgetState.any: Colors.grey,
            }),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      routes: Routes.routes,
      home: Consumer<AuthHandler>(
        builder: (context, auth, child) {
          Navigator.popUntil(context, (route) => route.isFirst);
          if (auth.isLoggedIn) {
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
