import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// Header widget displaying the import screen title.
class ImportHeader extends StatelessWidget {
  const ImportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'import any recipe',
      style: DesignConstants.h1,
      textAlign: TextAlign.center,
    );
  }
}
