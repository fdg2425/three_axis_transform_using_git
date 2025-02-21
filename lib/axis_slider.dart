import 'dart:math';

import 'package:flutter/material.dart';

class AxisSlider extends StatelessWidget {
  const AxisSlider({
    super.key,
    required this.title,
    required this.color,
    required this.angle,
    required this.callback,
  });

  final String title;
  final Color color;
  final double angle;
  final Function(double value) callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(color: color)),
        Slider(
          activeColor: color,
          value: angle,
          min: -2 * pi,
          max: 2 * pi,
          onChanged: callback,
        ),
      ],
    );
  }
}
