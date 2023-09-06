import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> hm = [0, 0, 0, 0];
  String symbol = '';

  Widget btnNumber(int number) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FloatingActionButton.extended(
          label: Text(number.toString()),
          onPressed: () {
            setState(() {
              hm.removeAt(0);
              hm.add(number);
              print(hm);
            });
          },
        ),
      ),
    );
  }

  Widget btnDelete() {
    return FloatingActionButton.extended(
      label: const Icon(CupertinoIcons.trash),
      onPressed: () {
        setState(() {
          hm = [0, 0, 0, 0];
        });
      },
    );
  }

  Widget btnAdd() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FloatingActionButton.extended(
          label: const Icon(CupertinoIcons.add),
          onPressed: () {
            setState(() {
              symbol = '+';
              hm = [0, 0, 0, 0];
            });
          },
        ),
      ),
    );
  }

  Widget btnSymbol(String symbol, {int flex = 1}) {
    IconData iconData = CupertinoIcons.airplane;
    switch (symbol) {
      case '+':
        iconData = CupertinoIcons.add;
        break;
      case '-':
        iconData = CupertinoIcons.minus;
        break;
      case 'x':
        iconData = CupertinoIcons.multiply;
        break;
      case '%':
        iconData = CupertinoIcons.divide;
        break;
      case 'C':
        iconData = CupertinoIcons.trash;
        break;
      case '<':
        iconData = CupertinoIcons.left_chevron;
        break;
      case '=':
        iconData = CupertinoIcons.equal;
        break;
    }

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FloatingActionButton.extended(
          label: Icon(iconData),
          onPressed: () {
            setState(() {});
          },
        ),
      ),
    );
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
                          child: Container(
                              child: const Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text('', style: TextStyle(color: Colors.grey, fontSize: 50))))),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(symbol),
                              Text(
                                '${hm[0].toString()}${hm[1].toString()}시간 ${hm[2].toString()}${hm[3].toString()}분',
                                style: const TextStyle(fontSize: 50),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(flex: 2, child: Padding(padding: const EdgeInsets.all(5.0), child: btnDelete())),
                  btnSymbol('<'),
                  btnSymbol('%'),
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
                  btnSymbol('x'),
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
                  btnSymbol('-'),
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
                  btnAdd(),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  btnNumber(0),
                  btnSymbol('='),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
