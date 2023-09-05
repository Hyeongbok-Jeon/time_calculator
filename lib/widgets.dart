import 'package:flutter/material.dart';

class widgetNumber extends StatefulWidget {
  widgetNumber({Key? key, required this.number, required this.onUpdateResult}) : super(key: key);

  final int number;
  final Function(int) onUpdateResult;

  @override
  State<widgetNumber> createState() => _widgetNumberState();
}

class _widgetNumberState extends State<widgetNumber> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.onUpdateResult(widget.number);
            });
          },
          child: Container(
            color: Colors.yellow,
            child: FittedBox(
                child: Text(
                  widget.number.toString(),
                )),
          ),
        ),
      ),
    );
  }
}