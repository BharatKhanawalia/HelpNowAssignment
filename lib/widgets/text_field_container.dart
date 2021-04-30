import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double width;
  final double vertical;
  final Color backgroundColor;
  const TextFieldContainer({
    this.child,
    this.vertical = 5,
    this.width,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: vertical,
      ),
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
