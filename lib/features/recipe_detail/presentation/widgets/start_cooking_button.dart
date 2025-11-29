import 'package:flutter/material.dart';
import 'package:squillo/core/constants/design_constants.dart';

/// Start cooking button with XP badge.
class StartCookingButton extends StatelessWidget {
  const StartCookingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cooking mode not implemented yet')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignConstants.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignConstants.buttonRadius),
          ),
        ),
        child: Text('start cooking (+200 xp)', style: DesignConstants.h2),
      ),
    );
  }
}
