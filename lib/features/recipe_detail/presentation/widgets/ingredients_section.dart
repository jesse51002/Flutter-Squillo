import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_state.dart';
import 'package:squillo/features/recipe_detail/presentation/widgets/ingredient_checkbox_item.dart';

/// Ingredients section with header and checkbox list.
class IngredientsSection extends StatelessWidget {
  final RecipeDetailLoaded state;

  const IngredientsSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),

        const SizedBox(height: 16),
        _buildIngredientsList(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Image.asset(
          "assets/icons/ingredient_bunch_icon.png",
          width: 36,
          height: 36,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ingredients', style: DesignConstants.h2),
            const SizedBox(height: 4),
            Text(
              '${state.recipe.servings} servings',
              style: DesignConstants.p.copyWith(
                color: DesignConstants.textHalf,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIngredientsList() {
    if (state.ingredientsWithState.isEmpty) {
      return Text(
        'No ingredients listed',
        style: DesignConstants.p.copyWith(color: DesignConstants.textHalf),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        state.ingredientsWithState.length,
        (index) => IngredientCheckboxItem(
          ingredientState: state.ingredientsWithState[index],
          index: index,
        ),
      ),
    );
  }
}
