import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squillo/core/constants/design_constants.dart';
import 'package:squillo/features/import/bloc/import_bloc.dart';
import 'package:squillo/features/import/bloc/import_event.dart';
import 'package:squillo/features/import/bloc/import_state.dart';
import 'package:squillo/features/import/presentation/widgets/import_button.dart';
import 'package:squillo/features/import/presentation/widgets/import_description.dart';
import 'package:squillo/features/import/presentation/widgets/import_header.dart';
import 'package:squillo/features/import/presentation/widgets/import_mascot.dart';
import 'package:squillo/features/import/presentation/widgets/import_url_input.dart';

/// Screen for importing recipes from URLs.
///
/// Displays a mascot illustration, input field, and import button.
class ImportScreen extends StatefulWidget {
  const ImportScreen({super.key});

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignConstants.background,
      body: SafeArea(
        child: BlocConsumer<ImportBloc, ImportState>(
          listener: _handleStateChanges,
          builder: (context, state) {
            final isLoading = state is ImportLoading;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignConstants.screenHorizontalPadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  const ImportHeader(),
                  const SizedBox(height: 8),
                  const ImportMascot(),
                  const SizedBox(height: 8),
                  const ImportDescription(),
                  const SizedBox(height: 16),
                  ImportUrlInput(
                    controller: _urlController,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 8),
                  ImportButton(
                    isLoading: isLoading,
                    onPressed: _handleImportPressed,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, ImportState state) {
    if (state is ImportSuccess) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recipe import started! Check your recipes.'),
          backgroundColor: DesignConstants.primary,
        ),
      );
    } else if (state is ImportNoRecipeFound) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No recipe found at this URL'),
          backgroundColor: Color(0xFFE63946),
        ),
      );
      context.read<ImportBloc>().add(const ImportResetRequested());
    } else if (state is ImportError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: const Color(0xFFE63946),
        ),
      );
      context.read<ImportBloc>().add(const ImportResetRequested());
    }
  }

  void _handleImportPressed() {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a URL'),
        ),
      );
      return;
    }
    context.read<ImportBloc>().add(ImportRecipeRequested(url));
  }
}
