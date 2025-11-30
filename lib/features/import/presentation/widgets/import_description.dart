import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// Description text widget explaining how to import recipes.
class ImportDescription extends StatelessWidget {
  const ImportDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Importing a recipe is easy. Simply paste the link from any social media / website.',
      style: DesignConstants.p,
      textAlign: TextAlign.center,
    );
  }
}
