import 'package:flutter/material.dart';

class NullDashText extends StatelessWidget {
  const NullDashText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '   ',
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
          decoration: TextDecoration.lineThrough,
          color:
              Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.54)),
    );
  }
}
