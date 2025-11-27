import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// Search bar widget for filtering recipes.
///
/// Displays a text field with a search icon that disappears when typing starts.
/// The icon is overlaid and doesn't affect text centering.
class RecipesSearchBar extends StatefulWidget {
  /// Callback when the search query changes
  final ValueChanged<String> onSearchChanged;

  const RecipesSearchBar({
    super.key,
    required this.onSearchChanged,
  });

  @override
  State<RecipesSearchBar> createState() => _RecipesSearchBarState();
}

class _RecipesSearchBarState extends State<RecipesSearchBar> {
  bool _isTyping = false;

  void _handleTextChanged(String value) {
    setState(() {
      _isTyping = value.isNotEmpty;
    });
    widget.onSearchChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(  
      height: 40,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextField(
            onChanged: _handleTextChanged,
            style: const TextStyle(
              color: DesignConstants.text,
            ),
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: 'search bar',
              hintStyle: TextStyle(
                color: DesignConstants.textHalf,
                height: 1.0,
              ),
              filled: false,
              fillColor: DesignConstants.background,
              suffixIcon: const SizedBox.shrink(),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(DesignConstants.buttonRadius),
                borderSide: const BorderSide(
                  color: DesignConstants.buttonStroke,
                  width: DesignConstants.buttonBorderSize,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(DesignConstants.buttonRadius),
                borderSide: const BorderSide(
                  color: DesignConstants.buttonStroke,
                  width: DesignConstants.buttonBorderSize,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(DesignConstants.buttonRadius),
                borderSide: const BorderSide(
                  color: DesignConstants.primary,
                  width: DesignConstants.buttonBorderSize,
                ),
              ),
            ),
          ),
          if (!_isTyping)
            Positioned(
              left: 24,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'assets/icons/orange_magnifying_glass.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ),
        ],
      )
    );
  }
}
