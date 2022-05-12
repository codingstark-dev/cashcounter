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
  List listNotesCal = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(
        color: Colors.transparent,
        child: Text('bottom screen widget'),
        elevation: 0,
      ),
      body: FooterLayout(
        footer: const Text('footer widget'),
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
                        child: const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Payer',
                          ),
                        ),
                      ),
                    ),

                    Expanded(flex: 5, child: Text(payerString))
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true, // here

                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
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
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: new Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: new TextField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: new InputDecoration(
                                    hintText: '0',
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) => {
                                    // listNotesCal.add({
                                    //   "${listNotes.reversed.toList()[index]}":
                                    //       (int.parse(value) *
                                    //               int.parse(listNotes.reversed
                                    //                   .toList()[index]))
                                    //           .toString()
                                    // }),
                                    listNotesCal[listNotesCal.indexWhere(
                                            (element) =>
                                                element ==
                                                listNotes.reversed
                                                    .toList()[index])] =
                                        (int.parse(value) *
                                                int.parse(listNotes.reversed
                                                    .toList()[index]))
                                            .toString(),
                                    listNotesCal.forEach((element) {
                                      print(element[
                                          "${listNotes.reversed.toList()[index]}"]);
                                    }),
                                  }
                                  // create setstate for textfield
                                  ,
                                ),
                              )),
                          const SizedBox(width: 8),
                          const Text(
                            "= ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            listNotesCal[index]["${listNotes[index]}"],
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
