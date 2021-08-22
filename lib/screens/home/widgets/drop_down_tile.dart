import 'package:flutter/material.dart';

class DropDownTile extends StatelessWidget {
  final String? label;
  final Function onPressed;

  const DropDownTile({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey.shade600),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text('$label'),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(Icons.arrow_drop_down, size: 35.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
