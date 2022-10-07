import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studentz_link/Models/dashboard.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/resources/repository.dart';

import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/customdrawer/drawerWodget.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/customdrawer/flutter_advanced_drawer.dart';
import 'package:studentz_link/screens/HomeScreen/HomeSreen_screens/body_widget.dart';
import 'package:studentz_link/screens/HomeScreen/HomeSreen_screens/home_body_datastream.dart';
import 'package:studentz_link/screens/StartScreen/firebase_stream.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';

import 'package:studentz_link/utils/styles.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
  final _advancedDrawerController = AdvancedDrawerController();

  DashBoardModel dashboardmodel = DashBoardModel(
      status: '',
      response: DashBoardResponse(
          admission: 0,
          earnings: '',
          totalApplications: 0,
          applicationPending: 0,
          applicationCancelled: 0,
          applicationApproved: 0,
          tasks: 0,
          fullyPaidStudents: 0,
          collegeAdmission: [],
          notifications: 0),
      code: 0);
  DashboardData dasboardstream = DashboardData();

  String id = '';

  String user_id = '';
  // Firebasestream firestream = Firebasestream();
  // //Firebasetoken.....................
  // var firebasetoken;
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // Future getFCM() async {
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     messaging = FirebaseMessaging.instance;
  //     messaging.getToken().then((value) async {
  //       print('pushnotification_get_authorized...........${value.toString()}');
  //       //Provider.of<GetDataProvider>(context, listen: false).updateFCM(value);
  //       GlobalData.firebasetoken = value.toString();

  //       //firestream.getfirebasetoken(firebasetoken: value.toString());
  //       SharedPreferences prefsuser = await SharedPreferences.getInstance();
  //       prefsuser.setString('push_noti_token', value.toString());
  //       setState(() {
  //         firebasetoken = value.toString();
  //       });
  //     });
  //     return firebasetoken;
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     messaging = FirebaseMessaging.instance;
  //     messaging.getToken().then((value) async {
  //       print('pushnotificationget_provisional..........${value.toString()}');

  //       //firestream.getfirebasetoken(firebasetoken: value.toString());
  //       GlobalData.firebasetoken = value.toString();
  //       SharedPreferences prefsuser = await SharedPreferences.getInstance();
  //       prefsuser.setString('push_noti_token', value.toString());
  //       setState(() {
  //         firebasetoken = value.toString();
  //       });
  //     });
  //     return firebasetoken;
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }

  // Update_FCM() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Repository().fetchProfile().then((value) {
  //     setState(() {
  //       id = value.roles[0];
  //     });
  //     //Update_FCM(userid: value.id.toString());

  //     print(value.id);
  //   });

  //   var push_noti_Token = prefs.getString('push_noti_token');
  //   var postUri = Uri.parse(
  //       "https://admission.studentzlink.com/api/v1/saleteam/firebase-token");
  //   var request = http.MultipartRequest("POST", postUri);
  //   request.headers.addAll({
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${prefs.getString('accessToken')}',
  //   });
  //   request.fields['id'] = id.toString();
  //   request.fields['token'] = GlobalData.firebasetoken.toString();
  //   var response = await request.send();
  //   var onData = await response.stream.transform(utf8.decoder).first;
  //   List ononData = [];
  //   ononData.add(onData);
  //   print(ononData);
  //   if (response.statusCode == 200) {
  //     print('fcm_update...${response.statusCode}');
  //   } else {
  //     print('fcm_not_update...${response.statusCode}');
  //   }
  // }

  @override
  void initState() {
    dasboardstream = DashboardData();
    dasboardstream.getdashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnimationController controller = AnimationController(
      vsync: this,
    );
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 550) / 2;
    final double itemWidth = size.width / 2;

    return AdvancedDrawer(
      drawer: DrawerWidget(),
      controller: _advancedDrawerController,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      animationController: controller,
      animationCurve: Curves.easeInOut,
      backdropColor: StudentLinkTheme().secondarybg,
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image:
                    AssetImage('assets/images/home_screen/conection new.png'),
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: StudentLinkTheme().primary1,
            elevation: 0,
            leading: IconButton(
              color: Colors.white,
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            ),
            actions: [
              StreamBuilder(
                  stream: dasboardstream.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data is DashBoardModel) {
                        dashboardmodel = snapshot.data as DashBoardModel;
                      }
                    } else {
                      return Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.all(20),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.5,
                          ),
                        ),
                      );
                    }
                    return IconButton(
                        icon: Stack(
                          children: [
                            Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 30,
                            ),
                            Positioned(
                                right: 0,
                                top: 0,
                                child:
                                    dashboardmodel.response.notifications != 0
                                        ? CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 9,
                                            child: Text(
                                                dashboardmodel
                                                    .response.notifications
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10)),
                                          )
                                        : SizedBox())
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/notification');
                        });
                  })
            ],
            centerTitle: true,
            title: Container(
                height: 120,
                width: 120,
                child: Image.asset(
                  'assets/images/home_screen/logohome.png',
                  fit: BoxFit.contain,
                )),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(40.0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/home_screen/conection new.png'))),
                )),
          ),
          body: StreamBuilder(
              stream: dasboardstream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data is DashBoardModel) {
                    dashboardmodel = snapshot.data as DashBoardModel;
                  }
                } else {
                  return RefreshIndicator(
                      color: StudentLinkTheme().primary1,
                      onRefresh: () => dasboardstream.getdashboardData(),
                      child: Stack(
                        children: [
                          Container(
                            width: width,
                            child: CustomPaint(
                              painter: AppBarPainter(),
                              child: Container(height: 30),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: ListView(
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                DashboardWidgets().bodywidget(
                                    width: width,
                                    text1: "Total Applied",
                                    Applications1: 0,
                                    text2: "Task",
                                    application2: 0,
                                    primery: StudentLinkTheme().primary1,
                                    secondary: StudentLinkTheme().primary2),
                                id != 'sale-team'
                                    ? SizedBox(
                                        height: 3,
                                      )
                                    : Container(),
                                id != 'sale-team'
                                    ? DashboardWidgets().Singledrawwidget(
                                        width: width,
                                        text1: 'Earnings',
                                        Applications1: '0',
                                        primery: StudentLinkTheme().primary1,
                                        secondary: StudentLinkTheme().primary2)
                                    : Container(),
                                id != 'sale-team'
                                    ? SizedBox(
                                        height: 4,
                                      )
                                    : Container(),
                                DashboardWidgets().gridwidget(
                                    width: width,
                                    applicationApproved: '0',
                                    applicationCancelled: '0',
                                    applicationPending: '0',
                                    sfullyPaidStudents: '0')
                              ],
                            ),
                          ),
                        ],
                      ));
                }
                return RefreshIndicator(
                    color: StudentLinkTheme().primary1,
                    onRefresh: () => dasboardstream.getdashboardData(),
                    child: Stack(
                      children: [
                        Container(
                          width: width,
                          child: CustomPaint(
                            painter: AppBarPainter(),
                            child: Container(height: 30),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: ListView(
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              DashboardWidgets().bodywidget(
                                  width: width,
                                  text1: "Total Applied",
                                  Applications1: dashboardmodel
                                      .response.totalApplications
                                      .toString(),
                                  text2: "Task",
                                  application2:
                                      dashboardmodel.response.tasks.toString(),
                                  primery: StudentLinkTheme().primary1,
                                  secondary: StudentLinkTheme().primary2),
                              id != 'sale-team'
                                  ? SizedBox(
                                      height: 3,
                                    )
                                  : Container(),
                              id != 'sale-team'
                                  ? DashboardWidgets().Singledrawwidget(
                                      width: width,
                                      text1: 'Earnings',
                                      Applications1: dashboardmodel
                                          .response.earnings
                                          .toString(),
                                      primery: StudentLinkTheme().primary1,
                                      secondary: StudentLinkTheme().primary2)
                                  : Container(),
                              id != 'sale-team'
                                  ? SizedBox(
                                      height: 4,
                                    )
                                  : Container(),
                              GlobalWidget().DecorativeContainer(
                                DashboardWidgets().gridwidget(
                                    width: width,
                                    applicationApproved: dashboardmodel
                                        .response.applicationApproved
                                        .toString(),
                                    applicationCancelled: dashboardmodel
                                        .response.applicationCancelled
                                        .toString(),
                                    applicationPending: dashboardmodel
                                        .response.applicationPending
                                        .toString(),
                                    sfullyPaidStudents: dashboardmodel
                                        .response.fullyPaidStudents
                                        .toString()),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: width,
                                padding: EdgeInsets.all(8),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      StudentLinkTheme().primary1,
                                      StudentLinkTheme().primary2
                                    ],
                                    begin: FractionalOffset.bottomCenter,
                                    end: FractionalOffset.topCenter,
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x1FA0A0A0),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      side: BorderSide(
                                        width: 2.0,
                                      )),
                                ),
                                child: Text(
                                  'Colleges',
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: StudentLinkTheme().h2,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: StudentLinkTheme().primary2,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: dashboardmodel
                                        .response.collegeAdmission.length,
                                    itemBuilder: (context, i) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                dashboardmodel.response
                                                    .collegeAdmission[i].name,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: .5,
                                                    fontSize:
                                                        StudentLinkTheme().h4,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              Text(
                                                dashboardmodel
                                                    .response
                                                    .collegeAdmission[i]
                                                    .admissions
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: .5,
                                                    fontSize:
                                                        StudentLinkTheme().h3,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                        ),
                      ],
                    ));
              })),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
