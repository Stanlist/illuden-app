import 'package:flutter/material.dart';
import 'package:illuden/widgets/light_settings/buttons/power_switch.dart';

import 'package:illuden/widgets/light_settings/buttons/bulk_select.dart';


class Page1PowerView extends StatelessWidget {
  const Page1PowerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: BulkSelectToggle(),
        ),
        Expanded(child: Container()), 
        const PowerSwitch(),
      ],
    );
  }
}

class Page2PowerView extends StatelessWidget {
  const Page2PowerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [

        Expanded(child: Container()), 
        const PowerSwitch(),
      ],
    );
  }
}
