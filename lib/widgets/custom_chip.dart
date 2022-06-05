import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({Key? key, required this.label, required this.color})
      : super(key: key);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: AutoSizeText(
        label,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          height: 1,
          fontSize: 13,
          color: Colors.white,
        ),
      ),
    );
  }
}
