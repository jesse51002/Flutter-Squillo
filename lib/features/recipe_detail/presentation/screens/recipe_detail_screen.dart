import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_bloc.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_event.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_state.dart';
import 'package:squillo/features/recipe_detail/presentation/widgets/info_badges_grid.dart';

import 'package:squillo/features/recipe_detail/presentation/widgets/ingredients_section.dart';
import 'package:squillo/features/recipe_detail/presentation/widgets/instructions_section.dart';
import 'package:squillo/features/recipe_detail/presentation/widgets/recipe_hero_section.dart';
import 'package:squillo/features/recipe_detail/presentation/widgets/start_cooking_button.dart';
import 'package:squillo/features/recipe_detail/presentation/widgets/techniques_section.dart';
import 'package:squillo/main.dart';
import 'package:squillo/shared/widgets/loading_indicator.dart';

/// Recipe detail screen showing complete recipe information.
///
/// Displays hero image, title, info badges, ingredients, techniques, and instructions.
class RecipeDetailScreen extends StatelessWidget {
  /// The ID of the recipe to display
  final String recipeId;

  /// Creates a [RecipeDetailScreen].
  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<RecipeDetailBloc>()..add(LoadRecipeDetailRequested(recipeId)),
      child: Scaffold(
        backgroundColor: DesignConstants.background,
        body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
          builder: (context, state) {
            return switch (state) {
              RecipeDetailInitial() ||
              RecipeDetailLoading() => const LoadingIndicator(),
              RecipeDetailLoaded() => _RecipeDetailContent(state: state),
              RecipeDetailError() => _ErrorView(state: state),
            };
          },
        ),
      ),
    );
  }
}

/// Main content widget for the loaded state.
class _RecipeDetailContent extends StatelessWidget {
  final RecipeDetailLoaded state;

  const _RecipeDetailContent({required this.state});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Hero image and floating title card
        SliverToBoxAdapter(child: RecipeHeroSection(state: state)),

        const SliverToBoxAdapter(child: SizedBox(height: 0)),

        // Info badges grid
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignConstants.screenHorizontalPadding,
            ),
            child: InfoBadgesGrid(state: state),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 0)),

        // Ingredients section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignConstants.screenHorizontalPadding,
            ),
            child: IngredientsSection(state: state),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // Techniques section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignConstants.screenHorizontalPadding,
            ),
            child: TechniquesSection(state: state),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 8)),

        SliverToBoxAdapter(
          child: Divider(
            color: DesignConstants.buttonStroke,
            thickness: DesignConstants.buttonBorderSize,
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // Start cooking button
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignConstants.screenHorizontalPadding,
            ),
            child: StartCookingButton(),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        SliverToBoxAdapter(
          child: Divider(
            color: DesignConstants.buttonStroke,
            thickness: DesignConstants.buttonBorderSize,
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),

        // Instructions section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignConstants.screenHorizontalPadding,
            ),
            child: InstructionsSection(state: state),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),

        // Bottom start cooking button
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignConstants.screenHorizontalPadding,
            ),
            child: StartCookingButton(),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 64)),
      ],
    );
  }
}

/// Error view with retry button.
class _ErrorView extends StatelessWidget {
  final RecipeDetailError state;

  const _ErrorView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DesignConstants.screenHorizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: DesignConstants.primary,
            ),
            const SizedBox(height: 16),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: DesignConstants.h3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Go Back', style: DesignConstants.h3),
            ),
          ],
        ),
      ),
    );
  }
}
