import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/personal_recipes/data/models/recipe_display_data.dart';
import 'package:squillo/features/personal_recipes/presentation/widgets/recipe_card.dart';

/// Grid widget for displaying recipe cards.
///
/// Shows recipes in a 2-column grid or an empty state message.
/// This is a helper class with static methods to build sliver widgets.
class RecipeGrid {
  // Private constructor to prevent instantiation
  RecipeGrid._();

  /// Builds a sliver grid of recipe cards or empty state.
  ///
  /// Returns appropriate sliver widget based on whether recipes list is empty.
  static Widget buildSliver({
    required List<RecipeDisplayData> recipes,
    String searchQuery = '',
  }) {
    if (recipes.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            searchQuery.isEmpty
                ? 'No recipes yet!\nTap import to add your first recipe.'
                : 'No recipes found for "$searchQuery"',
            textAlign: TextAlign.center,
            style: DesignConstants.h3.copyWith(
              color: DesignConstants.textHalf,
            ),
          ),
        ),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 32,
        crossAxisSpacing: 24,
        childAspectRatio: 0.9,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final recipe = recipes[index];
          return RecipeCard(recipe: recipe);
        },
        childCount: recipes.length,
      ),
    );
  }
}
