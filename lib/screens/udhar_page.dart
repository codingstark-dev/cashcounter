import 'package:cashcounter/provider/firestore_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class UdharPage extends ConsumerStatefulWidget {
  const UdharPage({Key? key, this.data, required this.currentUid})
      : super(key: key);
  final dynamic data;
  final String? currentUid;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UdharPageState();

  // @override
  // State<UdharPage> createState() => _UdharPageState();
}

class _UdharPageState extends ConsumerState<UdharPage> {
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  NumberFormat numberFormat = NumberFormat.decimalPattern('hi');

  late DateTime date = DateTime.now();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  num sum = 0;
  num cr = 0;
  num dr = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firestore
        .collection("users")
        .doc(_auth.currentUser?.uid)
        .collection("udhar")
        .doc(widget.currentUid)
        .collection("creditanddebit")
        .where('date',
            isLessThanOrEqualTo: DateTime.now().add(Duration(days: 20)))
        .snapshots()
        .listen((event) async {
      sum = 0;
      cr = 0;
      dr = 0;
      for (var element in event.docs) {
        if (mounted) {
          if (element.data()['type'] == 'credit') {
            setState(() {
              cr += element.data()['amount'];
            });
          } else if (element.data()['type'] == 'debit') {
            setState(() {
              dr += element.data()['amount'];
            });
          }
          setState(() {
            sum += element.data()['amount'];
          });
        }
      }
      if (await ref
          .read(databaseProvider)
          .checkDrCrBalance(widget.currentUid, cr, dr)) {
        _firestore
            .collection("users")
            .doc(_auth.currentUser?.uid)
            .collection("udhar")
            .doc(widget.currentUid)
            .update({
          "credit": cr,
          "debit": dr,
          "closebalance": sum,
        });
      }
      // print(await ref
      //     .read(databaseProvider)
      //     .checkDrCrBalance(widget.currentUid, cr, dr));
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(databaseProvider);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(100, 50),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          widget.data['name'].substring(0, 1),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        backgroundColor: Color(
                                (math.Random().nextDouble() * 0xFFFFFF).toInt())
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
                            widget.data['name'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            widget.data['number'],
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
        ),
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
                    Text(
                      "Cr. ₹${numberFormat.format(cr)}",
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
                            onPressed: () async {
                              await creditndDebitDialog(context, database,
                                  "Credit Receive", false, "credit");
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
                                  "₹${numberFormat.format(sum)}",
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
                    Text(
                      "Dr. ₹${numberFormat.format(dr)}",
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
                            onPressed: () async {
                              await creditndDebitDialog(context, database,
                                  "Credit Receive", true, "debit");
                            },
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
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: database.creditndDebita(widget.currentUid),
              builder: (context, snapshot) {
                //create loading spinner if data is not loaded
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "Entry Not Found..! \n\nFirst, Do Any Entry",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  );
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 500));
                  } else {
                    // ignore: avoid_returning_null_for_void
                    setState(() => null);
                  }
                });
                //sum all the credit and debit amount
                // num sum1 = 0;
                // snapshot.data!.docs.forEach((element) {
                //   sum1 += element.data()["amount"];
                // });

                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var maindata = snapshot.data!.docs[index].data();
                        database.sum = 0;
                        database.sum += maindata["amount"];
                        if (maindata['type'] == 'credit') {
                          return getReceiverView(
                              ChatBubbleClipper5(type: BubbleType.sendBubble),
                              context,
                              maindata['amount'],
                              maindata['remark'],
                              maindata['closebalance'],
                              maindata['date'].toDate());
                        } else if (maindata['type'] == 'debit') {
                          return getSenderView(
                              ChatBubbleClipper5(
                                  type: BubbleType.receiverBubble),
                              context,
                              maindata['amount'],
                              maindata['remark'],
                              maindata['closebalance'],
                              maindata['date'].toDate());
                        }
                        return Text("No Data");
                      },
                    ),
                  ),
                );
              }),
        ));
  }

  creditndDebitDialog(BuildContext context, Database database, String text,
      bool minus, String type) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                    void Function(void Function()) setState) =>
                AlertDialog(
              title: Center(child: Text(text)),
              content: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(child: Icon(Icons.payments)),
                          Expanded(
                              flex: 4,
                              child: SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: amountController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]"))
                                  ],

                                  keyboardType: TextInputType.number,
                                  // controller:
                                  //     nameController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.currency_rupee,
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 10,
                                      minHeight: 25,
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        bottom: 0, right: 0, left: 5, top: 0),
                                    hintText: 'Enter Amount',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Icon(Icons.sticky_note_2)),
                          Expanded(
                              flex: 4,
                              child: SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: remarkController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        bottom: 0, right: 0, left: 5, top: 0),
                                    hintText: 'Remark (अधिक माहिती)',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
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
                                  primaryColor: Colors.cyan,
                                  backgroundColor: Colors.blue,
                                  calendarTextColor: Colors.white,
                                  tabTextColor: Colors.white,
                                  unselectedTabBackgroundColor:
                                      Colors.grey[700],
                                  buttonTextColor: Colors.white,
                                  timeSpinnerTextStyle: const TextStyle(
                                      color: Colors.white70, fontSize: 18),
                                  timeSpinnerHighlightedTextStyle:
                                      const TextStyle(
                                          color: Colors.white, fontSize: 24),
                                  is24HourMode: false,
                                  isShowSeconds: false,
                                  startInitialDate: date,
                                  startFirstDate: DateTime(2020)
                                      .subtract(const Duration(days: 3652)),
                                  startLastDate: DateTime.now().add(
                                    const Duration(days: 3652),
                                  ),
                                  borderRadius: const Radius.circular(16),
                                );
                                setState(() {
                                  dateTime != null
                                      ? date = dateTime
                                      : date = DateTime.now();
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
                                  Text(
                                    dateFormat.format(date),
                                    style: const TextStyle(color: Colors.blue),
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
                                  Text(DateFormat.jm().format(date).toString()),
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
                              padding: EdgeInsets.all(0),
                              onPressed: () async {
                                await database
                                    .createCreditDebitAccount(
                                        number: widget.data['number'],
                                        name: widget.data['name'],
                                        currentUid: widget.currentUid,
                                        dateTime: date,
                                        closebalance: minus
                                            ? -int.parse(
                                                    amountController.text) +
                                                int.parse(sum.toString())
                                            : int.parse(amountController.text) +
                                                int.parse(sum.toString()),
                                        amount: minus
                                            ? -int.parse(amountController.text)
                                            : int.parse(amountController.text),
                                        remark: remarkController.text,
                                        type: type)
                                    .whenComplete(() {
                                  amountController.clear();
                                  remarkController.clear();
                                  Navigator.pop(context);
                                });
                              },
                              iconSize: 30,
                              color: Colors.green[800],
                              icon: Icon(Icons.check_box),
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
  }

  getTitleText(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      );

  getSenderView(CustomClipper clipper, BuildContext context, int Amount,
          String remark, int closingBalance, DateTime date) =>
      ChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 10),
        backGroundColor: Colors.grey[50],
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          // width: 100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (remark != "")
                      ? Text(remark, style: TextStyle(color: Colors.black))
                      : Container(),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "₹${numberFormat.format(Amount)}",
                    style: TextStyle(color: Colors.red[900]),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Cls BL: ₹${numberFormat.format(closingBalance)}",
                    style: TextStyle(color: Colors.green, fontSize: 10),
                  ),
                  Row(
                    children: [
                      Text(
                        dateFormat.format(date),
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat.jm().format(date).toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                constraints: BoxConstraints(maxWidth: 20),
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                ),
                padding: EdgeInsets.all(0),
              )
            ],
          ),
        ),
      );

  getReceiverView(CustomClipper clipper, BuildContext context, int Amount,
          String remark, int closingBalance, DateTime date) =>
      ChatBubble(
        clipper: clipper,
        backGroundColor: Color(0xffE7E7ED),
        margin: EdgeInsets.only(top: 10),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (remark != "")
                      ? Text(remark, style: TextStyle(color: Colors.black))
                      : Container(),
                  Text(
                    "₹${numberFormat.format(Amount)}",
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Cls BL: ₹${numberFormat.format(closingBalance)}",
                    style: TextStyle(color: Colors.green, fontSize: 10),
                  ),
                  Row(
                    children: [
                      Text(
                        dateFormat.format(date),
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat.jm().format(date).toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                constraints: BoxConstraints(maxWidth: 20),
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                ),
                padding: EdgeInsets.all(0),
              )
            ],
          ),
        ),
      );
}
