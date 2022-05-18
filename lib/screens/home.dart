import 'package:cashcounter/screens/calculator.dart';
import 'package:cashcounter/screens/cashcount.dart';
import 'package:cashcounter/screens/creditdebit.dart';
import 'package:cashcounter/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthClass authClass = AuthClass();

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size(100, 100),
          child: AppBar(
            title: ElevatedButton(
                onPressed: () async {
                  await authClass.logout();
                  await Fluttertoast.showToast(msg: "Logged Out");
                },
                child: Text("Logout")),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Calculator',
                ),
                Tab(
                  text: 'Cash Count',
                ),
                Tab(
                  text: 'Credit-Debit',
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            // Expanded(
            //     child: DefaultTabController(
            //         length: 3,
            //         initialIndex: 0,
            //         child: Column(
            //           children: [
            //             const TabBar(
            //               tabs: [
            //                 Tab(
            //                   text: 'Calculator',
            //                 ),
            //                 Tab(
            //                   text: 'Cash Count',
            //                 ),
            //                 Tab(
            //                   text: 'Credit-Debit',
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ))),

            Expanded(
                child: TabBarView(children: [
              Calculator(),
              CashCounter(),
              Credit(),
            ]))
          ],
        ),
      ),
    );
  }
}
