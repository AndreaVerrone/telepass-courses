import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/routes.dart';
import 'package:telepass_courses/services/auth_handler.dart';
import 'package:telepass_courses/view/authentication/accept_conditions.dart';
import 'package:telepass_courses/view/components/footer.dart';
import 'package:telepass_courses/view/components/outlined_text_field.dart';
import 'package:telepass_courses/view/components/separator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  bool conditionsAccepted = false;
  final registerRecognizer = TapGestureRecognizer();

  String? errorText;

  bool get isLoginDisabled =>
      email.isEmpty || password.isEmpty || !conditionsAccepted;

  @override
  void initState() {
    registerRecognizer.onTap = () {
      Navigator.pushNamed(context, Routes.routeRegister);
    };
    super.initState();
  }

  @override
  void dispose() {
    registerRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Hero(
          tag: appBarLogoHeroTag,
          child: SvgPicture.asset("assets/telepass_logo.svg", height: 40),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: 32,
                horizontal: MediaQuery.sizeOf(context).width / 3,
              ),
              children: [
                const Text(
                  "Inserisci le tue credenziali\nper accedere al tuo account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Separator(32),
                if (errorText != null) ...[
                  Text(errorText!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                ],
                OutlinedTextField(
                  labelText: "Email",
                  initialText: email,
                  onEditing: (text) {
                    setState(() {
                      email = text;
                    });
                  },
                ),
                const Separator(16),
                OutlinedTextField(
                  labelText: "Pasword",
                  initialText: password,
                  obscureText: true,
                  onEditing: (text) {
                    setState(() {
                      password = text;
                    });
                  },
                ),
                const Separator(16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Password dimenticata?",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const Separator(24),
                AcceptConditions(
                  value: conditionsAccepted,
                  onChanged: (newValue) {
                    setState(() {
                      conditionsAccepted = newValue;
                    });
                  },
                ),
                const Separator(32),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: FilledButton(
                      onPressed:
                          isLoginDisabled
                              ? null
                              : () async {
                                errorText = await context
                                    .read<AuthHandler>()
                                    .login(email, password);
                                if (errorText != null && context.mounted) {
                                  setState(() {});
                                }
                              },
                      child: const Text("Accedi"),
                    ),
                  ),
                ),
                const Separator(32),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: "Non hai un account? "),
                        TextSpan(
                          text: "Registrati",
                          style: const TextStyle(color: primaryColor),
                          recognizer: registerRecognizer,
                        ),
                      ],
                    ),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}
