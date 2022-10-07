import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/StartScreen/otp_page.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/student_links_strings.dart';

import '../../utils/styles.dart';

class MobileAuth extends StatelessWidget {
  var value;

  MobileAuth({Key? key}) : super(key: key);
//body...
  final globalKey = GlobalKey<ScaffoldState>();
  Color clr = StudentLinkTheme().primary1;
  TextEditingController mobilecontroller = TextEditingController();
  //loading..

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: globalKey,
        backgroundColor: Colors.white,
        body: ProgressHUD(
            child: Builder(
          builder: (context) => SafeArea(
              child: ListView(
            children: [
              Image.asset(
                'assets/images/startscreen/login.png',
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                fit: BoxFit.cover,
              ),
              Container(
                width: width,
                child: Center(
                  child: Text('LOGIN',
                      style: TextStyle(
                          fontFamily: 'Century Gothic',
                          color: Colors.black,
                          letterSpacing: .5,
                          fontSize: StudentLinkTheme().h1,
                          fontWeight: FontWeight.bold)),
                ),
              ),

              SizedBox(
                height: 5,
              ),
              //contents
              Container(
                width: width,
                child: Center(
                  child: Text(
                      'We will send you an One Time Password on this number',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Century Gothic',
                        color: StudentLinkTheme().disText,
                        fontWeight: FontWeight.values[4],
                        letterSpacing: .5,
                        fontSize: StudentLinkTheme().h4,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GlobalWidget().studentlint_textFormfield(
                  mobile_number_controller: mobilecontroller,
                  labetext: 'Mobile Number',
                  hinttext: "+ 91",
                  clr: clr,
                  onTap: () {
                    clr = StudentLinkTheme().primary2;
                  },
                  onSubmitted: (v) {}),
              Align(
                  alignment: AlignmentDirectional(0.7, 0.1),
                  child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: GlobalWidget().submitButton(
                          buttontext: 'GET OTP',
                          onPressed: () {
                            if (mobilecontroller.text.length == 10) {
                              final progress = ProgressHUD.of(context);
                              progress!.showWithText('Loading...');
                              StudentLinkStrings.loginnumber =
                                  mobilecontroller.text;
                              var loging_parm = Uri(
                                scheme: 'https',
                                host: Apis.superlink,
                                path: Apis.baselink + 'loginotp',
                                queryParameters: {
                                  'phone': mobilecontroller.text
                                },
                              );
                              RestApi().Post(loging_parm).then((onValue) async {
                                GlobalWidget().showSnackBar(
                                    globalKey, onValue['response']['msg']);

                                mobilecontroller.text = '';
                                Navigator.pushReplacementNamed(
                                    context, '/otpverificationpage');
                              }).catchError((onError) {
                                progress.dismiss();
                                GlobalWidget().showSnackBar(
                                    globalKey, onError.toString());
                                mobilecontroller.text = '';
                              });
                            } else if (mobilecontroller.text.isEmpty) {
                              GlobalWidget().showSnackBar(
                                  globalKey, 'Enter  Mobile Number');
                            } else {
                              GlobalWidget().showSnackBar(
                                  globalKey, 'Enter Correct  Mobile Number');
                            }
                          })))
            ],
          )),
        )));
  }
}
