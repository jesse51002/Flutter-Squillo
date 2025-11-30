import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_bloc.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_event.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_state.dart';
import 'package:squillo/features/personal_recipes/presentation/widgets/difficulty_indicator.dart';
import 'package:squillo/features/personal_recipes/presentation/widgets/import_card.dart';
import 'package:squillo/features/personal_recipes/presentation/widgets/loading_recipe_card.dart';
import 'package:squillo/features/personal_recipes/presentation/widgets/recipe_grid.dart';
import 'package:squillo/features/personal_recipes/presentation/widgets/recipes_search_bar.dart';
import 'package:squillo/shared/widgets/loading_indicator.dart';

/// Main screen for displaying personal recipes.
///
/// Shows a search bar, import card, and grid of recipe cards.
class PersonalRecipesScreen extends StatefulWidget {
  const PersonalRecipesScreen({super.key});

  @override
  State<PersonalRecipesScreen> createState() => _PersonalRecipesScreenState();
}

class _PersonalRecipesScreenState extends State<PersonalRecipesScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger loading when the screen initializes
    context.read<PersonalRecipesBloc>().add(const LoadRecipesRequested());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignConstants.background,
      body: SafeArea(
        child: BlocBuilder<PersonalRecipesBloc, PersonalRecipesState>(
          builder: (context, state) {
            return switch (state) {
              PersonalRecipesInitial() ||
              PersonalRecipesLoading() => const LoadingIndicator(),
              PersonalRecipesLoaded() => _buildLoaded(context, state),
              PersonalRecipesError() => _buildError(context, state),
            };
          },
        ),
      ),
    );
  }

  /// Builds the loaded state with recipes.
  Widget _buildLoaded(BuildContext context, PersonalRecipesLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignConstants.screenHorizontalPadding,
      ),
      child: CustomScrollView(
        slivers: [
          // App bar - centered
          SliverToBoxAdapter(
            child: Center(
              child: Text(
                'your recipes',
                style: DesignConstants.h1.copyWith(height: 1),
              ),
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

          // Import card - only show when not searching
          if (state.searchQuery.isEmpty) ...[
            const SliverToBoxAdapter(
              child: ImportCard(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: state.hasLoadingRecipes ? 8 : 32),
            ),
          ],

          // Loading recipes section
          if (state.hasLoadingRecipes) ...[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return LoadingRecipeCard(
                  loadingRecipe: state.loadingRecipes[index],
                );
              }, childCount: state.loadingRecipes.length),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
          ],

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

  /// Builds the error state.
  Widget _buildError(BuildContext context, PersonalRecipesError state) {
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
