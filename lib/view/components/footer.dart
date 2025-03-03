import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/view/components/separator.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  static const _textStyle = TextStyle(
    fontSize: 11,
    color: Colors.grey,
    fontWeight: FontWeight.w300,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColorDark,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: Column(
        children: [
          SvgPicture.asset("assets/telepass_logo.svg", height: 20),
          const Separator(16),
          const Text(
            "Sede legale: via Laurentina, 449 - 00142 Roma (RM)",
            style: _textStyle,
          ),
          const Text(
            "P.IVA 09771701001 - Certificato ISO9001 e ISO27001",
            style: _textStyle,
          ),
        ],
      ),
    );
  }
}
