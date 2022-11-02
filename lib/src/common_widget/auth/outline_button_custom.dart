import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OutlineButtonCostum extends StatelessWidget {
  final void Function()? onPressed;
  final Color color;
  final IconData iconData;
  final String label;
  const OutlineButtonCostum({
    super.key,
    this.onPressed,
    required this.color,
    required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        fixedSize: Size(size.width * 0.9, 45),
        side: BorderSide(color: color),
      ),
      icon: FaIcon(iconData),
      label: Text(label),
    );
  }
}
