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
      child: Text("Cash Counter"),
    );
  }
}
