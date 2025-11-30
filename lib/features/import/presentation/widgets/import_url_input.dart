import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// URL input field widget for entering recipe URLs.
class ImportUrlInput extends StatelessWidget {
  /// Text editing controller for the URL input
  final TextEditingController controller;

  /// Whether the input field is enabled
  final bool enabled;

  const ImportUrlInput({
    super.key,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextField(
      controller: controller,
      enabled: enabled,

      decoration: InputDecoration(
        hintText: 'link',
        hintStyle: DesignConstants.h3.copyWith(
          color: DesignConstants.textHalf,
          height: 1
        ),
        isDense: true,
        filled: true,
        fillColor: DesignConstants.text.withValues(alpha: 0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            DesignConstants.buttonRadius,
          ),
          borderSide: BorderSide.none,
        ),

      ),
      style: DesignConstants.h3,
      textAlign: TextAlign.center,
    )
    );
  }
}
