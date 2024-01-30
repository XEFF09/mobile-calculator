import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  final calculatorButton = [
    '7', '8', '9', '÷',
    '4', '5', '6', '×',
    '1', '2', '3', '-',
    '0', '.', '=', '+',
  ];

  final ops = [
    '÷', '×', '-', '+', '='
  ];

  String currentNum = '0';
  String result = '0';

  String ins = '';
  String leftIns = '', rightIns = '';
  bool isSuffix = true;

  void onCurrent({required String input}) {
    setState(() {
      currentNum = input;
    });
  }

  void onResult({required String input}) {
    setState(() {
      result = input;
    });
  }

  void onClear() {
    setState(() {
      currentNum = '0';
      result = '0';
      ins = '';
      leftIns = '';
      rightIns = '';
      isSuffix = true;
    });
  }

  void onCalculate({required String input}) {
    if (ops.contains(input) && isSuffix) {
      ins = input;
      isSuffix = false;
      return;
    }
    else if (!ops.contains(input) && !isSuffix) {
      rightIns += input;
      onCurrent(input: rightIns);
      return;
    }
    else if (ops.contains(input) && !isSuffix) {
      switch (ins) {
        case '÷':
          leftIns = (double.parse(leftIns) / double.parse(rightIns)).toString();
          break;
        case '×':
          leftIns = (double.parse(leftIns) * double.parse(rightIns)).toString();
          break;
        case '-':
          leftIns = (double.parse(leftIns) - double.parse(rightIns)).toString();
          break;
        case '+':
          leftIns = (double.parse(leftIns) + double.parse(rightIns)).toString();
          break;
      }
      ins = input;
      rightIns = '';

      onResult(input: leftIns);
      return;
    } 
    leftIns += input;
    onCurrent(input: leftIns);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),  
        ),
        backgroundColor: Colors.blueGrey[100],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 350,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        result.toString(),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 176, 134, 8)
                        ),
                      ),
                    )
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        currentNum.toString(),
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber
                        ),
                      ),
                    )
                  ),
                ],
              )
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                      crossAxisCount: 4,
                      children: calculatorButton.map((e) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onPressed: () {
                              onCurrent(input: e);
                              onCalculate(input: e);
                            },
                            child: Text(e, 
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber
                              )
                            ),
                          ),
                        );
                      }).toList(),
                    ) 
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onPressed: () {
                              onClear();
                            },
                            child: const Text('Clear/AC', 
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber
                              ),
                            ),
                          )
                        )
                      ],
                    )
                  ],
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
