import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/StartScreen/firebase_stream.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/student_links_strings.dart';
import 'package:studentz_link/utils/styles.dart';

class OTPVerification1 extends StatefulWidget {
  const OTPVerification1({Key? key}) : super(key: key);

  @override
  State<OTPVerification1> createState() => _OTPVerification1State();
}

class _OTPVerification1State extends State<OTPVerification1> {
  final globalKey = GlobalKey<ScaffoldState>();
  String pin = '';
  Firebasestream firestream = Firebasestream();
  //Firebasetoken.....................
  var firebasetoken;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future getFCM() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) async {
        print('pushnotification_get_authorized...........${value.toString()}');
        //Provider.of<GetDataProvider>(context, listen: false).updateFCM(value);
        GlobalData.firebasetoken = value.toString();

        //firestream.getfirebasetoken(firebasetoken: value.toString());
        SharedPreferences prefsuser = await SharedPreferences.getInstance();
        prefsuser.setString('push_noti_token', value.toString());
        setState(() {
          firebasetoken = value.toString();
        });
      });
      return firebasetoken;
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) async {
        print('pushnotificationget_provisional..........${value.toString()}');

        //firestream.getfirebasetoken(firebasetoken: value.toString());
        GlobalData.firebasetoken = value.toString();
        SharedPreferences prefsuser = await SharedPreferences.getInstance();
        prefsuser.setString('push_noti_token', value.toString());
        setState(() {
          firebasetoken = value.toString();
        });
      });
      return firebasetoken;
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    getFCM();
    super.initState();
    print(firebasetoken);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: globalKey,
        body: ProgressHUD(
            child: Builder(
          builder: (context) => SafeArea(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Image.asset(
                  'assets/images/startscreen/login.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: width,
                  child: Center(
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: .5,
                          fontSize: StudentLinkTheme().h1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                //contents
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'Enter OTP sent to +91${StudentLinkStrings.loginnumber}',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: StudentLinkTheme().disText,
                      letterSpacing: .5,
                      fontSize: StudentLinkTheme().h3,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                    width: width,
                    child: OtpPinField(
                      otpPinFieldInputType: OtpPinFieldInputType
                          .none, // OtpPinFieldInputType.none || OtpPinFieldInputType.password || OtpPinFieldInputType.custom
                      // otpPinInputCustom:
                      //     "\$", // A String which you want to show when you use 'inputType: OtpPinFieldInputType.custom, '
                      onSubmit: (text) {
                        print('Entered pin is $text');
                        pin = text; // return the entered pin
                      },

                      // to decorate your Otp_Pin_Field
                      otpPinFieldStyle: OtpPinFieldStyle(
                        defaultFieldBorderColor: Colors
                            .grey, // border color for inactive/unfocused Otp_Pin_Field
                        activeFieldBorderColor: StudentLinkTheme()
                            .primary1, // border color for active/focused Otp_Pin_Field
                        defaultFieldBackgroundColor: Colors
                            .white, // Background Color for inactive/unfocused Otp_Pin_Field
                        activeFieldBackgroundColor: Colors
                            .white, // Background Color for active/focused Otp_Pin_Field
                      ),
                      maxLength: 4, // no of pin field
                      highlightBorder:
                          true, // want to highlight focused/active Otp_Pin_Field
                      fieldWidth: 50, //to give width to your Otp_Pin_Field
                      fieldHeight: 50, //to give height to your Otp_Pin_Field
                      keyboardType:
                          TextInputType.number, // type of keyboard you want
                      autoFocus: false, //want to open keyboard or not

                      // predefine decorate of pinField use  OtpPinFieldDecoration.defaultPinBoxDecoration||OtpPinFieldDecoration.underlinedPinBoxDecoration||OtpPinFieldDecoration.roundedPinBoxDecoration
                      //use OtpPinFieldDecoration.custom  (by using this you can make Otp_Pin_Field according to yourself like you can give fieldBorderRadius,fieldBorderWidth and etc things)
                      otpPinFieldDecoration:
                          OtpPinFieldDecoration.defaultPinBoxDecoration,
                    )),
                Align(
                    alignment: AlignmentDirectional(0.7, 0.1),
                    child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: GlobalWidget().submitButton(
                            buttontext: 'Submit',
                            onPressed: () {
                              if (pin.isNotEmpty) {
                                final progress = ProgressHUD.of(context);
                                progress!.showWithText('Submiting...');
                                var loging_parm_otp = Uri(
                                  scheme: 'https',
                                  host: Apis.superlink,
                                  path: Apis.baselink + 'login',
                                  queryParameters: {
                                    'password': pin,
                                    'client_id': '2',
                                    'client_secret':
                                        'GXi6ZRVoeCySdN2D5DuBWS5pWLG2Wx46UBQBDeKu',
                                    'phone': StudentLinkStrings.loginnumber,
                                    'firebase_token': GlobalData.firebasetoken
                                  },
                                );
                                RestApi()
                                    .Post(loging_parm_otp)
                                    .then((onValue) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      'accessToken', onValue['access_token']);
                                  GlobalWidget().showSnackBar(globalKey,
                                      'Otp Verification Successfully done ');

                                  Navigator.pushReplacementNamed(
                                      context, '/mainactivity');
                                  progress.dismiss();
                                }).catchError((onError) {
                                  progress.dismiss();

                                  GlobalWidget().showSnackBar(
                                      globalKey, onError.toString());
                                  pin = '';
                                });
                              } else if (pin.length < 4) {
                                GlobalWidget().showSnackBar(
                                    globalKey, 'Enter 4 Digit Otp');
                              }
                            })))
              ],
            ),
          )),
        )));
  }
}
