import 'dart:math';

import 'package:flutter/material.dart';

class AngleSlider extends StatelessWidget {
  const AngleSlider(
      {super.key,
      required this.title,
      required this.color,
      required this.angle,
      required this.callback,
      this.minMaxAbsolute = 2 * pi});

  final String title;
  final Color color;
  final double angle;
  final Function(double value) callback;
  final double minMaxAbsolute;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(color: color)),
            Slider(
              activeColor: color,
              value: angle,
              min: -minMaxAbsolute,
              max: minMaxAbsolute,
              onChanged: callback,
            ),
          ],
        ),
        Text(
            "Radians: ${angle.toStringAsFixed(2)} ≙ ${((angle / pi) * 180).toStringAsFixed(1)}°",
            style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 20)
      ],
    );
  }
}
