import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:squillo/core/constants/app_theme.dart';
import 'package:squillo/core/network/api_client.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_bloc.dart';
import 'package:squillo/features/personal_recipes/data/datasources/recipes_remote_datasource.dart';
import 'package:squillo/features/personal_recipes/data/repositories/recipes_repository.dart';
import 'package:squillo/features/personal_recipes/presentation/screens/personal_recipes_screen.dart';

// Service locator instance
final getIt = GetIt.instance;

void main() {
  // Setup dependency injection
  setupDependencies();

  runApp(const MainApp());
}

/// Setup dependency injection with GetIt.
void setupDependencies() {
  // Core - API Client
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Data sources
  getIt.registerLazySingleton<RecipesRemoteDataSource>(
    () => RecipesRemoteDataSourceImpl(dio: getIt<ApiClient>().dio),
  );

  // Repositories
  getIt.registerLazySingleton<RecipesRepository>(
    () => RecipesRepository(remoteDataSource: getIt<RecipesRemoteDataSource>()),
  );

  // Blocs
  getIt.registerFactory<PersonalRecipesBloc>(
    () => PersonalRecipesBloc(repository: getIt<RecipesRepository>()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squillo',
      theme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (context) => getIt<PersonalRecipesBloc>(),
        child: const PersonalRecipesScreen(),
      ),
    );
  }
}
