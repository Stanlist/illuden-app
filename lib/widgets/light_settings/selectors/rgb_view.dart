import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/utils/lights/lights.dart';
import 'package:illuden/assets/constants.dart';
class RGBView extends StatelessWidget {
  const RGBView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - Constants.selectorHorizontalPadding,
            height: MediaQuery.of(context).size.width - Constants.selectorHorizontalPadding + Constants.selectorVerticalPadding,
            child: RGBSelector(),
          )
        );
      },
    );
  }
}

class RGBSelector extends StatelessWidget {
  const RGBSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'WORK IN PROGRESS',
      ),
    );
  }
}