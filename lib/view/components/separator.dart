import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double dimension;
  const Separator(this.dimension, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
    );
  }
}
