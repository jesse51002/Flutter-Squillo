import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/core/constants/difficulty.dart';
import 'package:squillo/features/personal_recipes/data/models/recipe_display_data.dart';

/// Card widget for displaying a recipe in a grid.
///
/// Shows recipe thumbnail, name, difficulty indicator, and technique count.
class RecipeCard extends StatelessWidget {
  /// The recipe data to display
  final RecipeDisplayData recipe;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  const RecipeCard({super.key, required this.recipe, this.onTap});

  /// Gets the difficulty enum from the recipe.
  Difficulty get _difficulty => Difficulty.fromValue(recipe.difficulty);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Viewing ${recipe.recipeName}')),
            );
          },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Recipe card with image - wrapped in Stack to allow overflow
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Main card container
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      DesignConstants.cardRadius,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: DesignConstants.cardBorderSize,
                    ),
                    image: recipe.thumbnailUrl != null
                        ? DecorationImage(
                            image: NetworkImage(recipe.thumbnailUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: recipe.thumbnailUrl == null
                        ? DesignConstants.buttonStroke
                        : null,
                  ),
                  child: recipe.thumbnailUrl == null
                      ? const Center(
                          child: Icon(
                            Icons.restaurant,
                            size: 48,
                            color: DesignConstants.text,
                          ),
                        )
                      : null,
                ),

                // Top center: Technique count badge in pill cutout
                Positioned(
                  top: -20 + DesignConstants.cardBorderSize,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: _difficulty.color,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(1000),
                        ),
                        border: Border.all(
                          width: DesignConstants.cardBorderSize,
                          color: Colors.white,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            recipe.techniqueIds.length.toString(),
                            style: DesignConstants.h3.copyWith(
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Image.asset(
                            'assets/icons/chef_hat.png',
                            width: 25,
                            height: 25,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Recipe name below the card
          const SizedBox(height: 8),
          SizedBox(
            height: 30,
            child: Text(
              recipe.recipeName,
              style: DesignConstants.p,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
