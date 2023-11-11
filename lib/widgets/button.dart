import 'package:flutter/material.dart';
import 'dart:math' as math;

class TapButton extends StatelessWidget {
  const TapButton(
      {super.key,
      required this.title,
      required this.oneTap,
      required this.doubleTap});

  final String title;
  final Function(TapDownDetails) oneTap;
  final Function(TapDownDetails) doubleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: doubleTap,
      onTapDown: oneTap,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(48),
        ),
        onPressed: () {},
        child: Transform.rotate(
          angle: -math.pi / 2,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
