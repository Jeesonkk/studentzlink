import 'package:flutter/material.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class DashboardWidgets {
  Widget bodywidget(
      {required double width,
      required Color secondary,
      required Color primery,
      required dynamic Applications1,
      required dynamic application2,
      required String text1,
      required String text2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 125,
          width: width * 0.47,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                      colors: [
                        secondary,
                        primery,
                      ],
                      begin: const FractionalOffset(0.0, 1.0),
                      end: const FractionalOffset(0.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                padding:
                    EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text1,
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: .5,
                        fontSize: StudentLinkTheme().h2,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            decoration: BoxDecoration(
                              color: secondary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.all(15),
                            child: Text(Applications1.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18))),
                        ImageIcon(
                          AssetImage(
                            'assets/images/home_screen/homepageimg/average.png',
                          ),
                          size: 35,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),

        /// 2nd

        Container(
          height: 125,
          width: width * 0.47,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                      colors: [
                        secondary,
                        primery,
                      ],
                      begin: const FractionalOffset(0.0, 1.0),
                      end: const FractionalOffset(0.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                padding:
                    EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text2,
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: .5,
                        fontSize: StudentLinkTheme().h2,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            decoration: BoxDecoration(
                              color: secondary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.all(15),
                            child: Text(application2.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18))),
                        ImageIcon(
                          AssetImage(
                            'assets/images/home_screen/homepageimg/average.png',
                          ),
                          size: 35,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }

  Widget gridwidget(
      {required String applicationPending,
      required double width,
      required String applicationCancelled,
      required String sfullyPaidStudents,
      required String applicationApproved}) {
    return GridView.count(
      controller: new ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2.6 / 1.9,
      crossAxisSpacing: 1,
      mainAxisSpacing: 1,
      children: [
        Container(
          width: width,
          child: Card(
            elevation: 2,
            child: Container(
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    colors: [StudentLinkTheme().kGreyLightestest, Colors.white],
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0xff112c4f),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ],
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      )),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -80,
                      bottom: -60,
                      child: Container(
                          width: 200,
                          height: 200,
                          decoration: new BoxDecoration(
                            // image: DecorationImage(
                            //     image: AssetImage(
                            //   'assets/images/home_screen/homepageimg/bbbbb.png',
                            // )),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(200),
                                bottomLeft: Radius.circular(200)),
                          ),
                          child: Center(
                            child: Text(
                              sfullyPaidStudents.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 7, left: 10, right: 10, bottom: 4),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Application fee paid',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: .5,
                                  fontSize: StudentLinkTheme().h3,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10, left: 25),
                                child: ImageIcon(
                                    AssetImage(
                                      'assets/images/home_screen/homepageimg/card_img.png',
                                    ),
                                    size: 29,
                                    color: StudentLinkTheme().primary1)),
                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 4),
                                      width: 100,
                                      height: 1,
                                      color: Colors.grey),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 3,
                                        ),
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 3),
                                        height: 10,
                                        child: Text(
                                          'Total no.of students paid',
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: .5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: StudentLinkTheme().h5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    )
                  ],
                )),
          ),
        ),

        /// 2nd
        Container(
          width: width,
          child: Card(
            elevation: 2,
            child: Container(
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    colors: [StudentLinkTheme().kGreyLightestest, Colors.white],
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0xff112c4f),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ],
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      )),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        right: -80,
                        bottom: -60,
                        child: Container(
                          width: 200,
                          height: 200,
                          // decoration: new BoxDecoration(
                          //   image: DecorationImage(
                          //       image: AssetImage(
                          //           'assets/images/home_screen/homepageimg/bbbbb.png')),
                          //   borderRadius: BorderRadius.only(
                          //       topLeft: Radius.circular(200),
                          //       bottomLeft: Radius.circular(200)),
                          // ),
                          child: Center(
                              child: Text(
                            applicationApproved.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          )),
                        )),
                    Container(
                      padding: EdgeInsets.only(
                          top: 7, left: 10, right: 10, bottom: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirmed',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: .5,
                                  fontSize: StudentLinkTheme().h3,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10, left: 25),
                                child: ImageIcon(
                                    AssetImage(
                                        'assets/images/home_screen/homepageimg/Layer16.png'),
                                    size: 29,
                                    color: StudentLinkTheme().primary1)),
                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 4),
                                      width: 100,
                                      height: 1,
                                      color: Colors.grey),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 3,
                                        ),
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 3),
                                        height: 10,
                                        child: Text(
                                          'Total no.of students paid',
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: .5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: StudentLinkTheme().h5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    )
                  ],
                )),
          ),
        ),

        /// 3rd
        Container(
          width: width,
          child: Card(
            elevation: 2,
            child: Container(
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    colors: [StudentLinkTheme().kGreyLightestest, Colors.white],
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0xff112c4f),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ],
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      )),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        right: -80,
                        bottom: -60,
                        child: Container(
                          width: 200,
                          height: 200,
                          // decoration: new BoxDecoration(
                          //   image: DecorationImage(
                          //       image: AssetImage(
                          //           'assets/images/home_screen/homepageimg/bbbbb.png')),
                          //   borderRadius: BorderRadius.only(
                          //       topLeft: Radius.circular(200),
                          //       bottomLeft: Radius.circular(200)),
                          // ),
                          child: Center(
                              child: Text(
                            applicationCancelled.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          )),
                        )),
                    Container(
                      padding: EdgeInsets.only(
                          top: 7, left: 10, right: 10, bottom: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cancelled',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: .5,
                                  fontSize: StudentLinkTheme().h3,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10, left: 25),
                                child: ImageIcon(
                                    AssetImage(
                                        'assets/images/home_screen/homepageimg/Layer18.png'),
                                    size: 29,
                                    color: StudentLinkTheme().primary2)),
                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 4),
                                      width: 100,
                                      height: 1,
                                      color: Colors.grey),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 3,
                                        ),
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 3),
                                        height: 10,
                                        child: Text(
                                          'Total no.of students paid',
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: .5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: StudentLinkTheme().h5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ],
                )),
          ),
        ),

        /// 4th
        Container(
          width: width,
          child: Card(
            elevation: 2,
            child: Container(
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    colors: [StudentLinkTheme().kGreyLightestest, Colors.white],
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0xff112c4f),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ],
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      )),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        right: -80,
                        bottom: -60,
                        child: Container(
                          width: 200,
                          height: 200,
                          // decoration: new BoxDecoration(
                          //   image: DecorationImage(
                          //       image: AssetImage(
                          //           'assets/images/home_screen/homepageimg/bbbbb.png')),
                          //   borderRadius: BorderRadius.only(
                          //       topLeft: Radius.circular(200),
                          //       bottomLeft: Radius.circular(200)),
                          // ),
                          child: Center(
                              child: Text(
                            applicationPending.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          )),
                        )),
                    Container(
                      padding: EdgeInsets.only(
                          top: 7, left: 10, right: 10, bottom: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pending',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: .5,
                                  fontSize: StudentLinkTheme().h3,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10, left: 25),
                                child: ImageIcon(
                                    AssetImage(
                                        'assets/images/home_screen/homepageimg/Layer20.png'),
                                    size: 29,
                                    color: StudentLinkTheme().primary1)),
                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 4),
                                      width: 100,
                                      height: 1,
                                      color: Colors.grey),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 3,
                                        ),
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 3),
                                        height: 10,
                                        child: Text(
                                          'Total no.of students paid',
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: .5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: StudentLinkTheme().h5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    )
                  ],
                )),
          ),
        )
      ],
    );
  }

  Widget Singledrawwidget(
      {required double width,
      required Color secondary,
      required Color primery,
      required String text1,
      required String Applications1}) {
    return Container(
      height: 125,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              gradient: LinearGradient(
                  colors: [
                    secondary,
                    primery,
                  ],
                  begin: const FractionalOffset(0.0, 1.0),
                  end: const FractionalOffset(0.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: StudentLinkTheme().h2,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 5, left: 5),
                        decoration: BoxDecoration(
                          color: secondary,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Text(Applications1.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18))),
                    ImageIcon(
                      AssetImage(
                        'assets/images/home_screen/homepageimg/average.png',
                      ),
                      size: 35,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
