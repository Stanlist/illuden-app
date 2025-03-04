import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String text;
  final Widget destination;

  const NavigationButton({
    super.key,
    required this.text,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return destination; // go to destination
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Return the child directly without any animation
              return child;
            },
          ),
      );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,  
        foregroundColor: Theme.of(context).colorScheme.onPrimary,   
        textStyle: TextStyle(fontSize: 14.0),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        minimumSize: Size(90, 40),
      ),
      child: Text(text),
    );
  }
}
