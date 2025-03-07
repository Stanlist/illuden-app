import 'package:flutter/material.dart';

class ButtonStyles {
  static ButtonStyle selectButton(BuildContext context, {required bool isEnabled}) {
    return TextButton.styleFrom(
      foregroundColor: isEnabled
          ? Theme.of(context).colorScheme.onPrimary
          : Theme.of(context).colorScheme.secondaryFixedDim,
      splashFactory: NoSplash.splashFactory,
      backgroundColor: isEnabled
          ? Theme.of(context).colorScheme.primary.withOpacity(0.9)
          : Theme.of(context).colorScheme.surfaceDim,
      minimumSize: const Size(105.0, 36.0),
      textStyle: const TextStyle(fontSize: 14),
    );
  }
}