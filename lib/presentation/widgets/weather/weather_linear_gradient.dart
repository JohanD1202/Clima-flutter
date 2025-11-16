import 'package:flutter/material.dart';


class LinearGradientSeason extends StatelessWidget {
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final Widget? child;

  const LinearGradientSeason({
    super.key,
    required this.colors,
    required this.begin,
    required this.end,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end
        ),
      ),
      child: child
    );
  }
}