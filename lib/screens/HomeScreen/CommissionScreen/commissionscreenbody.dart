import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studentz_link/screens/HomeScreen/CommissionScreen/commission_receive_page.dart';
import 'package:studentz_link/screens/HomeScreen/CommissionScreen/commission_request_page.dart';
import 'package:studentz_link/utils/styles.dart';

class CommissionScreenbody extends StatefulWidget {
  const CommissionScreenbody({Key? key}) : super(key: key);

  @override
  State<CommissionScreenbody> createState() => _CommissionScreenbodyState();
}

class _CommissionScreenbodyState extends State<CommissionScreenbody> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            //tab baraddtask
            bottom: TabBar(
              indicator: ContainerTabIndicator(
                widthFraction: 0.4,
                width: 40,
                height: 5,
                color: StudentLinkTheme().primary1,
                padding: const EdgeInsets.only(top: 20),
                radius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              tabs: [
                Tab(
                  child: Text(
                    'Commission Requested',
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: .5,
                        fontWeight: FontWeight.bold,
                        fontSize: StudentLinkTheme().h3),
                  ),
                ),
                Tab(
                  child: Text(
                    'Commission Received',
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: .5,
                        fontWeight: FontWeight.bold,
                        fontSize: StudentLinkTheme().h3),
                  ),
                ),
              ],
            ),

            backgroundColor: Colors.white,
            elevation: 0,

            //title
            title: Text(
              'Commissions Report',
              style: TextStyle(
                  color: Colors.black,
                  letterSpacing: .5,
                  fontSize: StudentLinkTheme().h2,
                  fontWeight: FontWeight.bold),
            ),

            leading: IconButton(
              iconSize: 20,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
            ),
          ),
          body: TabBarView(
            children: [
              //item
              CommissionRequestPage(),
              // //item
              CommissionReceivePage()
            ],
          )),
    );
  }
}
