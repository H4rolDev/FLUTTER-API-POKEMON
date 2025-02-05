import 'package:flutter/material.dart';

class PokemonTheme {
  static Color getColorFromId(String id) {
    int colorCode = int.tryParse(id) ?? 1;
    return Colors.primaries[colorCode % Colors.primaries.length];
  }

  static LinearGradient getGradientFromId(String id) {
    Color baseColor = getColorFromId(id);
    return LinearGradient(
      colors: [baseColor, baseColor.withOpacity(0.7)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}