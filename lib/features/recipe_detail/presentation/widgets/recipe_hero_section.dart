import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_state.dart';

/// Hero image section with back button and floating title card.
class RecipeHeroSection extends StatelessWidget {
  final RecipeDetailLoaded state;

  const RecipeHeroSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Hero image (no gradient)
        _buildHeroImage(),

        // Back button
        _buildBackButton(context),

        // Floating title card
        _buildFloatingTitleCard(),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Image.network(
      state.recipe.thumbnailUrl ?? '',
      height: 300,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 300,
          color: DesignConstants.primarySubtle,
          child: const Icon(
            Icons.restaurant,
            size: 64,
            color: DesignConstants.primary,
          ),
        );
      },
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: DesignConstants.text),
        onPressed: () => Navigator.of(context).pop(),
        style: IconButton.styleFrom(
          backgroundColor: DesignConstants.background.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  Widget _buildFloatingTitleCard() {
    return Positioned(
      top: 300,
      left: DesignConstants.screenHorizontalPadding,
      right: DesignConstants.screenHorizontalPadding,
      child: FractionalTranslation(
        translation: const Offset(0, -0.5),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: DesignConstants.background,
            borderRadius: BorderRadius.circular(DesignConstants.buttonRadius),
            border: Border.all(
              color: DesignConstants.buttonStroke,
              width: DesignConstants.buttonBorderSize,
            ),
          ),
          child: Text(
            state.recipe.recipeName.toLowerCase(),
            style: DesignConstants.h2,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
