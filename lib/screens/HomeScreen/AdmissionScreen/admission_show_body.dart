import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studentz_link/Models/admissionshowmodel.dart';
import 'package:studentz_link/screens/HomeScreen/AdmissionScreenTank/admissionshowstream.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/utils/styles.dart';

class AdmissionShowPage extends StatefulWidget {
  String applicationid, applicationname;
  AdmissionShowPage(
      {Key? key, required this.applicationid, required this.applicationname})
      : super(key: key);

  @override
  State<AdmissionShowPage> createState() => _AdmissionShowPageState();
}

class _AdmissionShowPageState extends State<AdmissionShowPage> {
  AdmissionshowData admissionshowstream = AdmissionshowData();
  AdmissionShowModel admissionshowmodel = AdmissionShowModel(
      code: 0,
      response: AdmissionShowResponse(
          collegeName: '',
          courseDuration: 0,
          courseDurationType: '',
          courseName: '',
          feeHistory: [],
          firstYearFeePaid: 0,
          id: 0,
          imageUrl: '',
          name: '',
          status: '',
          totalCourseFee: 0,
          commisionAmount: 0),
      status: '');
  @override
  void initState() {
    admissionshowstream = AdmissionshowData();
    admissionshowstream.getadmissionshowData(admissionid: widget.applicationid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            widget.applicationname.toString(),
            softWrap: true,
            style: TextStyle(
                color: Colors.black,
                letterSpacing: .5,
                fontSize: StudentLinkTheme().h3,
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
        body: StreamBuilder(
            stream: admissionshowstream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data is AdmissionShowModel) {
                  admissionshowmodel = snapshot.data as AdmissionShowModel;
                  GlobalData.commission =
                      admissionshowmodel.response.commisionAmount.toString();
                }
              } else {
                return RefreshIndicator(
                  color: StudentLinkTheme().primary1,
                  onRefresh: () => admissionshowstream.getadmissionshowData(
                      admissionid: widget.applicationid),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: snapshot.hasError
                        ? Center(
                            child: Image.asset(
                              'assets/images/home_screen/nodata.png',
                              fit: BoxFit.contain,
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.4,
                              color: StudentLinkTheme().primary1,
                            ),
                          ),
                  ),
                );
              }
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    //photo

                    Container(
                      width: 100,
                      height: 100,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        admissionshowmodel.response.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),

                    //name
                    Container(
                      margin: EdgeInsets.only(top: 17),
                      width: width,
                      child: Center(
                        child: Text(
                          admissionshowmodel.response.name
                              .toString()
                              .toUpperCase(),
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.black87,
                              letterSpacing: .5,
                              fontSize: StudentLinkTheme().h2,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    // Id
                    // Container(
                    //   margin: EdgeInsets.only(top: 7),
                    //   width: width,
                    //   child: Center(
                    //     child: Text(
                    //       widget.applicationid.toString(),
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           letterSpacing: .5,
                    //           fontSize: StudentLinkTheme().h4),
                    //     ),
                    //   ),
                    // ),

                    //Personal info
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      elevation: 3,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Container(
                                width: width,
                                child: Text(
                                  'Personal Info :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: .5,
                                      fontSize: StudentLinkTheme().h3,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              //collage
                              // Container(
                              //   margin: EdgeInsets.only(top: 10, left: 5),
                              //   width: width,
                              //   child: Row(
                              //     children: [
                              //       Image.asset(
                              //         "assets/images/home_screen/graduation.png",
                              //         height: 20,
                              //         width: 20,
                              //       ),
                              //       Container(
                              //         width: 10,
                              //       ),
                              //       Text(
                              //         admissionshowmodel.response.,
                              //         softWrap: true,
                              //         textAlign: TextAlign.start,
                              //         style: TextStyle(
                              //             color: Colors.black87,
                              //             letterSpacing: .5,
                              //             fontSize: StudentLinkTheme().h4,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              //collage
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 5),
                                width: width,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/home_screen/graduation.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      admissionshowmodel.response.collegeName,
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),

                              //cource
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 5),
                                width: width,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/home_screen/course.jpeg",
                                      height: 20,
                                      width: 20,
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      admissionshowmodel.response.courseName,
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),

                              // duration
                              Container(
                                margin: EdgeInsets.only(top: 15, left: 5),
                                width: width,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/std_deatls/time.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      "Duration : ",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      admissionshowmodel.response.courseDuration
                                              .toString() +
                                          ' ' +
                                          admissionshowmodel
                                              .response.courseDurationType
                                              .toString(),
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),

                              //course fee
                              Container(
                                margin: EdgeInsets.only(top: 15, left: 5),
                                width: width,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/home_screen/fees.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      "Course Fee :",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      admissionshowmodel.response.totalCourseFee
                                          .toString(),
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),

                              // paid amount
                              Container(
                                margin: EdgeInsets.only(top: 15, left: 5),
                                width: width,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/home_screen/fees.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      "Paid Amount : ",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      (admissionshowmodel
                                                  .response.totalCourseFee -
                                              admissionshowmodel
                                                  .response.firstYearFeePaid)
                                          .toString(),
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),

                              // Commission amount
                              admissionshowmodel.response.commisionAmount != 0
                                  ? Container(
                                      margin: EdgeInsets.only(top: 15, left: 5),
                                      width: width,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/home_screen/commission.jpeg",
                                            height: 20,
                                            width: 20,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            "Commission Amount : ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: .5,
                                                fontSize: StudentLinkTheme().h4,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            admissionshowmodel
                                                .response.commisionAmount
                                                .toString(),
                                            softWrap: true,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: .5,
                                                fontSize: StudentLinkTheme().h4,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),

                              // pending fee
                              Container(
                                margin: EdgeInsets.only(top: 15, left: 5),
                                width: width,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/home_screen/fees.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      "Pending Fees : ",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      (admissionshowmodel
                                              .response.firstYearFeePaid)
                                          .toString(),
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Fee INFo
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      elevation: 3,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Container(
                                width: width,
                                child: Text(
                                  'Fee History :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: .5,
                                      fontSize: StudentLinkTheme().h3,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              //Application Fee :
                              Container(
                                  margin: EdgeInsets.only(top: 15, left: 5),
                                  width: width,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: admissionshowmodel
                                          .response.feeHistory.length,
                                      itemBuilder: ((context, index) {
                                        return Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/home_screen/fees.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            Text(
                                              ' installment ${index + 1} :'
                                                  .toString()
                                                  .toUpperCase(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: .5,
                                                  fontSize:
                                                      StudentLinkTheme().h4,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            Text(
                                              admissionshowmodel.response
                                                  .feeHistory[index].paidAmount,
                                              softWrap: true,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  letterSpacing: .5,
                                                  fontSize:
                                                      StudentLinkTheme().h4,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        );
                                      }))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
