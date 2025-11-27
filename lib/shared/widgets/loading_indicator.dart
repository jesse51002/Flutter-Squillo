import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// A reusable loading indicator widget.
///
/// Displays a centered circular progress indicator with the primary brand color.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: DesignConstants.primary,
      ),
    );
  }
}
