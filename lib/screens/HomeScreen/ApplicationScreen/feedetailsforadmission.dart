import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/Widgets/input_widget.dart';
import 'package:studentz_link/screens/HomeScreen/main_activity.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class FeeSettingForAdmission extends StatefulWidget {
  final String applicationId,
      duration,
      collegename,
      coursename,
      batchstart,
      batchend,
      id,
      admissionFee,
      studentName;
  const FeeSettingForAdmission(
      {required this.duration,
      required this.studentName,
      required this.applicationId,
      required this.collegename,
      required this.admissionFee,
      required this.batchstart,
      required this.batchend,
      required this.id,
      required this.coursename});

  @override
  State<FeeSettingForAdmission> createState() => _FeeSettingForAdmissionState();
}

class _FeeSettingForAdmissionState extends State<FeeSettingForAdmission> {
  //loader
  late ProgressDialog pr;

  //Controllers
  TextEditingController remarkController = TextEditingController();
  TextEditingController IdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController admissonamountController = TextEditingController();
  TextEditingController paidamountController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();
  TextEditingController collegeController = TextEditingController();

  //payment amount input feild hint
  late String paidamountHint;

  //payment mode
  var PaymentModes = [];
  var SelectedPaymentMode;

  //payment status
  var PaymentSatus = [];
  var SelectedPaymentStatus;

  //master api holder
  var Master = {};

  //scaffold key
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    RestApi().GetPaymentMethods().then((value) {
      Master = value['response'];
      Master['payment_mode'].forEach((key, value) {
        setState(() {
          PaymentModes.add(key);
        });

        print(PaymentModes);
      });

      Master['payment_status'].forEach((key, value) {
        setState(() {
          PaymentSatus.add(key);
        });

        print(PaymentSatus);
      });
    });

    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    IdController.text = widget.applicationId;
    dateController.text = formattedDate;
    batchController.text = widget.duration;
    admissonamountController.text = widget.batchstart;
    collegeController.text = widget.collegename;
    paidamountHint = widget.batchend;
    paidamountController.text = widget.batchend;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      floatingActionButton: AnimatedContainer(
        height: 55,
        width: 100,
        margin: EdgeInsets.only(right: 15, bottom: 20),
        duration: Duration(seconds: 1),
        child: ElevatedButton(
          onPressed: () {
            onSubmitted();
          },
          child: Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: .5,
              fontSize: StudentLinkTheme().h4,
            ),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(StudentLinkTheme().primary1),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ))),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        automaticallyImplyLeading: false,
        title: Text(
          widget.studentName,
          style: TextStyle(
              color: Colors.black54,
              letterSpacing: .5,
              fontSize: StudentLinkTheme().hdes,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),

            //ID and Date
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: StudentLinkInput(
                    enable: false,
                    lable: 'ID',
                    controller: IdController,
                    keyboard: TextInputType.phone,
                    prefixIcon: Icon(Icons.perm_identity_rounded),
                    maxLength: 10,
                    maxLines: 1,
                    padleft: 0,
                    sufixIcon: SizedBox(),
                    textInputAction: TextInputAction.none,
                    length: 0,
                    regexp: RegExp(''),
                  ), //Container
                ), //Flexible
                SizedBox(
                  width: 10,
                ), //SizedBox
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: StudentLinkInput(
                    padleft: 10,
                    enable: false,
                    lable: 'Date',
                    controller: dateController,
                    keyboard: TextInputType.phone,
                    sufixIcon: Icon(Icons.date_range_rounded),
                    maxLength: 10,
                    maxLines: 1,
                    prefixIcon: SizedBox(),
                    textInputAction: TextInputAction.none,
                    length: 0,
                    regexp: RegExp(''),
                  ), //Container
                ) //Flexible
              ], //<Widget>[]
              mainAxisAlignment: MainAxisAlignment.center,
            ),

            SizedBox(
              height: 10,
            ),

            //Batch
            StudentLinkInput(
              enable: false,
              lable: 'Batch Duration ',
              controller: batchController,
              keyboard: TextInputType.phone,
              prefixIcon: Icon(Icons.date_range_rounded),
              maxLength: 10,
              maxLines: 1,
              padleft: 0,
              sufixIcon: SizedBox(),
              textInputAction: TextInputAction.none,
              length: 0,
              regexp: RegExp(''),
            ),

            SizedBox(
              height: 10,
            ),

            //college
            StudentLinkInput(
              enable: false,
              lable: 'College',
              controller: collegeController,
              keyboard: TextInputType.text,
              prefixIcon: Icon(Icons.cast_for_education_rounded),
              maxLength: 10,
              maxLines: 1,
              padleft: 0,
              sufixIcon: SizedBox(),
              textInputAction: TextInputAction.none,
              length: 0,
              regexp: RegExp(''),
            ),

            SizedBox(
              height: 10,
            ),

            //Admission Startyear and end year
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: StudentLinkInput(
                    enable: false,
                    lable: 'Start year..',
                    controller: admissonamountController,
                    keyboard: TextInputType.phone,
                    prefixIcon: Icon(Icons.perm_identity_rounded),
                    maxLength: 10,
                    maxLines: 1,
                    padleft: 0,
                    sufixIcon: SizedBox(),
                    textInputAction: TextInputAction.none,
                    length: 0,
                    regexp: RegExp(''),
                  ), //Container
                ), //Flexible
                SizedBox(
                  width: 10,
                ), //SizedBox
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: StudentLinkInput(
                    textInputAction: TextInputAction.next,
                    lable: 'End year',
                    hint: paidamountHint,
                    controller: paidamountController,
                    keyboard: TextInputType.phone,
                    prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                    padleft: 0,
                    enable: false,
                    maxLength: 10,
                    maxLines: 1,
                    sufixIcon: SizedBox(),
                    length: 0,
                    regexp: RegExp(''),
                  ), //Container
                ) //Flexible
              ], //<Widget>[]
              mainAxisAlignment: MainAxisAlignment.center,
            ),

            //transaction id
          ],
        ),
      ),
    );
  }

  void onSubmitted() {
    //validation

    GlobalWidget().showToast(msg: 'Please Wait ...');

    var admissioncreateparam = Uri(
      scheme: 'https',
      host: Apis.superlink,
      path: Apis.baselink + Apis.AdmissionList_Url,
      queryParameters: {
        'application_id': widget.id,
        "date": dateController.text.toString(),
      },
    );
    RestApi()
      ..Post(admissioncreateparam).then((value) {
        // print(value);
        GlobalWidget().showToast(
            msg: 'Application Added  for Admission successfully Completed ...');
        ShowLoader().failureshow(
            context,
            'Application Added  for Admission ...',
            () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainAcitivty(
                    choosedFragment: 3,
                  ),
                ),
                (route) => false));
      }).catchError((onError) {
        var error = onError;
        print(error);
        GlobalWidget().showToast(
            msg: 'Application Not Added  ...${onError['response']['msg']}');
        Navigator.pop(context);
      });
  }
}
