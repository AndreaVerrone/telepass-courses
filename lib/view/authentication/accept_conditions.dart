import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AcceptConditions extends StatefulWidget {
  final bool value;
  final void Function(bool) onChanged;
  const AcceptConditions({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<AcceptConditions> createState() => _AcceptConditionsState();
}

class _AcceptConditionsState extends State<AcceptConditions> {
  final tapRecognizer = TapGestureRecognizer();
  @override
  void initState() {
    tapRecognizer.onTap = () {
      launchUrl(Uri.parse("https://google.com"));
    };

    super.initState();
  }

  @override
  void dispose() {
    tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.value,
          activeColor: primaryColor,
          splashRadius: 0,
          side: const BorderSide(color: primaryColor, width: 2),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(4),
          ),
          onChanged: (value) => widget.onChanged(value ?? false),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: "Ho preso visione del "),
                TextSpan(
                  text: "Foglio Informativo",
                  style: const TextStyle(color: primaryColor),
                  recognizer: tapRecognizer,
                ),
                const TextSpan(text: ", "),
                TextSpan(
                  text: "Documento di Sintesi",
                  style: const TextStyle(color: primaryColor),
                  recognizer: tapRecognizer,
                ),
                const TextSpan(text: " e "),
                TextSpan(
                  text: "Norme e Condizioni",
                  style: const TextStyle(color: primaryColor),
                  recognizer: tapRecognizer,
                ),
                const TextSpan(text: ", nonchè dell'"),
                TextSpan(
                  text: "Informativa della Privacy",
                  style: const TextStyle(color: primaryColor),
                  recognizer: tapRecognizer,
                ),
              ],
            ),
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
