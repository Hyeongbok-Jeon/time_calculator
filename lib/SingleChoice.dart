import 'package:flutter/material.dart';

enum TimeUnit {
  HM,
  MS,
  HMS,
}

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key, required this.onTimeUnitChanged});

  final Function onTimeUnitChanged;

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  TimeUnit unit = TimeUnit.HM;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<TimeUnit>(
      segments: const <ButtonSegment<TimeUnit>>[
        ButtonSegment<TimeUnit>(value: TimeUnit.HM, label: Text('시:분'), icon: Icon(Icons.watch_later_outlined)),
        ButtonSegment<TimeUnit>(value: TimeUnit.MS, label: Text('분:초'), icon: Icon(Icons.watch_later_outlined)),
        ButtonSegment<TimeUnit>(value: TimeUnit.HMS, label: Text('시:분:초'), icon: Icon(Icons.watch_later_outlined)),
      ],
      selected: <TimeUnit>{unit},
      onSelectionChanged: (newSelection) {
        setState(() {
          unit = newSelection.first;
          widget.onTimeUnitChanged(unit);
        });
      },
    );
  }
}
