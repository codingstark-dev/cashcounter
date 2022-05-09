import 'package:cashcounter/widgets/mybtn.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = '';
  var answer = '';
  var sgst = '';
  var cgst = '';
  var oginput = '';
  // Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  final List<String> gst1plus = ["+3%", "+5%", "+12%", "+18%", "+28%"];
  final List<String> gst1minus = ["-3%", "-5%", "-12%", "-18%", "-28%"];

  @override
  Widget build(BuildContext context) {
    setState(() {
      print(userInput);
    });
    return Column(
      children: <Widget>[
        (cgst != '')
            ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Text("CGST: "),
                    Text(cgst, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 5),
                    Text(" SGST: "),
                    Text(sgst, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            : Container(),
        Expanded(
          flex: 1,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(bottom: 0, left: 5, right: 5, top: 0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    answer,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: 20),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  "GST:",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      gst1plus.length,
                      (index) => InkWell(
                            onTap: () {
                              oginput = userInput;
                              userInput = userInput +
                                  "+" +
                                  "(${userInput}*0.0${gst1plus[index].toString().replaceAll("%", "").replaceAll("+", "")})";
// 5-(5*0.03)
                              equalPressed();
                              cgst = ((double.parse(answer) -
                                          double.parse(oginput)) /
                                      2)
                                  .toStringAsFixed(2)
                                  .toString();
                              sgst = cgst;
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                gst1plus[index],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: 20),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  "GST:",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      gst1minus.length,
                      (index) => InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                gst1minus[index],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 70, // here set custom Height You Want
              ),
              itemBuilder: (BuildContext context, int index) {
                // Clear Button
                if (index == 0) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        cgst = '';
                        sgst = '';
                        userInput = '';
                        answer = '0';
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.blue[50],
                    textColor: Colors.black,
                  );
                }

                // +/- button
                else if (index == 1) {
                  return MyButton(
                    buttonText: buttons[index],
                    color: Colors.blue[50],
                    textColor: Colors.black,
                  );
                }
                // % Button
                else if (index == 2) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.blue[50],
                    textColor: Colors.black,
                  );
                }
                // Delete Button
                else if (index == 3) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput =
                            userInput.substring(0, userInput.length - 1);
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.blue[50],
                    textColor: Colors.black,
                  );
                }
                // Equal_to Button
                else if (index == 18) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.orange[700],
                    textColor: Colors.white,
                  );
                }

                //  other buttons
                else {
                  return SizedBox(
                    height: 50,
                    child: MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.blueAccent
                          : Colors.white,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                    ),
                  );
                }
              }),
        ),
      ],
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void gstPressed(gst) {
    String finaluserinput = userInput + gst;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      answer = eval.toString();
    });
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    print(p.parse("5-(5*0.03)"));
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      answer = eval.toString();
    });
  }
}
