import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/resources/repository.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class Profile extends StatefulWidget {
  Profile() : super();

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<Profile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String profilephoto = '';
  String name = '';
  String id = '';
  String email = '';
  String phone = '';

  String role = '';
  @override
  void initState() {
    // TODO: implement initState
    Repository().fetchProfile().then((value) {
      setState(() {
        profilephoto = value.avatar;
        name = value.name;
        id = value.roles[0];
        email = value.email;
        phone = value.phone;
        role = value.roles[0];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.all(7),
            child: GlobalWidget().DecorativeContainer(
              IconButton(
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
          ),
          automaticallyImplyLeading: false,
          title: Text(
            'My Profile',
            style: TextStyle(
                color: Colors.black54,
                letterSpacing: .5,
                fontSize: StudentLinkTheme().h2,
                fontWeight: FontWeight.bold),
          ),
        ),
        key: scaffoldKey,
        body: Container(
          margin: EdgeInsets.all(25),
          child: GlobalWidget().DecorativeContainer(Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                  padding: EdgeInsets.only(top: 50, left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            //avatar
                            Container(
                              width: 102,
                              height: 102,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: GlobalWidget().DecorativeContainer(
                                Container(
                                  width: 100,
                                  height: 100,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(profilephoto))),
                                ),
                              ),
                            ),

                            //name
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                name,
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: StudentLinkTheme().h2),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(
                                role,
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.black45,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: StudentLinkTheme().hdes),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            GlobalWidget().DecorativeContainer(
                              Container(
                                width: MediaQuery.of(context).size.width / .5,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    phone,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: StudentLinkTheme().primary2,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: .5,
                                        fontSize: StudentLinkTheme().h3),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //email
                            GlobalWidget().DecorativeContainer(
                              Container(
                                width: MediaQuery.of(context).size.width / .5,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    email,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: StudentLinkTheme().primary2,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: .5,
                                        fontSize: StudentLinkTheme().h3),
                                  ),
                                ),
                              ),
                            )

                            //phone
                          ],
                        ),
                      ),
                    ],
                  )))),
        ));
  }
}
