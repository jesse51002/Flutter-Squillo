import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/import/bloc/import_bloc.dart';
import 'package:squillo/features/import/presentation/screens/import_screen.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_bloc.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_event.dart';

/// Card widget for importing new recipes.
///
/// Displays a card with mascot illustration and import button.
/// Handles navigation to import screen and refreshes recipes on return.
class ImportCard extends StatelessWidget {
  const ImportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: DesignConstants.primarySubtle,
        borderRadius: BorderRadius.circular(DesignConstants.cardRadius),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left side: Text and button
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'import any recipes',
                    style: DesignConstants.h2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'learn with any recipes found on social media or web',
                    style: DesignConstants.p.copyWith(
                      color: DesignConstants.textHalf,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: ElevatedButton(
                        onPressed: () async {
                          final bloc = context.read<PersonalRecipesBloc>();
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    GetIt.instance<ImportBloc>(),
                                child: const ImportScreen(),
                              ),
                            ),
                          );

                          // Refresh recipes when returning from import screen
                          if (context.mounted) {
                            bloc.add(const RefreshRecipesRequested());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DesignConstants.primary,
                          foregroundColor: DesignConstants.text,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10000),
                          ),
                        ),
                        child: Text('import', style: DesignConstants.h3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Right side: Mascot image with fixed width
            SizedBox(
              width: 120,
              child: Image.asset(
                'assets/squillo_mascot/squillo_book_reading.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
