import 'dart:io';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentz_link/Models/applicationshowmodel.dart';
import 'package:studentz_link/Models/college.dart';
import 'package:studentz_link/Models/course.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/application_edit_screen1.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/applications_edit_screen2.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/feedetailsforadmission.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreenTank/applicationshowstream.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/receiptstream.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/collegedatastreem.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/coursedatastream.dart';
import 'package:studentz_link/screens/HomeScreen/main_activity.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

class ApplicationDetails extends StatefulWidget {
  String applicationid;
  int applicationstatus;
  ApplicationDetails(
      {Key? key, required this.applicationid, required this.applicationstatus})
      : super(key: key);

  @override
  State<ApplicationDetails> createState() => _ApplicationDetailsState();
}

class _ApplicationDetailsState extends State<ApplicationDetails> {
  ApplicationShowModel applicationshowmodel = ApplicationShowModel(
      code: 0,
      response: ApplicationShowResponse(
          id: 0,
          applicationId: '',
          imageUrl: '',
          course: '',
          collegeName: '',
          duration: 0,
          courseFee: 0,
          parentName: '',
          dateOfBirth: '',
          email: '',
          phone: '',
          parentPhone: '',
          address: '',
          applicationFee: '',
          city: '',
          cityId: '',
          country: '',
          countryId: '',
          courseEndYear: 0,
          courseStartYear: 0,
          state: '',
          stateId: '',
          batchId: 0,
          batchName: '',
          collegeId: 0,
          courseId: 0,
          firstName: '',
          lastName: ''),
      status: '');
  ApplicationShowData applicationshowdata = ApplicationShowData();
  GetReceiptstream receiptstream = GetReceiptstream();

  var resultproofadd;

