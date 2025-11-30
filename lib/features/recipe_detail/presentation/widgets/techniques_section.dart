import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_state.dart';
import 'package:squillo/features/recipe_detail/presentation/widgets/technique_card.dart';

/// Techniques section with horizontal scrolling cards.
class TechniquesSection extends StatelessWidget {
  final RecipeDetailLoaded state;

  const TechniquesSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const SizedBox(height: 16),
        _buildTechniquesList(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/icons/chef_hat.png", width: 36, height: 36),
        const SizedBox(width: 8),
        Text('techniques present', style: DesignConstants.h2),
      ],
    );
  }

  Widget _buildTechniquesList() {
    if (state.simplifiedTechniques.isEmpty) {
      return Text(
        'No techniques listed',
        style: DesignConstants.p.copyWith(color: DesignConstants.textHalf),
      );
    }

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.simplifiedTechniques.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index < state.simplifiedTechniques.length - 1 ? 16 : 0,
            ),
            child: TechniqueCard(technique: state.simplifiedTechniques[index]),
          );
        },
      ),
    );
  }
}
