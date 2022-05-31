import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';

import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class UdharPage extends StatefulWidget {
  const UdharPage({Key? key, data}) : super(key: key);

  @override
  State<UdharPage> createState() => _UdharPageState();
}

class _UdharPageState extends State<UdharPage> {
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    late DateTime date = DateTime.now();

    return Scaffold(
        bottomNavigationBar: Container(
            // create box decoration
            decoration: BoxDecoration(
              // set background color
              color: const Color.fromARGB(255, 153, 231, 164).withOpacity(0.2),
              // set the border
              border: const Border(
                top: BorderSide(
                  // set the width
                  width: 2.0,
                  // set the color
                  color: Colors.black,
                ),
              ),
            ),
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      "Cr. 4444",
                      style: TextStyle(
                          color: Color.fromARGB(255, 8, 95, 11),
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Container(
                        height: 40, width: 95,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 8, 95, 11),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        // margin: const EdgeInsets.only(left: 5, right: 10),
                        child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                              void Function(void Function())
                                                  setState) =>
                                          AlertDialog(
                                        title: Center(
                                            child:
                                                const Text("Add New Person")),
                                        content: SizedBox(
                                          height: 100,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        child: Icon(
                                                            Icons.payments)),
                                                    Expanded(
                                                        flex: 4,
                                                        child: SizedBox(
                                                          height: 40,
                                                          child: TextField(
                                                            // controller:
                                                            //     nameController,
                                                            textAlign: TextAlign
                                                                .center,
                                                            decoration:
                                                                InputDecoration(
                                                              prefixIcon: Icon(Icons
                                                                  .currency_rupee),
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom: 0,
                                                                      right: 0,
                                                                      left: 5,
                                                                      top: 0),
                                                              hintText:
                                                                  'Enter Amount',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                    // Expanded(
                                                    //   flex: 1,
                                                    //   child: IconButton(
                                                    //       onPressed: () async {},
                                                    //       iconSize: 32,
                                                    //       color: Colors.blue[800],
                                                    //       icon: Icon(
                                                    //           Icons.contacts)),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        child: Icon(Icons
                                                            .sticky_note_2)),
                                                    Expanded(
                                                        flex: 4,
                                                        child: SizedBox(
                                                          height: 40,
                                                          child: TextField(
                                                            // controller:
                                                            // phoneController,
                                                            textAlign: TextAlign
                                                                .center,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom: 0,
                                                                      right: 0,
                                                                      left: 5,
                                                                      top: 0),
                                                              hintText:
                                                                  'Mobile Number',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          DateTime? dateTime =
                                                              await showOmniDateTimePicker(
                                                            context: context,
                                                            primaryColor:
                                                                Colors.cyan,
                                                            backgroundColor:
                                                                Colors.blue,
                                                            calendarTextColor:
                                                                Colors.white,
                                                            tabTextColor:
                                                                Colors.white,
                                                            unselectedTabBackgroundColor:
                                                                Colors
                                                                    .grey[700],
                                                            buttonTextColor:
                                                                Colors.white,
                                                            timeSpinnerTextStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white70,
                                                                    fontSize:
                                                                        18),
                                                            timeSpinnerHighlightedTextStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24),
                                                            is24HourMode: false,
                                                            isShowSeconds:
                                                                false,
                                                            startInitialDate:
                                                                date,
                                                            startFirstDate: DateTime(
                                                                    2020)
                                                                .subtract(
                                                                    const Duration(
                                                                        days:
                                                                            3652)),
                                                            startLastDate:
                                                                DateTime.now()
                                                                    .add(
                                                              const Duration(
                                                                  days: 3652),
                                                            ),
                                                            borderRadius:
                                                                const Radius
                                                                    .circular(16),
                                                          );
                                                          setState(() {
                                                            dateTime != null
                                                                ? date =
                                                                    dateTime
                                                                : date =
                                                                    DateTime
                                                                        .now();
                                                          });

                                                          // print(
                                                          //     DateFormat('EEEE').format(dateTime!).toString());
                                                          // // print(weeks['Saturday']);
                                                          // print(weeks[
                                                          //     DateFormat('EEEE').format(dateTime).toString()]);
                                                          // weeks.forEach((e) => print(e[DateFormat('EEEE')
                                                          //     .format(dateTime!)
                                                          //     .toString()]));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              //create boxdecoration
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    width: 2.0,
                                                                    style: BorderStyle
                                                                        .solid),
                                                              ),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Text(
                                                                dateFormat
                                                                    .format(
                                                                        date),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            const Icon(
                                                              Icons.edit,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(DateFormat.jm()
                                                                .format(date)
                                                                .toString()),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            const Icon(
                                                              Icons.edit,
                                                              size: 18,
                                                            ),
                                                          ],
                                                        )),
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        onPressed: () {},
                                                        iconSize: 20,
                                                        color:
                                                            Colors.green[800],
                                                        icon: Icon(
                                                            Icons.check_box),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            icon: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                Text(
                                  "Receive (in)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                )
                              ],
                            )),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Total Balanced",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Container(
                        height: 40, width: 95,
                        decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 8, 95, 11),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        // margin: const EdgeInsets.only(left: 5, right: 10),
                        child: IconButton(
                            onPressed: () {},
                            icon: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "999999",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.green[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            )),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Dr. 4444",
                      style: TextStyle(
                          color: Color.fromARGB(255, 234, 31, 27),
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Container(
                        height: 40, width: 95,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 234, 31, 27),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        // margin: const EdgeInsets.only(left: 5, right: 10),
                        child: IconButton(
                            onPressed: () {},
                            icon: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Give (Out)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                                Icon(
                                  Icons.upload_sharp,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                )
              ],
            )),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Text(
                                "d",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              backgroundColor: Color(
                                      (math.Random().nextDouble() * 0xFFFFFF)
                                          .toInt())
                                  .withOpacity(1.0),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "data['name']",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  "Cr. 0",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Spacer(flex: 1),

                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              // iconSize: 15,
                              icon: const Icon(Icons.filter_alt),
                              padding: EdgeInsets.all(0),
                            ),
                            IconButton(
                              onPressed: () {},
                              // iconSize: 15,
                              icon: Icon(Icons.menu),
                              padding: EdgeInsets.all(0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                getSenderView(
                    ChatBubbleClipper5(type: BubbleType.sendBubble), context),
                getReceiverView(
                    ChatBubbleClipper5(type: BubbleType.receiverBubble),
                    context),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
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