  bool receiptadd = false;
  var extention;
  @override
  void initState() {
    applicationshowdata = ApplicationShowData();
    applicationshowdata.getapplicationshowData(
        applicationid: widget.applicationid);
    receiptstream = GetReceiptstream();
    receiptadd = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: applicationshowdata.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is ApplicationShowModel) {
              applicationshowmodel = snapshot.data as ApplicationShowModel;
              extention = applicationshowmodel.response.attachment
                  .split('.')
                  .last
                  .toString();
            }
          } else {
            return Scaffold(
              floatingActionButton: widget.applicationstatus == 1
                  ? AnimatedContainer(
                      height: 45,
                      margin: EdgeInsets.only(right: 15, bottom: 20),
                      duration: Duration(seconds: 1),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeeSettingForAdmission(
                                      id: applicationshowmodel.response.id
                                          .toString(),
                                      studentName: (applicationshowmodel
                                              .response.firstName +
                                          ' ' +
                                          applicationshowmodel
                                              .response.firstName),
                                      collegename: applicationshowmodel
                                          .response.collegeName,
                                      batchstart: applicationshowmodel
                                          .response.courseStartYear
                                          .toString(),
                                      batchend: applicationshowmodel
                                          .response.courseEndYear
                                          .toString(),
                                      applicationId: applicationshowmodel
                                          .response.applicationId,
                                      admissionFee: applicationshowmodel
                                          .response.courseFee
                                          .toString(),
                                      coursename:
                                          applicationshowmodel.response.course,
                                      duration: '',
                                    )),
                          );
                        },
                        child: Text(
                          'Admission',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: .5,
                            fontSize: StudentLinkTheme().h4,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                StudentLinkTheme().primary1),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ))),
                      ),
                    )
                  : SizedBox(),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                title: Text(
                  (applicationshowmodel.response.firstName +
                          ' ' +
                          applicationshowmodel.response.firstName)
                      .toString()
                      .toUpperCase(),
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: StudentLinkTheme().h4,
                  ),
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
                actions: [
                  IconButton(
                    iconSize: 20,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              body: Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                width: width,
                height: height,
                child: SingleChildScrollView(
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
                            child: CachedNetworkImage(
                              imageUrl: applicationshowmodel.response.imageUrl,
                              placeholderFadeInDuration: Duration(seconds: 30),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                color: StudentLinkTheme().primary1,
                                strokeWidth: 1.9,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )),

                        //name
                        Container(
                          margin: EdgeInsets.only(top: 17),
                          width: width,
                          child: Center(
                            child: Text(
                              (applicationshowmodel.response.firstName +
                                  ' ' +
                                  applicationshowmodel.response.firstName),
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: StudentLinkTheme().h4,
                              ),
                            ),
                          ),
                        ),

                        //Id
                        Container(
                          margin: EdgeInsets.only(top: 7),
                          width: width,
                          child: Center(
                            child: Text(
                              applicationshowmodel.response.applicationId,
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: StudentLinkTheme().h4,
                              ),
                            ),
                          ),
                        ),

                        //Course Info
                        GlobalWidget().DecorativeContainer(
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Container(
                                    width: width,
                                    child: Text(
                                      'Course Info :',
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: StudentLinkTheme().h4,
                                      ),
                                    ),
                                  ),

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
                                          applicationshowmodel
                                              .response.collegeName,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: .5,
                                            fontSize: StudentLinkTheme().h4,
                                          ),
                                        )
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
                                          "assets/images/home_screen/course.png",
                                          height: 20,
                                          width: 20,
                                        ),
                                        Container(
                                          width: 10,
                                        ),
                                        Text(
                                          applicationshowmodel.response.course,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: .5,
                                            fontSize: StudentLinkTheme().h4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // duration
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 5),
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
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: .5,
                                            fontSize: StudentLinkTheme().h4,
                                          ),
                                        ),
                                        Container(
                                          width: 10,
                                        ),
                                        Text(
                                          applicationshowmodel.response.duration
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: .5,
                                            fontSize: StudentLinkTheme().h4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //course fee
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 5),
                                    width: width,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/std_deatls/service.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                        Container(
                                          width: 10,
                                        ),
                                        Text(
                                          "Course Fee : ",
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: .5,
                                            fontSize: StudentLinkTheme().h4,
                                          ),
                                        ),
                                        Container(
                                          width: 10,
                                        ),
                                        Text(
                                          applicationshowmodel
                                              .response.applicationFee,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: .5,
                                            fontSize: StudentLinkTheme().h4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        //Personal info
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          elevation: 3,
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Container(
                                      width: width,
                                      child: Text(
                                        'Personal Info :',
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ),

                                    //Parent name
                                    Container(
                                      margin: EdgeInsets.only(top: 15, left: 5),
                                      width: width,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/std_deatls/parents.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            applicationshowmodel
                                                .response.parentName,
                                            softWrap: true,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: StudentLinkTheme().h4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //DOb

                                    Container(
                                      margin: EdgeInsets.only(top: 10, left: 5),
                                      width: width,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/std_deatls/calendar.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            "Date Of Birth:${applicationshowmodel.response.dateOfBirth} ",
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: StudentLinkTheme().h4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        //contact info
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          elevation: 3,
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Container(
                                      width: width,
                                      child: Text(
                                        'Contact Info :',
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ),

                                    //email
                                    Container(
                                      margin: EdgeInsets.only(top: 15, left: 5),
                                      width: width,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/std_deatls/email.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            applicationshowmodel.response.email,
                                            softWrap: true,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: StudentLinkTheme().h4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //mob
                                    Container(
                                      margin: EdgeInsets.only(top: 15, left: 5),
                                      width: width,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/std_deatls/phone-call.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            applicationshowmodel.response.phone,
                                            softWrap: true,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: StudentLinkTheme().h4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // lan mob
                                    Container(
                                      margin: EdgeInsets.only(top: 15, left: 5),
                                      width: width,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/std_deatls/phone.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            applicationshowmodel
                                                .response.parentPhone,
                                            softWrap: true,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: StudentLinkTheme().h4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //Addresss
                                    Container(
                                      margin: EdgeInsets.only(top: 15, left: 5),
                                      width: width,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/std_deatls/pin.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            applicationshowmodel
                                                .response.address,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: StudentLinkTheme().h4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        //Others
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          elevation: 3,
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Container(
                                      width: width,
                                      child: Text(
                                        'Other Info :',
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ),

                                    //Application Fee :
                                    Container(
                                      margin: EdgeInsets.only(top: 15, left: 5),
                                      width: width,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/std_deatls/resume.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            "Application Fee : ",
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                letterSpacing: .5,
                                                fontSize:
                                                    StudentLinkTheme().h4),
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            applicationshowmodel
                                                .response.applicationFee,
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: StudentLinkTheme().h4,
                                            ),
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
                                            'assets/images/std_deatls/service.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            "Course Fee : ",
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontWeight: FontWeight.bold,
                                              fontSize: StudentLinkTheme().h4,
                                            ),
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            applicationshowmodel
                                                .response.courseFee
                                                .toString(),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: StudentLinkTheme().h4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15, left: 5),
                                      width: width,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/std_deatls/service.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            "Application Fee Receipt : ",
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontWeight: FontWeight.bold,
                                              fontSize: StudentLinkTheme().h4,
                                            ),
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 60,
                                            width: 60,
                                            child: Image.network(
                                                applicationshowmodel
                                                    .response.attachment
                                                    .toString()),
                                          )
                                        ],
                                      ),
                                    ),

                                    //               // doc
                                    //               if (snapshot
                                    //                       .data!.response.documents.length !=
                                    //                   0)
                                    //                 Container(
                                    //                   margin:
                                    //                       EdgeInsets.only(top: 15, left: 5),
                                    //                   width: width,
                                    //                   child: Row(
                                    //                     children: [
                                    //                       Image.asset(
                                    //                         'assets/std_deatls/document.png',
                                    //                         height: 20,
                                    //                         width: 20,
                                    //                       ),
                                    //                       Container(
                                    //                         width: 10,
                                    //                       ),
                                    //                       Text(
                                    //                         "Document : ",
                                    //                         textAlign: TextAlign.start,
                                    //                         softWrap: true,
                                    //                         style: TextStyle(
                                    //   color: Colors.white,
                                    //   letterSpacing: .5,
                                    //   fontSize: StudentLinkTheme().h4,
                                    // ),
                                    //                       ),
                                    //                       Container(
                                    //                         width: 10,
                                    //                       ),
                                    //                       Container(
                                    //                         height: 70,
                                    //                         child: ListView.builder(
                                    //                           shrinkWrap: true,
                                    //                           scrollDirection:
                                    //                               Axis.horizontal,
                                    //                           itemCount: snapshot.data!
                                    //                               .response.documents.length,
                                    //                           itemBuilder:
                                    //                               (BuildContext context,
                                    //                                   int index) {
                                    //                             var extention = snapshot
                                    //                                 .data!
                                    //                                 .response
                                    //                                 .documents[index]
                                    //                                 .document
                                    //                                 .split('.')
                                    //                                 .last
                                    //                                 .toString();
                                    //                             if (snapshot.hasData) {
                                    //                               return InkWell(
                                    //                                   onTap: () {
                                    //                                     // Routing(
                                    //                                     //     context: context,
                                    //                                     //     To: NetWorkDocViewer(
                                    //                                     //       extention:
                                    //                                     //           extention,
                                    //                                     //       Url: Document_Base_Url +
                                    //                                     //           snapshot
                                    //                                     //               .data!
                                    //                                     //               .response
                                    //                                     //               .documents[
                                    //                                     //                   index]
                                    //                                     //               .document
                                    //                                     //               .toString(),
                                    //                                     //     ));
                                    //                                   },
                                    //                                   child: extention ==
                                    //                                               'jpg' ||
                                    //                                           extention ==
                                    //                                               'png' ||
                                    //                                           extention ==
                                    //                                               'jpeg'
                                    //                                       ? Container(
                                    //                                           margin: EdgeInsets
                                    //                                               .only(
                                    //                                                   right:
                                    //                                                       10),
                                    //                                           color:
                                    //                                               secondarybg,
                                    //                                           child: Image
                                    //                                               .network(
                                    //                                             Document_Base_Url +
                                    //                                                 snapshot
                                    //                                                     .data!
                                    //                                                     .response
                                    //                                                     .documents[
                                    //                                                         index]
                                    //                                                     .document,
                                    //                                             width: 70,
                                    //                                             height: 70,
                                    //                                             fit: BoxFit
                                    //                                                 .fill,
                                    //                                           ),
                                    //                                         )
                                    //                                       : Container(
                                    //                                           width: 70,
                                    //                                           height: 70,
                                    //                                           child: PdfView(
                                    //                                               path: Document_Base_Url +
                                    //                                                   snapshot
                                    //                                                       .data!
                                    //                                                       .response
                                    //                                                       .documents[index]
                                    //                                                       .document)));
                                    //                             } else {
                                    //                               return Container();
                                    //                             }
                                    //                           },
                                    //                         ),
                                    //                       )
                                    //                     ],
                                    //                   ),
                                    //                 ),
                                    //res
                                    // if (snapshot
                                    //         .data!.response.receipts.length !=
                                    //     0)
                                    //   Container(
                                    //     margin:
                                    //         EdgeInsets.only(top: 15, left: 5),
                                    //     width: width,
                                    //     child: Row(
                                    //       children: [
                                    //         Image.asset(
                                    //           'assets/std_deatls/document.png',
                                    //           height: 20,
                                    //           width: 20,
                                    //         ),
                                    //         Container(
                                    //           width: 10,
                                    //         ),
                                    //         Text(
                                    //           "Receipt : ",
                                    //           textAlign: TextAlign.start,
                                    //           // style: GoogleFonts.roboto(
                                    //           //   textStyle: TextStyle(
                                    //           //       color: Colors.black54,
                                    //           //       letterSpacing: .5,
                                    //           //       fontSize: h4),
                                    //           // ),
                                    //         ),
                                    //         Container(
                                    //           width: 10,
                                    //         ),
                                    //         Container(
                                    //           height: 70,
                                    //           child: ListView.builder(
                                    //             shrinkWrap: true,
                                    //             scrollDirection:
                                    //                 Axis.horizontal,
                                    //             itemCount: snapshot.data!
                                    //                 .response.receipts.length,
                                    //             itemBuilder:
                                    //                 (BuildContext context,
                                    //                     int index) {
                                    //               var extention = snapshot
                                    //                   .data!
                                    //                   .response
                                    //                   .receipts[index]
                                    //                   .receipt
                                    //                   .split('.')
                                    //                   .last
                                    //                   .toString();
                                    //               if (snapshot.hasData) {
                                    //                 return InkWell(
                                    //                     onTap: () {
                                    //                       // Routing(
                                    //                       //     context: context,
                                    //                       //     To: NetWorkDocViewer(
                                    //                       //       extention:
                                    //                       //           extention,
                                    //                       //       Url: Receipt_Base_Url +
                                    //                       //           snapshot
                                    //                       //               .data!
                                    //                       //               .response
                                    //                       //               .receipts[
                                    //                       //                   index]
                                    //                       //               .receipt
                                    //                       //               .toString(),
                                    //                       //     ));
                                    //                     },
                                    //                     child: extention ==
                                    //                                 'jpg' ||
                                    //                             extention ==
                                    //                                 'png' ||
                                    //                             extention ==
                                    //                                 'jpeg'
                                    //                         ? Container(
                                    //                             margin: EdgeInsets
                                    //                                 .only(
                                    //                                     right:
                                    //                                         10),
                                    //                             color:
                                    //                                 secondarybg,
                                    //                             child: Image
                                    //                                 .network(
                                    //                               Receipt_Base_Url +
                                    //                                   snapshot
                                    //                                       .data!
                                    //                                       .response
                                    //                                       .receipts[
                                    //                                           index]
                                    //                                       .receipt,
                                    //                               width: 70,
                                    //                               height: 70,
                                    //                               fit: BoxFit
                                    //                                   .fill,
                                    //                             ),
                                    //                           )
                                    //                         : Container(
                                    //                             width: 70,
                                    //                             height: 70,
                                    //                             child: PdfView(
                                    //                                 path: Receipt_Base_Url +
                                    //                                     snapshot
                                    //                                         .data!
                                    //                                         .response
                                    //                                         .receipts[index]
                                    //                                         .receipt)));
                                    //               } else {
                                    //                 return Container();
                                    //               }
                                    //             },
                                    //           ),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          }
          return Scaffold(
            floatingActionButton: widget.applicationstatus == 1
                ? AnimatedContainer(
                    height: 45,
                    margin: EdgeInsets.only(right: 15, bottom: 20),
                    duration: Duration(seconds: 1),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeeSettingForAdmission(
                                    id: applicationshowmodel.response.id
                                        .toString(),
                                    studentName: applicationshowmodel
                                            .response.firstName +
                                        ' ' +
                                        applicationshowmodel.response.firstName,
                                    collegename: applicationshowmodel
                                        .response.collegeName,
                                    batchstart: applicationshowmodel
                                        .response.courseStartYear
                                        .toString(),
                                    batchend: applicationshowmodel
                                        .response.courseEndYear
                                        .toString(),
                                    applicationId: applicationshowmodel
                                        .response.applicationId,
                                    admissionFee: applicationshowmodel
                                        .response.courseFee
                                        .toString(),
                                    coursename:
                                        applicationshowmodel.response.course,
                                    duration: applicationshowmodel
                                        .response.duration
                                        .toString(),
                                  )),
                        );
                      },
                      child: Text(
                        'Admission',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5,
                          fontSize: StudentLinkTheme().h4,
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              StudentLinkTheme().primary1),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ))),
                    ),
                  )
                : SizedBox(),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: Text(
                (applicationshowmodel.response.firstName +
                        ' ' +
                        applicationshowmodel.response.lastName)
                    .toString()
                    .toUpperCase(),
                softWrap: true,
                style: TextStyle(
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                  letterSpacing: .5,
                  fontSize: StudentLinkTheme().h4,
                ),
              ),
              leading: IconButton(
                iconSize: 20,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainAcitivty(
                          choosedFragment: 2,
                        ),
                      ),
                      (route) => false);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black54,
                ),
              ),
              actions: [
                IconButton(
                  iconSize: 20,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black54,
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApplicationEdit(
                                  college:
                                      applicationshowmodel.response.collegeName,
                                  course: applicationshowmodel.response.course,
                                  applicationid: applicationshowmodel
                                      .response.id
                                      .toString(),
                                  batch_id: applicationshowmodel
                                      .response.batchId
                                      .toString(),
                                  college_id: applicationshowmodel
                                      .response.collegeId
                                      .toString(),
                                  course_id: applicationshowmodel
                                      .response.courseId
                                      .toString(),
                                )));
                  },
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: width,
              height: height,
              child: SingleChildScrollView(
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
                          child: CachedNetworkImage(
                            imageUrl: applicationshowmodel.response.imageUrl,
                            placeholderFadeInDuration: Duration(seconds: 30),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                              color: StudentLinkTheme().primary1,
                              strokeWidth: 1.9,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )),

                      //name
                      Container(
                        margin: EdgeInsets.only(top: 17),
                        width: width,
                        child: Center(
                          child: Text(
                            (applicationshowmodel.response.firstName +
                                    ' ' +
                                    applicationshowmodel.response.lastName)
                                .toString()
                                .toUpperCase(),
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5,
                              fontSize: StudentLinkTheme().h4,
                            ),
                          ),
                        ),
                      ),

                      //Id
                      Container(
                        margin: EdgeInsets.only(top: 7),
                        width: width,
                        child: Center(
                          child: Text(
                            applicationshowmodel.response.applicationId,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5,
                              fontSize: StudentLinkTheme().h4,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      //Course Info
                      GlobalWidget().DecorativeContainer(
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  width: width,
                                  child: Text(
                                    'Course Info :',
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .5,
                                      fontSize: StudentLinkTheme().h4,
                                    ),
                                  ),
                                ),

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
                                        applicationshowmodel
                                            .response.collegeName,
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      )
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
                                        applicationshowmodel.response.course,
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // duration
                                Container(
                                  margin: EdgeInsets.only(top: 10, left: 5),
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
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        applicationshowmodel.response.duration
                                            .toString(),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //course fee
                                Container(
                                  margin: EdgeInsets.only(top: 10, left: 5),
                                  width: width,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/std_deatls/service.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        "Course Fee : ",
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.bold,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        applicationshowmodel.response.courseFee
                                            .toString(),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      //Personal info
                      GlobalWidget().DecorativeContainer(
                        Container(
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
                                      color: Colors.grey[900],
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .5,
                                      fontSize: StudentLinkTheme().h4,
                                    ),
                                  ),
                                ),

                                //Parent name
                                Container(
                                  margin: EdgeInsets.only(top: 15, left: 5),
                                  width: width,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/std_deatls/parents.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        (applicationshowmodel
                                                .response.firstName +
                                            ' ' +
                                            applicationshowmodel
                                                .response.lastName),
                                        softWrap: true,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //DOb

                                Container(
                                  margin: EdgeInsets.only(top: 10, left: 5),
                                  width: width,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/std_deatls/calendar.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        "Date Of Birth: ${DateFormat.yMMMEd().format(applicationshowmodel.response.dateOfBirth)} ",
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      //contact info
                      GlobalWidget().DecorativeContainer(
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  width: width,
                                  child: Text(
                                    'Contact Info :',
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .5,
                                      fontSize: StudentLinkTheme().h4,
                                    ),
                                  ),
                                ),

                                //email
                                Container(
                                  margin: EdgeInsets.only(top: 15, left: 5),
                                  width: width,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/std_deatls/email.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        applicationshowmodel.response.email,
                                        softWrap: true,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //mob
                                Container(
                                  margin: EdgeInsets.only(top: 15, left: 5),
                                  width: width,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/std_deatls/phone-call.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        applicationshowmodel.response.phone,
                                        softWrap: true,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // lan mob
                                Container(
                                  margin: EdgeInsets.only(top: 15, left: 5),
                                  width: width,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/std_deatls/phone.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        applicationshowmodel
                                            .response.parentPhone,
                                        softWrap: true,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //Addresss
                                Container(
                                  margin: EdgeInsets.only(top: 15, left: 5),
                                  width: width,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/std_deatls/pin.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        applicationshowmodel.response.address,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      //Others
                      GlobalWidget().DecorativeContainer(
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  width: width,
                                  child: Text(
                                    'Other Info :',
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .5,
                                      fontSize: StudentLinkTheme().h4,
                                    ),
                                  ),
                                ),

                                //Application Fee :
                                Container(
                                  margin: EdgeInsets.only(top: 15, left: 5),
                                  width: width,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/std_deatls/resume.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        "Application Fee : ",
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .5,
                                            fontSize: StudentLinkTheme().h4),
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        applicationshowmodel
                                            .response.applicationFee,
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
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
                                        'assets/images/std_deatls/service.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        "Course Fee : ",
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        applicationshowmodel.response.courseFee
                                            .toString(),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15, left: 5),
                                  width: width,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/std_deatls/resume.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        "Application Fee Receipt : ",
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.bold,
                                          fontSize: StudentLinkTheme().h4,
                                        ),
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      applicationshowmodel.response.attachment
                                                  .toString() !=
                                              "https://admission.studentzlink.com/media/attachment/"
                                          ? InkWell(
                                              child: extention == 'jpg' ||
                                                      extention == 'png' ||
                                                      extention == 'jpeg'
                                                  ? GlobalWidget()
                                                      .DecorativeContainer(
                                                          Container(
                                                      height: 80,
                                                      width: 80,
                                                      child: Image.network(
                                                        applicationshowmodel
                                                            .response.attachment
                                                            .toString(),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ))
                                                  : Stack(
                                                      alignment:
                                                          Alignment.topRight,
                                                      children: [
                                                        GlobalWidget()
                                                            .DecorativeContainer(
                                                                Container(
                                                          height: 80,
                                                          width: 80,
                                                          child: SfPdfViewer.network(
                                                              applicationshowmodel
                                                                  .response
                                                                  .attachment
                                                                  .toString()),
                                                        )),
                                                        CircleAvatar(
                                                          radius: 15,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                showBarModalBottomSheet(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            Container(
                                                                              height: 600,
                                                                              width: width,
                                                                              child: SfPdfViewer.network(applicationshowmodel.response.attachment.toString()),
                                                                            ));
                                                              },
                                                              icon: Icon(
                                                                Icons.expand,
                                                                color: Colors
                                                                    .white,
                                                                size: 15,
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                              onTap: () {
                                                showBarModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) =>
                                                        extention == 'jpg' ||
                                                                extention ==
                                                                    'png' ||
                                                                extention ==
                                                                    'jpeg'
                                                            ? Container(
                                                                height: 600,
                                                                width: width,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image:
                                                                      NetworkImage(
                                                                    applicationshowmodel
                                                                        .response
                                                                        .attachment
                                                                        .toString(),
                                                                  ),
                                                                )),
                                                              )
                                                            : Container(
                                                                height: 600,
                                                                width: width,
                                                                child: SfPdfViewer.network(
                                                                    applicationshowmodel
                                                                        .response
                                                                        .attachment
                                                                        .toString()),
                                                              ));
                                              },
                                            )
                                          : receiptadd != true
                                              ? GlobalWidget()
                                                  .DecorativeContainer(
                                                      IconButton(
                                                          onPressed: () async {
                                                            resultproofadd =
                                                                await FilePicker
                                                                    .platform
                                                                    .pickFiles(
                                                              allowMultiple:
                                                                  false,
                                                              type: FileType
                                                                  .custom,
                                                              allowedExtensions: [
                                                                'jpg',
                                                                'jpeg',
                                                                'pdf',
                                                                'doc',
                                                                'png'
                                                              ],
                                                            );
                                                            setState(() {
                                                              receiptadd = true;
                                                            });
                                                            addApplicationForm(
                                                                    applicationid: applicationshowmodel.response.id
                                                                        .toString(),
                                                                    batch_id: applicationshowmodel
                                                                        .response
                                                                        .batchId
                                                                        .toString(),
                                                                    college_id: applicationshowmodel
                                                                        .response
                                                                        .collegeId
                                                                        .toString(),
                                                                    course_id: applicationshowmodel
                                                                        .response
                                                                        .courseId
                                                                        .toString(),
                                                                    first_name: applicationshowmodel
                                                                        .response
                                                                        .firstName
                                                                        .toString(),
                                                                    last_name: applicationshowmodel
                                                                        .response
                                                                        .lastName
                                                                        .toString(),
                                                                    email: applicationshowmodel
                                                                        .response
                                                                        .email
                                                                        .toString(),
                                                                    phone: applicationshowmodel
                                                                        .response
                                                                        .phone
                                                                        .toString(),
                                                                    date_of_birth: applicationshowmodel
                                                                        .response
                                                                        .dateOfBirth
                                                                        .toString(),
                                                                    parent_name: applicationshowmodel
                                                                        .response
                                                                        .parentName
                                                                        .toString(),
                                                                    parent_phone: applicationshowmodel
                                                                        .response
                                                                        .parentPhone
                                                                        .toString(),
                                                                    address: applicationshowmodel.response.address.toString(),
                                                                    country: applicationshowmodel.response.countryId.toString(),
                                                                    state: applicationshowmodel.response.stateId.toString(),
                                                                    city: applicationshowmodel.response.cityId.toString(),
                                                                    receipt: resultproofadd!.paths[0].toString())
                                                                .then((value) => applicationshowdata.getapplicationshowData(applicationid: widget.applicationid));
                                                          },
                                                          icon:
                                                              Icon(Icons.add)))
                                              : GlobalWidget()
                                                  .DecorativeContainer(
                                                      CircularProgressIndicator(
                                                  strokeWidth: 1.5,
                                                  color: StudentLinkTheme()
                                                      .primary1,
                                                ))
                                    ],
                                  ),
                                ),

                                //               // doc
                                //               if (snapshot
                                //                       .data!.response.documents.length !=
                                //                   0)
                                //                 Container(
                                //                   margin:
                                //                       EdgeInsets.only(top: 15, left: 5),
                                //                   width: width,
                                //                   child: Row(
                                //                     children: [
                                //                       Image.asset(
                                //                         'assets/std_deatls/document.png',
                                //                         height: 20,
                                //                         width: 20,
                                //                       ),
                                //                       Container(
                                //                         width: 10,
                                //                       ),
                                //                       Text(
                                //                         "Document : ",
                                //                         textAlign: TextAlign.start,
                                //                         softWrap: true,
                                //                         style: TextStyle(
                                //   color: Colors.white,
                                //   letterSpacing: .5,
                                //   fontSize: StudentLinkTheme().h4,
                                // ),
                                //                       ),
                                //                       Container(
                                //                         width: 10,
                                //                       ),
                                //                       Container(
                                //                         height: 70,
                                //                         child: ListView.builder(
                                //                           shrinkWrap: true,
                                //                           scrollDirection:
                                //                               Axis.horizontal,
                                //                           itemCount: snapshot.data!
                                //                               .response.documents.length,
                                //                           itemBuilder:
                                //                               (BuildContext context,
                                //                                   int index) {
                                //                             var extention = snapshot
                                //                                 .data!
                                //                                 .response
                                //                                 .documents[index]
                                //                                 .document
                                //                                 .split('.')
                                //                                 .last
                                //                                 .toString();
                                //                             if (snapshot.hasData) {
                                //                               return InkWell(
                                //                                   onTap: () {
                                //                                     // Routing(
                                //                                     //     context: context,
                                //                                     //     To: NetWorkDocViewer(
                                //                                     //       extention:
                                //                                     //           extention,
                                //                                     //       Url: Document_Base_Url +
                                //                                     //           snapshot
                                //                                     //               .data!
                                //                                     //               .response
                                //                                     //               .documents[
                                //                                     //                   index]
                                //                                     //               .document
                                //                                     //               .toString(),
                                //                                     //     ));
                                //                                   },
                                //                                   child: extention ==
                                //                                               'jpg' ||
                                //                                           extention ==
                                //                                               'png' ||
                                //                                           extention ==
                                //                                               'jpeg'
                                //                                       ? Container(
                                //                                           margin: EdgeInsets
                                //                                               .only(
                                //                                                   right:
                                //                                                       10),
                                //                                           color:
                                //                                               secondarybg,
                                //                                           child: Image
                                //                                               .network(
                                //                                             Document_Base_Url +
                                //                                                 snapshot
                                //                                                     .data!
                                //                                                     .response
                                //                                                     .documents[
                                //                                                         index]
                                //                                                     .document,
                                //                                             width: 70,
                                //                                             height: 70,
                                //                                             fit: BoxFit
                                //                                                 .fill,
                                //                                           ),
                                //                                         )
                                //                                       : Container(
                                //                                           width: 70,
                                //                                           height: 70,
                                //                                           child: PdfView(
                                //                                               path: Document_Base_Url +
                                //                                                   snapshot
                                //                                                       .data!
                                //                                                       .response
                                //                                                       .documents[index]
                                //                                                       .document)));
                                //                             } else {
                                //                               return Container();
                                //                             }
                                //                           },
                                //                         ),
                                //                       )
                                //                     ],
                                //                   ),
                                //                 ),
                                //res
                                // if (snapshot
                                //         .data!.response.receipts.length !=
                                //     0)
                                //   Container(
                                //     margin:
                                //         EdgeInsets.only(top: 15, left: 5),
                                //     width: width,
                                //     child: Row(
                                //       children: [
                                //         Image.asset(
                                //           'assets/std_deatls/document.png',
                                //           height: 20,
                                //           width: 20,
                                //         ),
                                //         Container(
                                //           width: 10,
                                //         ),
                                //         Text(
                                //           "Receipt : ",
                                //           textAlign: TextAlign.start,
                                //           // style: GoogleFonts.roboto(
                                //           //   textStyle: TextStyle(
                                //           //       color: Colors.black54,
                                //           //       letterSpacing: .5,
                                //           //       fontSize: h4),
                                //           // ),
                                //         ),
                                //         Container(
                                //           width: 10,
                                //         ),
                                //         Container(
                                //           height: 70,
                                //           child: ListView.builder(
                                //             shrinkWrap: true,
                                //             scrollDirection:
                                //                 Axis.horizontal,
                                //             itemCount: snapshot.data!
                                //                 .response.receipts.length,
                                //             itemBuilder:
                                //                 (BuildContext context,
                                //                     int index) {
                                //               var extention = snapshot
                                //                   .data!
                                //                   .response
                                //                   .receipts[index]
                                //                   .receipt
                                //                   .split('.')
                                //                   .last
                                //                   .toString();
                                //               if (snapshot.hasData) {
                                //                 return InkWell(
                                //                     onTap: () {
                                //                       // Routing(
                                //                       //     context: context,
                                //                       //     To: NetWorkDocViewer(
                                //                       //       extention:
                                //                       //           extention,
                                //                       //       Url: Receipt_Base_Url +
                                //                       //           snapshot
                                //                       //               .data!
                                //                       //               .response
                                //                       //               .receipts[
                                //                       //                   index]
                                //                       //               .receipt
                                //                       //               .toString(),
                                //                       //     ));
                                //                     },
                                //                     child: extention ==
                                //                                 'jpg' ||
                                //                             extention ==
                                //                                 'png' ||
                                //                             extention ==
                                //                                 'jpeg'
                                //                         ? Container(
                                //                             margin: EdgeInsets
                                //                                 .only(
                                //                                     right:
                                //                                         10),
                                //                             color:
                                //                                 secondarybg,
                                //                             child: Image
                                //                                 .network(
                                //                               Receipt_Base_Url +
                                //                                   snapshot
                                //                                       .data!
                                //                                       .response
                                //                                       .receipts[
                                //                                           index]
                                //                                       .receipt,
                                //                               width: 70,
                                //                               height: 70,
                                //                               fit: BoxFit
                                //                                   .fill,
                                //                             ),
                                //                           )
                                //                         : Container(
                                //                             width: 70,
                                //                             height: 70,
                                //                             child: PdfView(
                                //                                 path: Receipt_Base_Url +
                                //                                     snapshot
                                //                                         .data!
                                //                                         .response
                                //                                         .receipts[index]
                                //                                         .receipt)));
                                //               } else {
                                //                 return Container();
                                //               }
                                //             },
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          );
        });
  }

  Future<void> addApplicationForm(
      {applicationid,
      college_id,
      course_id,
      batch_id,
      first_name,
      last_name,
      email,
      phone,
      date_of_birth,
      address,
      parent_name,
      parent_phone,
      country,
      state,
      city,
      receipt}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GlobalWidget().showToast(msg: 'Please Wait...');

    var postUri = Uri.parse(
        "https://admission.studentzlink.com/api/v1/saleteam/update-application");
    var request = new http.MultipartRequest("POST", postUri);
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('accessToken')}',
    });

    request.fields['id'] = applicationid;
    request.fields['college_id'] = college_id;
    request.fields['course_id'] = course_id;
    request.fields['batch_id'] = batch_id;
    request.fields['first_name'] = first_name;

    request.fields['last_name'] = last_name;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['date_of_birth'] = date_of_birth;
    request.fields['address'] = address;
    request.fields['parent_name'] = parent_name;
    request.fields['parent_phone'] = parent_phone;
    request.fields['country'] = country;
    request.fields['state'] = state;
    request.fields['city'] = city;
    //request.fields['receipt_remark'] = 'dfgdfg';
    request.files.add(await http.MultipartFile.fromPath('attachment', receipt));

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Image Uploaded");
      //GlobalData.clearAll();
      GlobalWidget().showToast(msg: 'Receipt Add successfully...');
    } else {
      GlobalWidget().showToast(msg: 'Receipt Add Not successfully...');

      GlobalData.clearAll();
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}
