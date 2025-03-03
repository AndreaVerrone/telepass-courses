import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/services/auth_handler.dart';
import 'package:telepass_courses/view/authentication/accept_conditions.dart';
import 'package:telepass_courses/view/components/footer.dart';
import 'package:telepass_courses/view/components/outlined_text_field.dart';
import 'package:telepass_courses/view/components/separator.dart';

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
      Navigator.pop(context);
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
                const Separator(32),
                if (errorText != null) ...[
                  Text(errorText!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(
                    height: 16,
                  ),
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
                  obscureText: true,
                  initialText: password,
                  onEditing: (text) {
                    setState(() {
                      password = text;
                    });
                  },
                ),
                const Separator(16),
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
                      onPressed: isLoginDisabled
                          ? null
                          : () async {
                              errorText =
                                  await context.read<AuthHandler>().register(
                                        email,
                                        password,
                                        repeatedPassword,
                                      );
                              if (errorText != null && context.mounted) {
                                setState(() {});
                              }
                            },
                      child: const Text("Registrati"),
                    ),
                  ),
                ),
                const Separator(32),
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
