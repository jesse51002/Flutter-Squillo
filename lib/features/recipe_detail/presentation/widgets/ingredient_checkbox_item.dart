import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_bloc.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_event.dart';
import 'package:squillo/features/recipe_detail/data/models/ingredient_with_state.dart';

/// A checkbox list item for a single ingredient.
///
/// Displays the ingredient with quantity/unit in bold and name in regular text.
/// Dispatches a ToggleIngredientChecked event when tapped.
class IngredientCheckboxItem extends StatelessWidget {
  /// The ingredient with its checkbox state
  final IngredientWithState ingredientState;

  /// The index of this ingredient in the list
  final int index;

  /// Creates an [IngredientCheckboxItem].
  const IngredientCheckboxItem({
    super.key,
    required this.ingredientState,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final ingredient = ingredientState.ingredient;
    final hasQuantityOrUnit =
        ingredient.quantity.isNotEmpty || ingredient.unit.isNotEmpty;
    final isSyncing = ingredientState.isSyncing;

    return GestureDetector(
      onTap: isSyncing
          ? null // Disable tap when syncing
          : () {
              context.read<RecipeDetailBloc>().add(
                ToggleIngredientChecked(index),
              );
            },
      child: Opacity(
        opacity: isSyncing ? 0.5 : 1.0, // Dim when syncing
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              // Circular checkbox (or loading indicator)
              SizedBox(
                width: 24,
                height: 24,
                child: isSyncing
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          DesignConstants.secondary,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ingredientState.isChecked
                                ? DesignConstants.secondary
                                : DesignConstants.buttonStroke,
                            width: 2,
                          ),
                          color: ingredientState.isChecked
                              ? DesignConstants.secondary
                              : Colors.transparent,
                        ),
                        child: ingredientState.isChecked
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: DesignConstants.background,
                              )
                            : null,
                      ),
              ),
              const SizedBox(width: 12),
              // Ingredient text
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      if (hasQuantityOrUnit)
                        TextSpan(
                          text: '${ingredient.quantity} ${ingredient.unit} ',
                          style: DesignConstants.p.copyWith(
                            fontWeight: FontWeight.bold,
                            color: DesignConstants.text,
                          ),
                        ),
                      TextSpan(
                        text: ingredient.name.toLowerCase(),
                        style: DesignConstants.p.copyWith(
                          color: DesignConstants.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
