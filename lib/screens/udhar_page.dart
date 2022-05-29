import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'dart:math' as math;

class UdharPage extends StatelessWidget {
  const UdharPage({Key? key, data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text(
                "d",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              backgroundColor:
                  Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
            ),
            title: Text(
              " data['name']",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Cr. 0",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt),
                      padding: EdgeInsets.all(0),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu),
                      padding: EdgeInsets.all(0),
                    ),
                  ],
                ),
              ],
            ),
            // trailing: Row(
            //   children: [
            //     Expanded(
            //       child: IconButton(
            //           icon: const Icon(Icons.phone_forwarded),
            //           iconSize: 20,
            //           color: Colors.green,
            //           onPressed: () {
            //             showDialog(
            //                 context: context,
            //                 builder: (BuildContext context) {
            //                   return AlertDialog(
            //                     title: const Text("Options"),
            //                     content: const Text("Select an option"),
            //                     actions: [
            //                       TextButton(
            //                         child: const Text("Edit"),
            //                         onPressed: () {},
            //                       ),
            //                       TextButton(
            //                         child: const Text("Delete"),
            //                         onPressed: () {},
            //                       ),
            //                     ],
            //                   );
            //                 });
            //           }),
            //     ),
            //     Expanded(child: const Text("0"))
            //   ],
            // ),
          ),
          Container(),
        ],
      ),
    ));
  }

  getTitleText(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      );

  getSenderView(CustomClipper clipper, BuildContext context) => ChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Colors.blue,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  getReceiverView(CustomClipper clipper, BuildContext context) => ChatBubble(
        clipper: clipper,
        backGroundColor: Color(0xffE7E7ED),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}
