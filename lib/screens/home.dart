import 'package:cashcounter/screens/calculator.dart';
import 'package:cashcounter/screens/cashcount.dart';
import 'package:cashcounter/screens/creditdebit.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size(100, 50),
          child: AppBar(
            // title: const Text('Cash Counter'),
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
