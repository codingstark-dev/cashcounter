import 'package:flutter/material.dart';

class Credit extends StatefulWidget {
  Credit({Key? key}) : super(key: key);

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Credit"),
    );
  }
}
