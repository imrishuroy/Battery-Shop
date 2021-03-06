import 'package:flutter/material.dart';

class TableEntryText extends StatelessWidget {
  final String? value;
  final TextAlign textAlign;

  const TableEntryText({
    Key? key,
    required this.value,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
      child: SizedBox(
        child: Center(
          child: Text(
            '$value',
            style: const TextStyle(fontSize: 16.0),
            textAlign: textAlign,
          ),
        ),
      ),
    );
  }
}
