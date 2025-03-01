import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/routes.dart';
import 'package:telepass_courses/services/auth_handler.dart';
import 'package:telepass_courses/view/authentication/accept_conditions.dart';
import 'package:telepass_courses/view/components/outlined_text_field.dart';
import 'package:telepass_courses/view/components/footer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String password = '';
  String repeatedPassword = '';
  bool conditionsAccepted = false;

  final loginRecognizer = TapGestureRecognizer();

  String? errorText;

  bool get isLoginDisabled =>
      email.isEmpty ||
      password.isEmpty ||
      repeatedPassword.isEmpty ||
      password != repeatedPassword ||
      !conditionsAccepted;

  @override
  void initState() {
    loginRecognizer.onTap = () {
      Navigator.pushReplacementNamed(context, Routes.routeLogin);
    };
    super.initState();
  }

  @override
  void dispose() {
    loginRecognizer.dispose();
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
                  "Inserisci le tue credenziali\nper creare il tuo account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                if (errorText != null)
                  Text(errorText!, style: const TextStyle(color: Colors.red)),
                OutlinedTextField(
                  labelText: "Email",
                  initialText: email,
                  onEditing: (text) {
                    setState(() {
                      email = text;
                    });
                  },
                ),
                const SizedBox(height: 16),
                OutlinedTextField(
                  labelText: "Pasword",
                  obscureText: true,
                  initialText: password,
                  onEditing: (text) {
                    setState(() {
                      password = text;
                    });
                  },
                ),
                const SizedBox(height: 16),
                OutlinedTextField(
                  labelText: "Ripeti la Pasword",
                  obscureText: true,
                  initialText: repeatedPassword,
                  onEditing: (text) {
                    setState(() {
                      repeatedPassword = text;
                    });
                  },
                ),
                const SizedBox(height: 24),
                AcceptConditions(
                  value: conditionsAccepted,
                  onChanged: (newValue) {
                    setState(() {
                      conditionsAccepted = newValue;
                    });
                  },
                ),
                const SizedBox(height: 32),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateColor.fromMap({
                          WidgetState.disabled: Colors.grey[700]!,
                          WidgetState.hovered: primaryColorDark,
                          WidgetState.any: primaryColor,
                        }),
                      ),
                      onPressed:
                          isLoginDisabled
                              ? null
                              : () async {
                                errorText = await AuthHandler.register(
                                  email,
                                  password,
                                  repeatedPassword,
                                );
                                if (errorText == null && context.mounted) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.routeHome,
                                  );
                                } else {
                                  setState(() {});
                                }
                              },
                      child: const Text(
                        "Registrati",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: "Hai già un account? "),
                        TextSpan(
                          text: "Accedi",
                          style: const TextStyle(color: primaryColor),
                          recognizer: loginRecognizer,
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
