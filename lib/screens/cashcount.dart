import 'package:flutter/material.dart';

class CashCounter extends StatefulWidget {
  CashCounter({Key? key}) : super(key: key);

  @override
  State<CashCounter> createState() => _CashCounterState();
}

class _CashCounterState extends State<CashCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Payer',
                      ),
                    ),
                  ),
                ),

                Expanded(flex: 5, child: Text("data"))
              ],
            ),
          ),
        )
      ]),
    );
  }
}
