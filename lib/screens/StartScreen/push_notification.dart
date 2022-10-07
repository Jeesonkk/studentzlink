import 'dart:io';
import 'package:ezanimation/ezanimation.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentz_link/REST/rest_api.dart';

import 'package:studentz_link/utils/styles.dart';

class PushNotification extends StatefulWidget {
  @override
  _PushNotificationState createState() => _PushNotificationState();
}

Widget _defaultScreen = PushNotification();

class _PushNotificationState extends State<PushNotification> {
  var accessToken;
  EzAnimation animation = EzAnimation(10.0, 100.0, Duration(seconds: 2),
      reverseCurve: Curves.bounceInOut);
  //PushNotification......................

  @override
  void initState() {
    animation.start();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      }
    });

    super.initState();
  }

  //RequestIOS Permission

  //

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: StudentLinkTheme().primary1,
    ));
    Future.delayed(Duration(seconds: 2)).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString('accessToken');

      print('accessToken$accessToken');
      if (accessToken == null) {
        Navigator.pushReplacementNamed(context, '/loginPage');
      } else {
        Navigator.pushReplacementNamed(context, '/mainactivity');
      }
    });
    return AnimatedBuilder(
        animation: animation,
        builder: (context, snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: StudentLinkTheme().primary1,
                image: DecorationImage(
                    image: AssetImage("assets/images/splash(2).png"))),
          );
        });
  }
}
