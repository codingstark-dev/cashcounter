import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class Credit extends StatefulWidget {
  Credit({Key? key}) : super(key: key);

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  const Text(
                    "Total: 4444",
                    style: TextStyle(
                        color: Color.fromARGB(255, 8, 95, 11),
                        fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                    child:
                        Divider(height: 0, thickness: 1, color: Colors.black),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          "cr2232",
                          style: TextStyle(
                              color: Color.fromARGB(255, 8, 95, 11),
                              fontWeight: FontWeight.bold),
                        ),
                        VerticalDivider(color: Colors.black),
                        Text(
                          "dr2232",
                          style: TextStyle(
                              color: Color.fromARGB(255, 236, 30, 30),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            //create rounded button with icon
            Expanded(
              flex: 2,
              child: Container(
                // width: 100,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 8, 95, 11),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                margin: const EdgeInsets.only(left: 5, right: 10),
                child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:
                                  Center(child: const Text("Add New Person")),
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
                                          Expanded(child: Icon(Icons.person)),
                                          Expanded(
                                              flex: 4,
                                              child: SizedBox(
                                                height: 40,
                                                child: TextField(
                                                  controller: nameController,
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 0,
                                                            right: 0,
                                                            left: 5,
                                                            top: 0),
                                                    hintText:
                                                        'Enter Person Name',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                                onPressed: () async {
                                                  final PhoneContact contact =
                                                      await FlutterContactPicker
                                                          .pickPhoneContact();
                                                  print(contact
                                                      .phoneNumber!.number);
                                                  setState(() {
                                                    nameController.text =
                                                        contact.fullName
                                                            .toString();
                                                    phoneController.text =
                                                        contact
                                                            .phoneNumber!.number
                                                            .toString();
                                                  });
                                                },
                                                iconSize: 32,
                                                color: Colors.blue[800],
                                                icon: Icon(Icons.contacts)),
                                          ),
                                        ],
                                      ),
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
                                              child: Icon(
                                                  Icons.local_phone_sharp)),
                                          Expanded(
                                              flex: 4,
                                              child: SizedBox(
                                                height: 40,
                                                child: TextField(
                                                  controller: phoneController,
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 0,
                                                            right: 0,
                                                            left: 5,
                                                            top: 0),
                                                    hintText: 'Mobile Number',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              onPressed: () {},
                                              iconSize: 32,
                                              color: Colors.green[800],
                                              icon: Icon(Icons.check_box),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Edit"),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  child: const Text("Delete"),
                                  onPressed: () {},
                                ),
                              ],
                            );
                          });
                    },
                    icon: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.person_add, color: Colors.white),
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          "ADD PERSON",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // create search bar
          Container(
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.filter_alt)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.picture_as_pdf)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              ],
            ),
          ),
          Container(
            child: const Text("Something went wrong, please try again"),
          ),
          //create listtile and circular alphabets for each person
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: const Text(
                      "A",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    backgroundColor:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                  ),
                  title: const Text(
                    "Person Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  subtitle: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Cr. 0",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              const Text(
                                "Dr. 00",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.grey,
                        ),
                        Column(
                          children: [
                            const Text(
                              "26/02/2020",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            const Text(
                              "04:00 PM",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        const VerticalDivider(color: Colors.grey),
                      ],
                    ),
                  ),
                  trailing: Column(
                    children: [
                      Expanded(
                        child: IconButton(
                            icon: const Icon(Icons.phone_forwarded),
                            iconSize: 20,
                            color: Colors.green,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Options"),
                                      content: const Text("Select an option"),
                                      actions: [
                                        TextButton(
                                          child: const Text("Edit"),
                                          onPressed: () {},
                                        ),
                                        TextButton(
                                          child: const Text("Delete"),
                                          onPressed: () {},
                                        ),
                                      ],
                                    );
                                  });
                            }),
                      ),
                      Spacer(),
                      Expanded(child: const Text("0"))
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
