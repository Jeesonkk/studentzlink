import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/resources/repository.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/profile.dart';
import 'package:studentz_link/services/navigation_service.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';
import 'package:http/http.dart' as http;
// import 'package:students_app_og/API/RestApi.dart';
// import 'package:students_app_og/Models/profile_model.dart';

// import 'package:students_app_og/screen/commissions/commission.dart';

// import 'package:students_app_og/screen/profile.dart';
// import 'package:students_app_og/screen/seat.dart';

// import 'package:students_app_og/splash_reg/mobile_auth.dart';
// import 'package:students_app_og/myTheme/MyTheme.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final globalKey = GlobalKey<ScaffoldState>();
  String id = '';

  String profilephoto = '';
  String name = '';

  int user_id = 0;

  String token = '';

  String token_logut = '';
  Widget spacer(double heightreq) {
    return SizedBox(height: heightreq);
  }

//Update FCM to null
  Update_FCMlogout({userid}) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    token = prefs1.getString('accessToken')!;
    var postUri = Uri.parse(
        "https://admission.studentzlink.com/api/v1/saleteam/firebase-token");
    var request = http.MultipartRequest("POST", postUri);
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    request.fields['id'] = userid.toString();
    request.fields['token'] = 'null';
    var response = await request.send();
    var onData = await response.stream.transform(utf8.decoder).first;
    List ononData = [];
    ononData.add(onData);
    print(ononData);
    if (response.statusCode == 200) {
      print('fcm_update...${response.statusCode}');
    } else {
      print('fcm_not_update...${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Repository().fetchProfile().then((value) {
      print(value);
      setState(() {
        profilephoto = value.avatar;
        name = value.name;
        id = value.roles[0];
        user_id = value.id;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: globalKey,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: ListTileTheme(
            textColor: Colors.black,
            iconColor: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                spacer(5),
                SafeArea(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: ShapeDecoration(
                      color: StudentLinkTheme().primary1,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/home_screen/conection new.png')),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x1FA0A0A0),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ],
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                              width: 1, color: Color(0xFFE4E4E4))),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/profileview');
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 65.0,
                              height: 65.0,
                              margin: const EdgeInsets.only(
                                left: 20,
                                top: 50.0,
                                bottom: 5.0,
                              ),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: profilephoto,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                  strokeWidth: 1.2,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 30,
                              top: 5.0,
                              bottom: 5.0,
                            ),
                            child: Text(
                              name.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontWeight: FontWeight.bold,
                                fontSize: StudentLinkTheme().h3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                spacer(5),
                GlobalWidget().DecorativeContainer(
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/collegelist');
                    },
                    leading: const ImageIcon(
                      AssetImage('assets/images/home_screen/std.png'),
                      size: 20,
                    ),
                    title: const Text(
                      'Seat Availability',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                spacer(5),
                if (id != 'partner')
                  Container()
                else
                  GlobalWidget().DecorativeContainer(
                    ListTile(
                      onTap: () {
                        // Routing(To: CommissionPage(), context: context);
                        Navigator.pushNamed(context, '/commissionscreen');
                      },
                      leading: const ImageIcon(
                        AssetImage('assets/images/home_screen/icons/commi.png'),
                        size: 20,
                      ),
                      title: const Text(
                        'Commission',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                // spacer(5),
                // GlobalWidget().DecorativeContainer(
                //   ListTile(
                //     onTap: () {},
                //     leading: ImageIcon(
                //       AssetImage('assets/images/home_screen/icons/support.png'),
                //       size: 20,
                //     ),
                //     title: Text(
                //       'Support',
                //       style: TextStyle(
                //           color: Colors.black, fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                // spacer(5),
                // GlobalWidget().DecorativeContainer(
                //   ListTile(
                //     onTap: () {},
                //     leading: ImageIcon(
                //       AssetImage('assets/images/home_screen/icons/about.png'),
                //       size: 20,
                //     ),
                //     title: Text(
                //       'About',
                //       style: TextStyle(
                //           color: Colors.black, fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                // spacer(5),
                // GlobalWidget().DecorativeContainer(
                //   ListTile(
                //     onTap: () {},
                //     leading: ImageIcon(
                //       AssetImage('assets/images/home_screen/icons/contact.png'),
                //       size: 20,
                //     ),
                //     title: Text(
                //       'Contact',
                //       style: TextStyle(
                //           color: Colors.black, fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                spacer(5),
                GlobalWidget().DecorativeContainer(
                  ListTile(
                    onTap: () {
                      Update_FCMlogout(userid: user_id.toString());
                      var log_out = Uri(
                        scheme: 'https',
                        host: Apis.superlink,
                        path: Apis.baselink + Apis.Logout_Url,
                      );
                      RestApi().Post(log_out).then((value) async {
                        GlobalWidget()
                            .showSnackBar(globalKey, value['response']['msg']);

                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.clear();

                        Navigator.pushReplacementNamed(context, '/loginPage');
                      }).catchError((onError) {
                        GlobalWidget()
                            .showSnackBar(globalKey, onError.toString());
                      });
                    },
                    leading: ImageIcon(
                      AssetImage('assets/images/home_screen/icons/logout.png'),
                      size: 20,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Center(
                        child: Text(
                      'Terms of Service | Privacy Policy',
                      style: TextStyle(color: Colors.grey),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
