import 'package:flutter/material.dart';
/*
LabelButton(
                labelText: 'Some Text',
                onPressed: () => print('implement me'),
              ),
*/

class LabelButton extends StatelessWidget {
  const LabelButton(
      {Key? key, required this.labelText, required this.onPressed})
      : super(key: key);
  final String labelText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        labelText,
        style: const TextStyle(color: Colors.blue, fontSize: 15),
      ),
      onPressed: onPressed,
    );
  }
}
