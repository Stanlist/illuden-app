import 'package:flutter/material.dart';
import '../../pages/page2.dart';

import 'package:illuden/widgets/navigation/navigation_button.dart';

class Page1NavigationView extends StatelessWidget {
  const Page1NavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()), 
        NavigationButton(
          text: 'Next',
          destination: Page2(),
        ),
      ],
    );
  }
}

