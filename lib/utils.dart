import 'package:flutter/material.dart';

class TextL extends StatelessWidget {
  const TextL({super.key, required this.str});
  final String str;

  @override
  Widget build(BuildContext context) {
    return Text(
      str,
      style: TextStyle(fontSize: 22),
    );
  }
}

class TextM extends StatelessWidget {
  const TextM({super.key, required this.str});
  final String str;

  @override
  Widget build(BuildContext context) {
    return Text(
      str,
      style: TextStyle(fontSize: 17),
    );
  }
}

class TextS extends StatelessWidget {
  const TextS({super.key, required this.str});
  final String str;

  @override
  Widget build(BuildContext context) {
    return Text(
      str,
      style: TextStyle(fontSize: 12),
    );
  }
}

class FitText extends StatelessWidget {
  const FitText({super.key, required this.str});
  final String str;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Text(str),
    );
  }
}
