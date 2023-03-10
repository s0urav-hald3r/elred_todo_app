import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DrawerLogo extends StatelessWidget {
  const DrawerLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 2.5,
          color: Colors.white70,
        ),
        const Gap(5),
        Container(
          width: 15,
          height: 2.5,
          color: Colors.white70,
        ),
        const Gap(5),
        Container(
          width: 25,
          height: 2.5,
          color: Colors.white70,
        )
      ],
    );
  }
}
