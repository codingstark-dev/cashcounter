import 'package:flutter/material.dart';

class Credit extends StatefulWidget {
  Credit({Key? key}) : super(key: key);

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Column(
          children: [
            Text("Total: 4444"),
            Divider(height: 0),
            Expanded(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("cr2232"),
                  const VerticalDivider(),
                  Text("cr2232")
                ],
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          // create search bar
          Container(
            margin: EdgeInsets.only(top: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            child: Text("Something went wrong, please try again"),
          ),
        ],
      ),
    );
  }
}
