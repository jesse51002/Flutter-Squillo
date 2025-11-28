import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// Search bar widget for filtering recipes.
///
/// Displays a centered text field for searching recipes.
class RecipesSearchBar extends StatelessWidget {
  /// Callback when the search query changes
  final ValueChanged<String> onSearchChanged;

  const RecipesSearchBar({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        onChanged: onSearchChanged,
        style: const TextStyle(color: DesignConstants.text),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'search bar',
          hintStyle: TextStyle(
            color: DesignConstants.textHalf,
            height: 1.0,
          ),
          filled: false,
          fillColor: DesignConstants.background,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              DesignConstants.buttonRadius,
            ),
            borderSide: const BorderSide(
              color: DesignConstants.buttonStroke,
              width: DesignConstants.buttonBorderSize,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              DesignConstants.buttonRadius,
            ),
            borderSide: const BorderSide(
              color: DesignConstants.buttonStroke,
              width: DesignConstants.buttonBorderSize,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              DesignConstants.buttonRadius,
            ),
            borderSide: const BorderSide(
              color: DesignConstants.primary,
              width: DesignConstants.buttonBorderSize,
            ),
          ),
        ),
      ),
    );
  }
}
