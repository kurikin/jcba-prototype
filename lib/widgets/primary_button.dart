import 'package:flutter/material.dart';

/*
PrimaryButton(
                labelText: 'UPDATE',
                onPressed: () => print('Submit'),
              ),
*/

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.labelText,
      required this.onPressed,
      required this.color})
      : super(key: key);

  final String labelText;
  final void Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        labelText.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
