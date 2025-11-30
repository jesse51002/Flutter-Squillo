import 'package:flutter/material.dart';

/// Mascot image widget for the import screen.
class ImportMascot extends StatelessWidget {
  const ImportMascot({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/squillo_mascot/squillo_phone_holding.png',
      width: double.infinity,
      height: 200,
      fit: BoxFit.contain,
    );
  }
}
