import 'package:flutter/material.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/features/route_builder/presentation/presentation.dart';

class AddressRow extends StatelessWidget {
  const AddressRow({
    required this.address,
    required this.letter,
    required this.color,
    super.key,
  });

  final String address;
  final String letter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RouteLetterMarker(letter: letter, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            address,
            style: context.textScheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
