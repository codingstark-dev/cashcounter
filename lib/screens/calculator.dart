import 'package:cashcounter/widgets/mybtn.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool gst = false;

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
    return Column(
      children: <Widget>[
        (cgst != '')
            ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    const Text("CGST: "),
                    Text(cgst,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    const Text(" SGST: "),
                    Text(sgst,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            : Container(),
        Expanded(
          flex: 1,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    scrollable: true,
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Text(
                                              "Change Slot Value GST Plus (+)",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            height:
                                                250.0, // Change as per your requirement
                                            width:
                                                400.0, // Change as per your requirement
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: gst1plus.length,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Divider();
                                              },
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("(GST +) Slot 1 ="),
                                                    SizedBox(
                                                      height: 30,
                                                      width: 60,
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5,
                                                                  top: 10),
                                                          isDense: true,
                                                          // labelText:
                                                          //     gst1plus[index],
                                                          hintText:
                                                              gst1plus[index],
                                                          // border:
                                                          //     OutlineInputBorder(
                                                          //   borderRadius:
                                                          //       BorderRadius
                                                          //           .circular(
                                                          //               10),
                                                          // ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("%")
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          const Text(
                                              "Change Slot Value GST Minus (-)",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            height:
                                                250.0, // Change as per your requirement
                                            width:
                                                400.0, // Change as per your requirement
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: gst1plus.length,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Divider();
                                              },
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("(GST -) Slot 1 ="),
                                                    SizedBox(
                                                      height: 30,
                                                      width: 60,
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5,
                                                                  top: 10),
                                                          isDense: true,
                                                          // labelText:
                                                          //     gst1plus[index],
                                                          hintText:
                                                              gst1minus[index],
                                                          // border:
                                                          //     OutlineInputBorder(
                                                          //   borderRadius:
                                                          //       BorderRadius
                                                          //           .circular(
                                                          //               10),
                                                          // ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("%")
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );

                                // showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return AlertDialog(
                                //           content: Container(
                                //         width:
                                //             MediaQuery.of(context).size.width *
                                //                 0.9,
                                //         height:
                                //             MediaQuery.of(context).size.height *
                                //                 0.9,
                                //         child: Column(
                                //           children: [
                                //             const Text(
                                //                 "Change Slot Value GST Plus(+)"),
                                //             const Divider(),
                                //             Row(
                                //               children: [
                                //                 Text("(GST +) Slot 1 ="),
                                //                 TextField(),
                                //                 Text("%")
                                //               ],
                                //             )
                                //           ],
                                //         ),
                                //       ));
                                //     });
                              },
                              icon: const Icon(Icons.settings))),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.centerRight,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                userInput,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 0, left: 5, right: 5, top: 0),
                            alignment: Alignment.centerRight,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                answer,
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
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
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Text(
                    "GST:",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      gst1plus.length,
                      (index) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: InkWell(
                                onTap: () {
                                  print(userInput);
                                  if (userInput.isEmpty && userInput == '') {
                                    Fluttertoast.showToast(
                                        msg: "Enter Value to calculate gst");
                                  } else {
                                    gst = true;
                                    oginput = userInput;
                                    // userInput = userInput +
                                    //     "+" +
                                    //     "(${userInput}*0.0${gst1plus[index].toString().replaceAll("%", "").replaceAll("+", "")})";
                                    // 5-(5*0.03)
                                    userInput =
                                        "$userInput*(1+${gst1plus[index].toString().replaceAll("%", "").replaceAll("+", "")}/100)";
                                    equalPressed();
                                    cgst = ((num.parse(answer) -
                                                num.parse(oginput)) /
                                            2)
                                        .abs()
                                        .toStringAsFixed(5)
                                        .toString();
                                    sgst = cgst;
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    gst1plus[index],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
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
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Text(
                    "GST:",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      gst1minus.length,
                      (index) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: InkWell(
                                onTap: () {
                                  if (userInput.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Enter Value to calculate gst");
                                  } else {
                                    gst = true;
                                    oginput = userInput;
                                    // userInput = userInput +
                                    //     "-" +
                                    //     "(${userInput}*0.0${gst1plus[index].toString().replaceAll("%", "").replaceAll("+", "")})";
                                    userInput =
                                        "$userInput/(1+${gst1minus[index].toString().replaceAll("%", "").replaceAll("-", "")}/100)";
                                    // 5-(5*0.03)
                                    equalPressed();
                                    cgst = ((num.parse(answer) -
                                                num.parse(oginput)) /
                                            2)
                                        .abs()
                                        .toStringAsFixed(5)
                                        .toString();
                                    sgst = cgst;
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    gst1minus[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        gst = false;
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
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      if (gst) {
        answer = eval.toStringAsFixed(5);
      } else {
        answer = eval.toString();
      }
    });
  }
}
