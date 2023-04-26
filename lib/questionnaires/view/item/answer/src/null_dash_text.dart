import 'package:faiadashu/questionnaires/view/view.dart' show variant600Opacity;
import 'package:flutter/material.dart';

class NullDashText extends StatelessWidget {
  const NullDashText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '   ',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            decoration: TextDecoration.lineThrough,
            color: Theme.of(context)
                .textTheme
                .bodyMedium!
                .color!
                .withOpacity(variant600Opacity),
          ),
    );
  }
}
