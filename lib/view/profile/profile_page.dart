import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telepass_courses/services/auth_handler.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
        onPressed: () {
          context.read<AuthHandler>().logout();
        },
        child: const Text("Logout"),
      ),
    );
  }
}
