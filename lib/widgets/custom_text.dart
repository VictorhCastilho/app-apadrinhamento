import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  CustomText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}