import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:studentz_link/screens/HomeScreen/Application_Creation/application_screen.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/document_upload_page_.dart';
import 'package:studentz_link/screens/HomeScreen/CommissionScreen/commissionscreenbody.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/college.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/course.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/notification.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen/taskpage.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/task_added_byme1_show.dart';
import 'package:studentz_link/screens/HomeScreen/main_activity.dart';
import 'package:studentz_link/screens/StartScreen/mobile_auth.dart';
import 'package:studentz_link/screens/StartScreen/otp_page.dart';
import 'package:studentz_link/screens/StartScreen/push_notification.dart';
import 'package:studentz_link/utils/styles.dart';
import 'dart:io';

import 'screens/HomeScreen/HomeScreen_widgets/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

//push notification.....
Widget _defaultScreen = PushNotification();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!);
        },
        debugShowCheckedModeBanner: false,
        title: 'Studentz_link',
        theme: StudentLinkTheme().studentLinkTheme(),
        home: Scaffold(backgroundColor: Colors.white, body: _defaultScreen),
        routes: <String, WidgetBuilder>{
          '/loginPage': (BuildContext context) => MobileAuth(),
          '/otpverificationpage': (BuildContext context) => OTPVerification1(),
          '/mainactivity': (BuildContext context) => MainAcitivty(
                choosedFragment: 0,
              ),
          '/profileview': (BuildContext context) => Profile(),
          '/collegelist': (BuildContext context) => CollegeList(),
          '/courselist': (BuildContext context) => Courselist(),
          '/notification': (BuildContext context) => NotificationPage(),
          '/applicationcreationform': (BuildContext context) =>
              ApplicationCreationForm(),
          '/Docuploadandsubmitform': (BuildContext context) =>
              DocumentUploadForm(
                applicationid: 0,
              ),
          '/taskaddedbymeshowdata': (BuildContext context) => TaskAddedByMeShow(
                taskid: '',
              ),
          '/commissionscreen': (BuildContext context) => CommissionScreenbody()
        });
  }
}
