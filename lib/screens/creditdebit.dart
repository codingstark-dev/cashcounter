import 'dart:ui';
import 'package:cashcounter/screens/udhar_page.dart';
import 'package:intl/intl.dart';

import 'package:cashcounter/provider/firestore_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class Credit extends ConsumerStatefulWidget {
  Credit({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreditState();
//
  // @override
  // State<Credit> createState() => CreditState();
}

class _CreditState extends ConsumerState<Credit> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    final database = ref.read(databaseProvider);
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
                                              onPressed: () {
                                                database
                                                    .createUdharAccount(
                                                  phoneController.text,
                                                  nameController.text,
                                                )
                                                    .whenComplete(() {
                                                  setState(() {
                                                    nameController.clear();
                                                    phoneController.clear();
                                                  });
                                                  Navigator.pop(context);
                                                });
                                              },
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
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: database.udharDetail,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  print(snapshot.data?.docs.length);
                  if (snapshot.data?.docs.length == 0) {
                    return const Center(
                      child: Text(
                        "Person Not Added..! \n\n First, Add Person",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> data =
                          snapshot.data!.docs[index].data();
                      print(data['name']);
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UdharPage(
                                        data: data,
                                      )));
                        },
                        leading: CircleAvatar(
                          child: Text(
                            data['name'][0].toUpperCase(),
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
                        title: Text(
                          data['name'],
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
                                  Text(
                                    dateFormat.format(data['date'].toDate()),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    DateFormat.jm()
                                        .format(data['date'].toDate())
                                        .toString(),
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
                                            content:
                                                const Text("Select an option"),
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
                  );
                }),
          ),
        ],
      ),
    );
  }
}
