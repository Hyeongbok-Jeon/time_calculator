import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String symbol = '';
  List<int> hmBefore = [0, 0, 0, 0];
  List<int> hmAfter = [0, 0, 0, 0];

  Expanded btnNumber(int number) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FloatingActionButton.extended(
          label: Text(number.toString()),
          onPressed: () {
            setState(() {
              hmAfter.removeAt(0);
              hmAfter.add(number);
            });
          },
        ),
      ),
    );
  }

  Expanded btnReset() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FloatingActionButton.extended(
          label: const Icon(CupertinoIcons.trash),
          onPressed: () {
            setState(() {
              symbol = '';
              hmBefore = [0, 0, 0, 0];
              hmAfter = [0, 0, 0, 0];
            });
          },
        ),
      ),
    );
  }

  Expanded btnFourBasicOperator(String operator) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FloatingActionButton.extended(
          label: Icon(operatorToIconData(operator)),
          onPressed: () {
            setState(() {
              if (symbol == '') {
                hmBefore = hmAfter;
              } else {
                int hmBeforeMinute = hmListToMinute(hmBefore);
                int hmAfterMinute = hmListToMinute(hmAfter);
                if (hmAfterMinute > 0) {
                  switch (symbol) {
                    case '+':
                      int calResult = hmBeforeMinute + hmAfterMinute;
                      hmBefore = minuteToHmList(calResult);
                      break;
                    case '-':
                      if (hmBeforeMinute >= hmAfterMinute) {
                        int calResult = hmBeforeMinute - hmAfterMinute;
                        hmBefore = minuteToHmList(calResult);
                      } else {
                        hmBefore = hmBefore.map((e) => 0).toList();
                      }
                      break;
                    case 'x':
                      int calResult = hmBeforeMinute * hmAfterMinute;
                      hmBefore = minuteToHmList(calResult);
                      break;
                    case '%':
                      int calResult = hmBeforeMinute ~/ hmAfterMinute;
                      hmBefore = minuteToHmList(calResult);
                      break;
                  }
                }
              }
              symbol = operator;
              hmAfter = hmAfter.map((e) => 0).toList();
            });
          },
        ),
      ),
    );
  }

  Expanded btnEqual() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FloatingActionButton.extended(
          label: const Icon(CupertinoIcons.equal),
          onPressed: () {
            setState(() {
              int calResult;
              int hmBeforeMinute = hmListToMinute(hmBefore);
              int hmAfterMinute = hmListToMinute(hmAfter);
              switch (symbol) {
                case '+':
                  calResult = hmBeforeMinute + hmAfterMinute;
                  hmAfter = minuteToHmList(calResult);
                  break;
                case '-':
                  if (hmBeforeMinute >= hmAfterMinute) {
                    calResult = hmBeforeMinute - hmAfterMinute;
                    hmAfter = minuteToHmList(calResult);
                  } else {
                    hmAfter = hmAfter.map((e) => 0).toList();
                  }
                  break;
                case 'x':
                  calResult = hmBeforeMinute * hmAfterMinute;
                  hmAfter = minuteToHmList(calResult);
                  break;
                case '%':
                  if (hmAfterMinute == 0) {
                    hmAfter = hmAfter.map((e) => 0).toList();
                  } else {
                    int calResult = hmBeforeMinute ~/ hmAfterMinute;
                    hmAfter = minuteToHmList(calResult);
                  }
                  break;
              }
              hmBefore = hmBefore.map((e) => 0).toList();
              symbol = '';
            });
          },
        ),
      ),
    );
  }

  int hmListToMinute(List<int> hm) {
    return hm[0] * 600 + hm[1] * 60 + hm[2] * 10 + hm[3];
  }

  List<int> minuteToHmList(int minute) {
    return [(minute ~/ 60) ~/ 10, (minute ~/ 60) % 10, (minute % 60) ~/ 10, (minute % 60) % 10];
  }

  String hmListToExpression(List<int> hm) {
    return '${hm[0].toString()}${hm[1].toString()}시간 ${hm[2].toString()}${hm[3].toString()}분';
  }

  IconData? operatorToIconData(String operator) {
    switch (operator) {
      case '+':
        return CupertinoIcons.add;
      case '-':
        return CupertinoIcons.minus;
      case 'x':
        return CupertinoIcons.multiply;
      case '%':
        return CupertinoIcons.divide;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: symbol == ''
                                  ? const SizedBox()
                                  : Text(
                                      // '${hmBefore[0].toString()}${hmBefore[1].toString()}시간 ${hmBefore[2].toString()}${hmBefore[3].toString()}분',
                                      hmListToExpression(hmBefore),
                                      style: const TextStyle(color: Colors.grey, fontSize: 50)))),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(operatorToIconData(symbol), size: 50,),
                            Text(
                              hmListToExpression(hmAfter),
                              style: const TextStyle(fontSize: 50),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  btnReset(),
                  // btnSymbol('<'),
                  btnFourBasicOperator('%'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  btnNumber(7),
                  btnNumber(8),
                  btnNumber(9),
                  btnFourBasicOperator('x'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  btnNumber(4),
                  btnNumber(5),
                  btnNumber(6),
                  btnFourBasicOperator('-'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  btnNumber(1),
                  btnNumber(2),
                  btnNumber(3),
                  btnFourBasicOperator('+'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  btnNumber(0),
                  btnEqual(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
