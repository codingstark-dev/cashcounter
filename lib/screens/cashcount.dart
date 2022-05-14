import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';

class CashCounter extends StatefulWidget {
  CashCounter({Key? key}) : super(key: key);

  @override
  State<CashCounter> createState() => _CashCounterState();
}

class _CashCounterState extends State<CashCounter> {
  var payerString = "<--- Enter The Amount Tally Payer";
  var calNum = 0;
  List listNotes = [
    "2000",
    "500",
    "200",
    "100",
    "50",
    "20",
    "10",
    "5",
    "2",
    "1"
  ];
  List<Map<String, String>> listNotesCal = [
    {"2000": "0"},
    {"500": "0"},
    {"200": "0"},
    {"100": "0"},
    {"50": "0"},
    {"20": "0"},
    {"10": "0"},
    {"5": "0"},
    {"2": "0"},
    {"1": "0"}
  ];
  TextEditingController controller = TextEditingController(
    text: '',
  );
  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   super.setState(fn);
  //   controller.addListener(() {
  //     setState(() {
  //       payerString = controller.text;
  //     });
  //   });
  //   listNotesCal.forEach((element) {
  //     element.forEach((key, value) {
  //       setState(() {
  //         calNum += int.parse(value);
  //       });
  //     });
  //   });

  //   print(calNum);
  // }
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.text.isEmpty) {
        setState(() {
          payerString = "<--- Enter The Amount Tally Payer";
        });
      } else if (calNum > int.parse(controller.text)) {
        setState(() {
          payerString = "Greater By +₹${calNum - int.parse(controller.text)}";
        });
      } else {
        setState(() {
          payerString =
              "Less By -₹${(calNum - int.parse(controller.text)).abs()}";
        });
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    calNum = 0;
    listNotesCal.forEach((element) {
      element.forEach((key, value) {
        calNum += int.parse(value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(
        color: Colors.transparent,
        child: Text('bottom screen widget'),
        elevation: 0,
      ),
      body: FooterLayout(
        footer: SizedBox(
          height: 100,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 35,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                        iconSize: 20,
                        color: Colors.white,
                      )),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 8, top: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 1),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: const Text("1 Notes")),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 8, top: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 1),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: const Text("1 Notes")),
                  ),
                  Container(
                      height: 35,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                        iconSize: 20,
                        color: Colors.white,
                      )),
                ],
              ),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 35,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.volume_up),
                        iconSize: 20,
                        color: Colors.white,
                      )),
                  Text("Zero")
                ],
              )
            ],
          ),
        ),
        child: Container(
          child: Column(children: <Widget>[
            Container(
              color: Colors.grey[300],
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    //create box textfield for cash
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                          ],
                          keyboardType: TextInputType.number,
                          controller: controller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Payer',
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                        flex: 5,
                        child: Text(
                          payerString,
                          style: TextStyle(
                            color: (payerString.contains("+"))
                                ? Colors.green
                                : !payerString.contains("<--- ")
                                    ? Colors.red
                                    : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true, // here

                itemCount: listNotes.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = listNotes[index];
                  return Container(
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset('assets/notes/${index + 1}.jpg',
                              height: 50),
                          // SizedBox(width: 10),
                          SizedBox(
                            width: 50,
                            child: Text(
                              listNotes.reversed.toList()[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "X",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                              width: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]"))
                                  ],

                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    hintText: '0',
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (String value) {
                                    int tempNum = 0;
                                    if (value.isNotEmpty) {
                                      if (tempNum == 0) {
                                        tempNum = int.parse(listNotesCal[index]
                                                [item]
                                            .toString());
                                      } else {
                                        tempNum = 0;
                                      }
                                    }
                                    debugPrint(tempNum.toString());
                                    if (value == "") {
                                      calNum = 0;
                                      setState(() {
                                        listNotesCal[index][item] = "0";
                                      });
                                    } else {
                                      setState(() {
                                        listNotesCal[index][item] =
                                            ((int.parse(value)) *
                                                    int.parse(listNotes.reversed
                                                        .toList()[index]))
                                                .toString();
                                      });
                                    }
                                    if (controller.text.isEmpty) {
                                      setState(() {
                                        payerString =
                                            "<--- Enter The Amount Tally Payer";
                                      });
                                    } else if (calNum >
                                        int.parse(controller.text)) {
                                      setState(() {
                                        payerString =
                                            "Greater By +₹${calNum - int.parse(controller.text)}";
                                      });
                                    } else {
                                      setState(() {
                                        payerString =
                                            "Less By -₹${(calNum - int.parse(controller.text)).abs()}";
                                      });
                                    }

                                    // calNum = 0;
                                    // if (int.parse(value) < tempNum) {
                                    //   setState(() {
                                    //     calNum = int.parse(listNotesCal[index]
                                    //             [item]
                                    //         .toString());
                                    //   });
                                    // } else {
                                    //   calNum -= tempNum;
                                    // }

                                    // print("sd" +
                                    //     listNotesCal[index][item].toString());
                                  },

                                  // onChanged: (value) => {
                                  //   listNotesCal.add({
                                  //     "${listNotes.reversed.toList()[index]}":
                                  //         (int.parse(value) *
                                  //                 int.parse(listNotes.reversed
                                  //                     .toList()[index]))
                                  //             .toString()
                                  //   }),
                                  //   listNotesCal[listNotesCal.indexWhere(
                                  //           (element) =>
                                  //               element ==
                                  //               listNotes.reversed
                                  //                   .toList()[index])] =
                                  //       (int.parse(value) *
                                  //               int.parse(listNotes.reversed
                                  //                   .toList()[index]))
                                  //           .toString(),
                                  //   listNotesCal.forEach((element) {
                                  //     print(element[
                                  //         "${listNotes.reversed.toList()[index]}"]);
                                  //   }),
                                  // }
                                  // create setstate for textfield
                                ),
                              )),
                          const SizedBox(width: 8),
                          const Text(
                            "= ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            listNotesCal[index]["${listNotes[index]}"]
                                .toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
