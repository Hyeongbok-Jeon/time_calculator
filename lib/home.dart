import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_calculator/settings.dart';

import 'SingleChoice.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String symbol = '';
  List<int> hmBefore = List<int>.generate(4, (index) => 0);
  List<int> hmAfter = List<int>.generate(4, (index) => 0);
  TimeUnit timeUnit = TimeUnit.HM;

  void onTimeUnitChanged(TimeUnit timeUnit) {
    setState(() {
      this.timeUnit = timeUnit;
    });
  }

  Expanded btnNumber(int number) {
    return Expanded(
      flex: 1,
      child: InkWell(
          onTap: () {
            setState(() {
              hmAfter.removeAt(0);
              hmAfter.add(number);
            });
          },
          child: Image.asset(
            'assets/number_$number.png',
            fit: BoxFit.fill,
          )),
    );
  }

  Expanded btnClear() {
    return Expanded(
      flex: 1,
      child: InkWell(
          onTap: () {
            setState(() {
              symbol = '';
              hmBefore = hmBefore.map((e) => 0).toList();
              hmAfter = hmBefore.map((e) => 0).toList();
            });
          },
          child: Image.asset(
            'assets/c.png',
            fit: BoxFit.fill,
          )),
    );
  }

  Expanded btnClearEntry() {
    return Expanded(
      flex: 1,
      child: InkWell(
          onTap: () {
            setState(() {
              hmAfter.insert(0, 0);
              hmAfter.removeLast();
            });
          },
          child: Image.asset(
            'assets/ce.png',
            fit: BoxFit.fill,
          )),
    );
  }

  Expanded btnFourBasicOperator(String operator) {
    return Expanded(
      flex: 1,
      child: InkWell(
          onTap: () {
            setState(() {
              int hmBeforeMinute = hmListToMinute(hmBefore);
              int hmAfterMinute = hmListToMinute(hmAfter);
              if (hmBeforeMinute == 0 && hmAfterMinute == 0) {
                return;
              }
              if (symbol == '') {
                hmBefore = hmAfter;
              } else {
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
          child: Image.asset(
            'assets/func_$operator.png',
            fit: BoxFit.fill,
          )),
    );
  }

  Expanded btnEqulity() {
    return Expanded(
      flex: 1,
      child: InkWell(
          onTap: () {
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
          child: Image.asset(
            'assets/equality.png',
            fit: BoxFit.fill,
          )),
    );
  }

  int hmListToMinute(List<int> hm) {
    return hm[0] * 600 + hm[1] * 60 + hm[2] * 10 + hm[3];
  }

  List<int> minuteToHmList(int minute) {
    return [(minute ~/ 60) ~/ 10, (minute ~/ 60) % 10, (minute % 60) ~/ 10, (minute % 60) % 10];
  }

  String hmListToExpression(List<int> hm) {
    return '${hm[0].toString()}${hm[1].toString()}:${hm[2].toString()}${hm[3].toString()}';
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
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('시간 계산기'),
              // IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => Settings()),
              //       );
              //     },
              //     icon: Icon(Icons.settings))
            ],
          )),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'), // 사용할 배경 이미지 경로
              fit: BoxFit.cover, // 이미지가 화면에 맞게 채워지도록 설정
            )),
        child: Column(
            children: [
            Expanded(
            flex: 3,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .outlineVariant,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: symbol == ''
                              ? const SizedBox()
                              : Text(hmListToExpression(hmBefore),
                              style: const TextStyle(color: Colors.grey, fontSize: 50)))),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          operatorToIconData(symbol),
                          size: 50,
                        ),
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
        Container(
          padding: const EdgeInsets.all(12),
          // height: MediaQuery.of(context).size.height / 2,
          height: 400,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/recess.png'), // 사용할 배경 이미지 경로
                fit: BoxFit.fill, // 이미지가 화면에 맞게 채워지도록 설정
              )),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  btnClearEntry(),
                  btnClear(),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  btnNumber(7),
                  btnNumber(8),
                  btnNumber(9),
                  btnFourBasicOperator('%'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  btnNumber(4),
                  btnNumber(5),
                  btnNumber(6),
                  btnFourBasicOperator('x'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  btnNumber(1),
                  btnNumber(2),
                  btnNumber(3),
                  btnFourBasicOperator('-'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  btnNumber(0),
                  const Expanded(flex: 1, child: SizedBox()),
                  btnEqulity(),
                  btnFourBasicOperator('+'),
                ],
              ),
            ),
          ],
        ),
      ),
      // Stack(
      //   children: [
      //     Container(
      //       height: 400,
      //       decoration: const BoxDecoration(
      //           image: DecorationImage(
      //         image: AssetImage('assets/recess.png'), // 사용할 배경 이미지 경로
      //         fit: BoxFit.cover, // 이미지가 화면에 맞게 채워지도록 설정
      //       )),
      //     ),
      //     Padding(
      //       padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 15 / 1000, 0, 0),
      //       child: Container(
      //         // decoration: BoxDecoration(color: Colors.orange),
      //         height: 400,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             SizedBox(
      //               height: 80,
      //               child: Row(
      //                 children: [
      //                   const Expanded(
      //                     flex: 2,
      //                     child: SizedBox(),
      //                   ),
      //                   btnClearEntry(),
      //                   btnClear(),
      //                 ],
      //               ),
      //             ),
      //             Row(
      //               children: [
      //                 btnNumber(7),
      //                 btnNumber(8),
      //                 btnNumber(9),
      //                 btnFourBasicOperator('%'),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 btnNumber(4),
      //                 btnNumber(5),
      //                 btnNumber(6),
      //                 btnFourBasicOperator('x'),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 btnNumber(1),
      //                 btnNumber(2),
      //                 btnNumber(3),
      //                 btnFourBasicOperator('-'),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 btnNumber(0),
      //                 const Expanded(flex: 1, child: SizedBox()),
      //                 btnEqulity(),
      //                 btnFourBasicOperator('+'),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // )
      ],
    ),)
    ,
    );
  }
}
