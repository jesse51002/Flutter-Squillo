import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_state.dart';
import 'package:squillo/features/recipe_detail/presentation/widgets/instruction_step_item.dart';

/// Instructions section with numbered steps.
class InstructionsSection extends StatelessWidget {
  final RecipeDetailLoaded state;

  const InstructionsSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        _buildInstructionsList(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Image.asset("assets/icons/notepad_icon.png", width: 36, height: 36),
        const SizedBox(width: 12),
        Text('instructions', style: DesignConstants.h2),
      ],
    );
  }

  Widget _buildInstructionsList() {
    if (state.recipe.steps.isEmpty) {
      return Text(
        'No instructions available',
        style: DesignConstants.p.copyWith(color: DesignConstants.textHalf),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: state.recipe.steps
          .map((step) => InstructionStepItem(step: step))
          .toList(),
    );
  }
}
