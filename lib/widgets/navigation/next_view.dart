import 'package:flutter/material.dart';
import '../../pages/page2.dart';
class NextView extends StatelessWidget {
  const NextView({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()), 
        NextButton(),
      ],
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Page2()),
        );
      },
      child: const Text('Next'),
    );
  }
}