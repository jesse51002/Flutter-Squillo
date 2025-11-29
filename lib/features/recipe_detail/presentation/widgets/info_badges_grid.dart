import 'package:flutter/material.dart';
import 'package:squillo/core/constants/difficulty.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_state.dart';
import 'package:squillo/features/recipe_detail/presentation/widgets/info_badge.dart';

/// 2x2 grid of info badges displaying recipe metadata.
class InfoBadgesGrid extends StatelessWidget {
  final RecipeDetailLoaded state;

  const InfoBadgesGrid({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final difficulty = Difficulty.fromValue(state.recipe.difficulty);

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: (100 / 32),
      children: [
        InfoBadge(
          imgPth: 'assets/icons/single_star_icon.png',
          label: 'difficulty',
          value: difficulty.displayName,
        ),
        InfoBadge(
          imgPth: 'assets/icons/whisk_icon.png',
          label: 'active time',
          value: state.recipe.activeTime > 0
              ? '${state.recipe.activeTime.toInt()} min'
              : 'N/A',
        ),
        InfoBadge(
          imgPth: 'assets/icons/chef_hat.png',
          label: 'skills present',
          value: '${state.techniqueCount} techniques',
        ),
        InfoBadge(
          imgPth: 'assets/icons/clock_icon.png',
          label: 'total time',
          value: state.recipe.totalTime > 0
              ? '${state.recipe.totalTime.toInt()} min'
              : 'N/A',
        ),
      ],
    );
  }
}
