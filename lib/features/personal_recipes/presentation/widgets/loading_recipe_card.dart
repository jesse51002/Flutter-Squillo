import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/personal_recipes/data/models/loading_recipe.dart';

/// A card widget that displays the status of a recipe being imported.
///
/// Shows the source site, current status, and provides visual feedback
/// for different loading states (loading, processing, error, etc.).
class LoadingRecipeCard extends StatelessWidget {
  final LoadingRecipe loadingRecipe;

  /// Error color for failed imports (red)
  static const Color _errorColor = Color(0xFFE63946);

  const LoadingRecipeCard({required this.loadingRecipe, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: DesignConstants.screenHorizontalPadding,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: _getBackgroundColor()),
      child: Row(
        children: [
          _buildStatusIcon(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Importing from ${loadingRecipe.baseSite}',
                  style: const TextStyle(
                    color: DesignConstants.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  loadingRecipe.statusDisplayText,
                  style: TextStyle(
                    color: DesignConstants.text.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (loadingRecipe.status != LoadingStatus.error)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  DesignConstants.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Returns the background color based on the loading status.
  Color _getBackgroundColor() {
    switch (loadingRecipe.status) {
      case LoadingStatus.error:
        return _errorColor.withValues(alpha: 0.1);
      default:
        return DesignConstants.background;
    }
  }

  /// Builds the status icon based on the loading status.
  Widget _buildStatusIcon() {
    switch (loadingRecipe.status) {
      case LoadingStatus.error:
        return const Icon(Icons.error_outline, color: _errorColor, size: 24);
      case LoadingStatus.completed:
        return const Icon(
          Icons.check_circle_outline,
          color: DesignConstants.primary,
          size: 24,
        );
      default:
        return const Icon(
          Icons.cloud_download_outlined,
          color: DesignConstants.primary,
          size: 24,
        );
    }
  }
}
