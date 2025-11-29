import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/recipe_detail/data/models/extraction_recipe_step.dart';

/// A list item displaying a single recipe instruction step.
///
/// Shows a circular number badge followed by the instruction text and time estimate.
class InstructionStepItem extends StatelessWidget {
  /// The recipe step to display
  final ExtractionRecipeStep step;

  /// Creates an [InstructionStepItem].
  const InstructionStepItem({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'step ${step.stepNumber}',
            style: DesignConstants.p.copyWith(
              color: DesignConstants.text,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(width: 16),
          // Instruction text and time
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: step.instruction,
                  style: DesignConstants.p.copyWith(
                    color: DesignConstants.text,
                  ),
                ),
                if (step.estimatedTime > 0) ...[
                  TextSpan(
                    text: ' ( ~${step.estimatedTime.toInt()} min)',
                    style: DesignConstants.p.copyWith(
                      color: DesignConstants.textHalf,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
