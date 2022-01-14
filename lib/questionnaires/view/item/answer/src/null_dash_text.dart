import 'package:faiadashu/questionnaires/view/view.dart' show variant600Opacity;
import 'package:flutter/material.dart';

class NullDashText extends StatelessWidget {
  const NullDashText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '   ',
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            decoration: TextDecoration.lineThrough,
            color: Theme.of(context)
                .textTheme
                .bodyText2!
                .color!
                .withOpacity(variant600Opacity),
          ),
    );
  }
}
