import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_bloc.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_event.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_state.dart';
import 'package:squillo/features/personal_recipes/presentation/widgets/difficulty_indicator.dart';
import 'package:squillo/features/personal_recipes/presentation/widgets/import_card.dart';
import 'package:squillo/features/personal_recipes/presentation/widgets/recipe_grid.dart';
import 'package:squillo/features/personal_recipes/presentation/widgets/recipes_search_bar.dart';
import 'package:squillo/shared/widgets/loading_indicator.dart';

/// Main screen for displaying personal recipes.
///
/// Shows a search bar, import card, and grid of recipe cards.
class PersonalRecipesScreen extends StatelessWidget {
  const PersonalRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignConstants.background,
      body: SafeArea(
        child: BlocBuilder<PersonalRecipesBloc, PersonalRecipesState>(
          builder: (context, state) {
            return switch (state) {
              PersonalRecipesInitial() => _buildInitial(context),
              PersonalRecipesLoading() => const LoadingIndicator(),
              PersonalRecipesLoaded() => _buildLoaded(context, state),
              PersonalRecipesError() => _buildError(context, state),
            };
          },
        ),
      ),
    );
  }

  /// Builds the initial state - triggers loading.
  Widget _buildInitial(BuildContext context) {
    // Trigger loading on first build
    context.read<PersonalRecipesBloc>().add(const LoadRecipesRequested());
    return const LoadingIndicator();
  }

  /// Builds the loaded state with recipes.
  Widget _buildLoaded(BuildContext context, PersonalRecipesLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        slivers: [
          // App bar - centered
          SliverToBoxAdapter(
            child: Center(
              child: Text('your recipes', style: DesignConstants.h1),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),

          // Search bar - centered
          SliverToBoxAdapter(
            child: RecipesSearchBar(
              onSearchChanged: (query) {
                context.read<PersonalRecipesBloc>().add(
                  SearchRecipesRequested(query),
                );
              },
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),

          // Import card
          const SliverToBoxAdapter(child: ImportCard()),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),

          // Difficulty legend section with header
          SliverToBoxAdapter(child: DifficultyIndicator.buildLegendSection()),

          const SliverToBoxAdapter(child: SizedBox(height: 48)),

          // Recipe grid
          RecipeGrid.buildSliver(
            recipes: state.filteredRecipes,
            searchQuery: state.searchQuery,
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  /// Builds a difficulty legend item.
  /// Builds the error state.
  Widget _buildError(BuildContext context, PersonalRecipesError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
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
              onPressed: () {
                context.read<PersonalRecipesBloc>().add(
                  const LoadRecipesRequested(),
                );
              },
              child: Text('Retry', style: DesignConstants.h3),
            ),
          ],
        ),
      ),
    );
  }
}
