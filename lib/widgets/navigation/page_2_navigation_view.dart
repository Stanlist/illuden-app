import 'package:flutter/material.dart';
import '../../pages/page1.dart';

import 'package:illuden/widgets/navigation/navigation_button.dart';

class Page2NavigationView extends StatelessWidget {
  const Page2NavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()), 
        NavigationButton(
          text: 'Done',
          destination: Page1(),
        ),
      ],
    );
  }
}

