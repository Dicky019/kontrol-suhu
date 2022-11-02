
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchCostum extends StatelessWidget {
  final bool value;
  final String title;
  final void Function(bool)? onChanged;
  const SwitchCostum({
    Key? key,
    required this.value,
    this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        CupertinoSwitch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}