import 'package:flutter/material.dart';

class PixelSlider extends StatelessWidget {
  const PixelSlider(
      {super.key,
      required this.title,
      required this.color,
      required this.offset,
      required this.callback,
      this.minMaxAbsolute = 250});

  final String title;
  final Color color;
  final double offset;
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
              value: offset,
              min: -minMaxAbsolute,
              max: minMaxAbsolute,
              onChanged: callback,
            ),
          ],
        ),
        Text("offset in pixel: ${offset.toStringAsFixed(0)}",
            style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 10)
      ],
    );
  }
}
