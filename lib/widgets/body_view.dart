
import 'package:flutter/material.dart';

class BodyView extends StatelessWidget {
  final List<Widget> children;

  const BodyView({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Flexible(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: PageWidgets(children: children),
        ),
      ),
    );
  }
}

class PageWidgets extends StatelessWidget {
  final List<Widget> children;

  const PageWidgets({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
