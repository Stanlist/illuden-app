import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String text;
  final Widget destination;
  final bool isEnabled; // New bool to control the button's enabled state

  const NavigationButton({
    super.key,
    required this.text,
    required this.destination,
    this.isEnabled = true, // Default value is true (enabled)
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destination),
              );
            }
          : null, // If not enabled, button won't do anything
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled
            ? Theme.of(context).colorScheme.primary.withOpacity(0.9)
            : Theme.of(context).colorScheme.primary.withOpacity(0.3), // Dim the button when disabled
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        textStyle: TextStyle(fontSize: 14.0),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        minimumSize: Size(80, 36.0),
        side: BorderSide(
          color: isEnabled
              ? Theme.of(context).colorScheme.primary // Outline color when enabled
              : Theme.of(context).colorScheme.outline.withOpacity(0.2), // Dimmed outline when disabled
          width: 1.5, // You can adjust the outline width if needed
        ),
      ).merge(
        ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.primaryFixedDim, // Splash color
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
