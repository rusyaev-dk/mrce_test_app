import 'package:flutter/material.dart';
import 'package:mrce_test_app/app/app.dart';

class BottomSheetDragger extends StatelessWidget {
  const BottomSheetDragger({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      height: 5,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: colorScheme.surfaceDim.withAlpha(100),
      ),
    );
  }
}
