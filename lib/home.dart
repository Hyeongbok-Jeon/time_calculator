import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int minute = 0;
  int beforeMinute = 0;
  String expression = '00:00';
  String beforeExpression = '';
  int position = 0;
  List<String> hm = ['0', '0', '0', '0'];
  String _symbol = '';

  Widget number(int number) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              for (int i = position; i > 0; i--) {
                hm[i] = hm[i - 1];
              }
              hm[0] = number.toString();
              switch (position) {
                case 0:
                  minute += number;
                  break;
                case 1:
                  minute += number * 10;
                  break;
                case 2:
                  minute += number * 60;
                  break;
                case 3:
                  minute += number * 600;
                  break;
              }
              expression = '${hm[3]}${hm[2]}:${hm[1]}${hm[0]}';
              position += 1;
              print('minute: $minute');
            });
          },
          child: Container(
            color: Colors.yellow,
            child: FittedBox(
                child: Text(
              number.toString(),
            )),
          ),
        ),
      ),
    );
  }

  Widget symbol(String symbol) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _symbol = symbol;
              hm = ['0', '0', '0', '0'];
              position = 0;
              beforeMinute = minute;
              minute = 0;
              if (beforeExpression == '') {
                beforeExpression = expression;
                expression = '00:00';
              } else {
                int sum = 0;
                switch (_symbol) {
                  case '+':
                    sum = beforeMinute + minute;
                    break;
                  case '-':
                    sum = beforeMinute - minute;
                    break;
                }
                beforeExpression = '${sum ~/ 600}${(sum % 600) ~/ 60}:${sum % 60}';
              }
            });
          },
          child: Container(
            color: Colors.yellow,
            child: FittedBox(
                child: Text(
              symbol,
            )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                          color: Colors.black,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(beforeExpression, style: const TextStyle(color: Colors.grey
                                  , fontSize: 50))))),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end ,
                        children: [
                          Text(_symbol, style: TextStyle(color: Colors.white, fontSize: 50),),
                          Text(
                            expression,
                            style: const TextStyle(color: Colors.white, fontSize: 50),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        minute = 0;
                        expression = '00:00';
                        position = 0;
                        hm = ['0', '0', '0', '0'];
                        beforeExpression = '';
                        _symbol = '';
                      });
                    },
                    child: Container(
                      color: Colors.cyan,
                      child: Text('Delete'),
                      // child: const Icon(Icons.cancel),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(color: Colors.yellow),
                ),
                Expanded(
                  flex: 1,
                  child: Container(color: Colors.green),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                number(7),
                number(8),
                number(9),
                symbol('+'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                number(4),
                number(5),
                number(6),
                symbol('-'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                number(1),
                number(2),
                number(3),
                Expanded(
                  flex: 1,
                  child: Container(color: Colors.blue),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                number(0),
                Expanded(
                  flex: 1,
                  child: Container(color: Colors.green),
                ),
                symbol('='),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
