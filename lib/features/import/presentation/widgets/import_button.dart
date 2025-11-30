import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// Import button widget that triggers recipe import.
class ImportButton extends StatelessWidget {
  /// Whether the button is in loading state
  final bool isLoading;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  const ImportButton({
    super.key,
    required this.isLoading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignConstants.primary,
          foregroundColor: DesignConstants.text,
          disabledBackgroundColor:
              DesignConstants.primary.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              DesignConstants.buttonRadius,
            ),
          ),
        ),
        child: isLoading ? _buildLoadingIndicator() : _buildButtonText(),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          DesignConstants.text,
        ),
      ),
    );
  }

  Widget _buildButtonText() {
    return Text(
      'import',
      style: DesignConstants.h3.copyWith(fontWeight: FontWeight.w700)
    );
  }
}
