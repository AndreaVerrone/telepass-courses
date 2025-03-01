import 'package:flutter/material.dart';
import 'package:telepass_courses/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(toolbarHeight: 75),
        iconTheme: const IconThemeData(size: 22),
      ),
      routes: Routes.routes,
      initialRoute: Routes.routeLogin,
    );
  }
}
