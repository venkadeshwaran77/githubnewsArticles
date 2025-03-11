import 'package:flutter/material.dart';

class VerticleSpacing extends StatelessWidget {
  const VerticleSpacing(this.height);
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      );
  }
}
