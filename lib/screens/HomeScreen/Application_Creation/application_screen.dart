import 'dart:convert';
import 'dart:io';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentz_link/Models/getcountry.dart';
import 'package:studentz_link/Models/getstate.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/Widgets/input_widget.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/citystream.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/coutrystream.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/document_upload_page_.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/receiptstream.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/statestream.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../Models/getcities.dart';

import 'package:http/http.dart' as http;

class ApplicationCreationForm extends StatefulWidget {
  const ApplicationCreationForm({Key? key}) : super(key: key);

  @override
  State<ApplicationCreationForm> createState() =>
      _ApplicationCreationFormState();
}

class _ApplicationCreationFormState extends State<ApplicationCreationForm> {
  dynamic globalKey = GlobalKey<ScaffoldState>();
  TextEditingController fnameController1 = TextEditingController();
  TextEditingController LnameController2 = TextEditingController();
  TextEditingController EmailController4 = TextEditingController();
  TextEditingController PhoneController2 = TextEditingController();
  TextEditingController DateController3 = TextEditingController();
  TextEditingController PnameController1 = TextEditingController();
  TextEditingController PnumberController5 = TextEditingController();
  TextEditingController AddressController11 = TextEditingController();

  String? selmonth;
  String? selday;
  String? selyear;
  CountrylistData coutrystream = CountrylistData();
  CountryModel countrymodel = CountryModel(code: 0, response: [], status: '');
  StatelistData statestream = StatelistData();
  StateModel staemodel = StateModel(code: 0, response: [], status: '');
  CitylistData citystream = CitylistData();
  CityModel citymodel = CityModel(code: 0, response: [], status: '');
  GetReceiptstream receiptstream = GetReceiptstream();
  List CountrylistList = [];
  List countryid = [];
  var eachcoutryid;
  List StatelistList = [];
  List Stateid = [];
  var stateid;
  List CitylistLis = [];
  var Cityid;
  var cityid;
  List CitylistList = [];

  dynamic _selectedDate;
  var datePicked;

  var pickeddate;

  bool avatalimage = false;
  bool countrybool = false;
  bool statebool = false;
  bool citybool = false;

  bool dateofbirthbool = false;
  List<bool> isSelected = [true, false];

  dynamic feeselect = null;

  int fee_paid = 0;

  FilePickerResult? resultproofadd;
  TextEditingController remarkcontroller = TextEditingController();

  String receiptproof = '';

  var extention;
  void initState() {
    coutrystream = CountrylistData();
    statestream = StatelistData();
    citystream = CitylistData();
    receiptstream = GetReceiptstream();

    super.initState();
    coutrystream.getcountryslistData();
    statestream.getstatelistData();
    citystream.getcitieslistData();
    isSelected = [false, true];
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: globalKey,
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [],
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              iconSize: 20,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black54,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          automaticallyImplyLeading: false,
          title: Text(
            'Application Form',
            style: TextStyle(
                color: Colors.black54,
                letterSpacing: .5,
                fontSize: StudentLinkTheme().h2,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        body: ProgressHUD(
            child: Builder(
          builder: (context) => Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: RefreshIndicator(
              onRefresh: () => coutrystream.getcountryslistData(),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  //avatar
                  Container(
                    child: InkWell(
                      onTap: () async {
                        var result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                        );
                        setState(() {
                          GlobalData.AvatarImge = result!.paths[0].toString();
                          avatalimage = true;
                        });
                        print('selected img${GlobalData.AvatarImge}');
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: GlobalData.AvatarImge != ''
                            ? Image.file(
                                File(GlobalData.AvatarImge),
                                scale: 10,
                                fit: BoxFit.contain,
                              )
                            : Image.asset(
                                'assets/images/selectprofile.png',
                                color: Colors.red,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 1,
                        child: StudentLinkInput(
                          controller: fnameController1,
                          textInputAction: TextInputAction.next,
                          lable: 'First Name',
                          hint: 'Student',
                          keyboard: TextInputType.name,
                          prefixIcon: Icon(Icons.person_outline_rounded),
                          enable: true,
                          maxLength: 10,
                          maxLines: 1,
                          padleft: 0.0,
                          sufixIcon: SizedBox(),
                          length: 0,
                          regexp: RegExp("[a-zA-Z]"),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 1,
                        child: StudentLinkInput(
                          controller: LnameController2,
                          textInputAction: TextInputAction.next,
                          lable: 'Last Name',
                          hint: 'Name',
                          keyboard: TextInputType.name,
                          prefixIcon: Icon(Icons.person_outline_rounded),
                          enable: true,
                          maxLength: 10,
                          maxLines: 1,
                          padleft: 0.0,
                          sufixIcon: SizedBox(),
                          length: 0,
                          regexp: RegExp("[a-zA-Z]"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //email
                  StudentLinkInput(
                    controller: EmailController4,
                    textInputAction: TextInputAction.next,
                    lable: 'E-mail',
                    hint: '@domain.com',
                    keyboard: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email_outlined),
                    enable: true,
                    maxLength: 30,
                    maxLines: 1,
                    padleft: 0.0,
                    sufixIcon: SizedBox(),
                    length: 0,
                    regexp: RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  //number
                  StudentLinkInput(
                    maxLength: 10,
                    controller: PhoneController2,
                    textInputAction: TextInputAction.next,
                    lable: 'Phone Number',
                    hint: '+ 91',
                    keyboard: TextInputType.phone,
                    prefixIcon: Icon(Icons.phone_android),
                    enable: true,
                    maxLines: 1,
                    padleft: 0.0,
                    sufixIcon: SizedBox(),
                    length: 10,
                    regexp:
                        RegExp(r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //date
                  GlobalWidget().DecorativeContainer(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            datePicked = await DatePicker.showSimpleDatePicker(
                              context,
                              initialDate: DateTime(DateTime.now().year - 10,
                                  DateTime.now().month, DateTime.now().day),
                              firstDate: DateTime(
                                  (DateTime.now().year - 15) - 100,
                                  DateTime.now().month,
                                  DateTime.now().day),
                              lastDate: DateTime(DateTime.now().year - 10,
                                  DateTime.now().month, DateTime.now().day),
                              dateFormat: 'yyyy-MM-dd',
                              locale: DateTimePickerLocale.en_us,
                              looping: true,
                            );
                            setState(() {
                              pickeddate =
                                  DateFormat('yyyy-MM-dd').format(datePicked);
                              dateofbirthbool = true;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      datePicked =
                                          await DatePicker.showSimpleDatePicker(
                                        context,
                                        initialDate: DateTime(
                                            DateTime.now().year - 10,
                                            DateTime.now().month,
                                            DateTime.now().day),
                                        firstDate: DateTime(
                                            (DateTime.now().year - 15) - 100,
                                            DateTime.now().month,
                                            DateTime.now().day),
                                        lastDate: DateTime(
                                            DateTime.now().year - 10,
                                            DateTime.now().month,
                                            DateTime.now().day),
                                        dateFormat: 'yyyy-MM-dd',
                                        locale: DateTimePickerLocale.en_us,
                                        looping: true,
                                      );
                                      setState(() {
                                        pickeddate = DateFormat('yyyy-MM-dd')
                                            .format(datePicked);
                                        dateofbirthbool = true;
                                      });
                                    },
                                    icon: Icon(Icons.date_range)),
                                Container(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: pickeddate == null
                                        ? Text(
                                            'Date of Birth',
                                            style: TextStyle(
                                              fontSize: StudentLinkTheme().h3,
                                            ),
                                          )
                                        : Text(
                                            pickeddate.toString(),
                                            style: TextStyle(
                                                fontSize: StudentLinkTheme().h3,
                                                fontWeight: FontWeight.bold),
                                          )),
                              ],
                            ),
                          ),
                        ),
                        pickeddate == null
                            ? Divider(
                                color: Colors.red,
                                height: 6,
                                thickness: 1,
                              )
                            : SizedBox(),
                        pickeddate == null
                            ? Text(
                                "Can't be Empty",
                                style: TextStyle(color: Colors.red),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //Parent number and name
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 1,
                        child: StudentLinkInput(
                          controller: PnameController1,
                          textInputAction: TextInputAction.next,
                          lable: 'Parent Name',
                          hint: 'Parent',
                          keyboard: TextInputType.name,
                          prefixIcon: Icon(Icons.person_outline_rounded),
                          enable: true,
                          maxLines: 1,
                          padleft: 0.0,
                          sufixIcon: SizedBox(),
                          maxLength: 15,
                          length: 0,
                          regexp: RegExp("[a-zA-Z]"),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 1,
                        child: StudentLinkInput(
                          controller: PnumberController5,
                          textInputAction: TextInputAction.next,
                          lable: 'Parent Number',
                          hint: '+ 91',
                          keyboard: TextInputType.phone,
                          prefixIcon: Icon(Icons.phone_android),
                          enable: true,
                          maxLines: 1,
                          padleft: 0.0,
                          sufixIcon: SizedBox(),
                          maxLength: 10,
                          length: 10,
                          regexp: RegExp(
                              r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //Country
                  StreamBuilder(
                      stream: coutrystream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data is CountryModel) {
                            countrymodel = snapshot.data as CountryModel;
                            for (int i = 0;
                                i < countrymodel.response.length;
                                i++) {
                              CountrylistList.add(countrymodel.response[i].id);
                            }
                            countryid = CountrylistList;
                            print(countryid);
                          }
                        } else {
                          return Center(
                              child: GlobalWidget()
                                  .DecorativeContainer(CustomSearchableDropDown(
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            hideSearch: true,
                            menuMode: true,
                            dropdownItemStyle:
                                TextStyle(fontWeight: FontWeight.bold),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            backgroundColor: Colors.white,
                            dropDownMenuItems: [],
                            items: [],
                            label: 'Country',
                            onChanged: (value) {
                              coutrystream.getcountryslistData();
                            },
                          )));
                        }
                        return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GlobalWidget().DecorativeContainer(Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomSearchableDropDown(
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  menuMode: true,
                                  dropdownItemStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  backgroundColor: Colors.white,
                                  dropDownMenuItems:
                                      countrymodel.response.map((e) {
                                            return e.name;
                                          }).toList() ??
                                          [],
                                  items: countryid,
                                  label: 'Country',
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      countryid.clear();
                                      eachcoutryid = value;
                                      countrybool = true;
                                      statestream.getstatelistData(
                                          country_code: value.toString());
                                    });
                                  },
                                ),
                                eachcoutryid == null
                                    ? Divider(
                                        color: Colors.red,
                                        height: 6,
                                        thickness: 1,
                                      )
                                    : SizedBox(),
                                eachcoutryid == null
                                    ? Text(
                                        "Can't be Empty",
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : SizedBox()
                              ],
                            )));
                      }),
                  //State
                  eachcoutryid != 0
                      ? StreamBuilder(
                          stream: statestream.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data is StateModel) {
                                staemodel = snapshot.data as StateModel;
                                for (int i = 0;
                                    i < staemodel.response.length;
                                    i++) {
                                  StatelistList.add(staemodel.response[i].id);
                                }
                                Stateid = StatelistList;
                                print(Stateid);
                              }
                            } else {
                              return Center(
                                  child: GlobalWidget().DecorativeContainer(
                                      CustomSearchableDropDown(
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                hideSearch: true,
                                menuMode: true,
                                dropdownItemStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                backgroundColor: Colors.white,
                                dropDownMenuItems: [],
                                items: [],
                                label: 'State',
                                onChanged: (value) {},
                              )));
                            }
                            return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child:
                                    GlobalWidget().DecorativeContainer(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomSearchableDropDown(
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      menuMode: true,
                                      dropdownItemStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      backgroundColor: Colors.white,
                                      dropDownMenuItems:
                                          staemodel.response.map((e) {
                                                return e.name;
                                              }).toList() ??
                                              [],
                                      items: Stateid,
                                      label: 'State',
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          Stateid.clear();
                                          stateid = value;
                                          statebool = true;
                                          citystream.getcitieslistData(
                                              state_code: value.toString());
                                        });
                                      },
                                    ),
                                    stateid == null
                                        ? Divider(
                                            color: Colors.red,
                                            height: 6,
                                            thickness: 1,
                                          )
                                        : SizedBox(),
                                    stateid == null
                                        ? Text(
                                            "Can't be Empty",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : SizedBox()
                                  ],
                                )));
                          })
                      : Container(),
                  //City

                  stateid != 0
                      ? StreamBuilder(
                          stream: citystream.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data is CityModel) {
                                citymodel = snapshot.data as CityModel;
                                for (int i = 0;
                                    i < citymodel.response.length;
                                    i++) {
                                  CitylistList.add(citymodel.response[i].id);
                                }
                                Cityid = CitylistList;
                                print(Cityid);
                              }
                            } else {
                              return Center(
                                  child: GlobalWidget().DecorativeContainer(
                                      CustomSearchableDropDown(
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                hideSearch: true,
                                menuMode: true,
                                dropdownItemStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                backgroundColor: Colors.white,
                                dropDownMenuItems: [],
                                items: [],
                                label: 'City',
                                onChanged: (value) {},
                              )));
                            }
                            return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child:
                                    GlobalWidget().DecorativeContainer(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomSearchableDropDown(
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      menuMode: true,
                                      dropdownItemStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      backgroundColor: Colors.white,
                                      dropDownMenuItems:
                                          citymodel.response.map((e) {
                                                return e.city.toString();
                                              }).toList() ??
                                              [],
                                      items: Cityid,
                                      label: 'City',
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          Cityid.clear();
                                          cityid = value;
                                          citybool = true;
                                        });
                                      },
                                    ),
                                    cityid == null
                                        ? Divider(
                                            color: Colors.red,
                                            height: 6,
                                            thickness: 1,
                                          )
                                        : SizedBox(),
                                    cityid == null
                                        ? Text(
                                            "Can't be Empty",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : SizedBox()
                                  ],
                                )));
                          })
                      : Container(),

                  SizedBox(
                    height: 5,
                  ),
                  GlobalWidget().DecorativeContainer(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Collect Application fee Now ?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ToggleButtons(
                              borderColor: Colors.grey,
                              fillColor: StudentLinkTheme().primary1,
                              borderWidth: 1,
                              selectedBorderColor: Colors.grey,
                              selectedColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'No',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                              onPressed: (int index) {
                                setState(() {
                                  for (int i = 0; i < isSelected.length; i++) {
                                    feeselect = isSelected[i] = i == index;
                                  }
                                });
                                //select fee paid or not
                                if (feeselect == false) {
                                  setState(() {
                                    GlobalData.feepaid = '1';
                                  });
                                } else {
                                  setState(() {
                                    GlobalData.feepaid = '0';
                                  });
                                }

                                print(feeselect);
                              },
                              isSelected: isSelected,
                            ),
                          ],
                        ),
                      ),
                      GlobalData.feepaid == '1'
                          ? Container(
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Upload proof',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      StreamBuilder(
                                          stream: receiptstream.stream,
                                          builder: (context, snapshot) {
                                            return snapshot.data == null
                                                ? GlobalWidget()
                                                    .DecorativeContainer(
                                                        IconButton(
                                                            onPressed:
                                                                () async {
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
                                                              receiptstream.geteditreceipt(
                                                                  receipt:
                                                                      resultproofadd!
                                                                          .files[
                                                                              0]
                                                                          .path);
                                                              setState(() {
                                                                GlobalData
                                                                        .receiptprrof =
                                                                    resultproofadd!
                                                                        .paths[
                                                                            0]
                                                                        .toString();
                                                                extention =
                                                                    resultproofadd!
                                                                        .paths[
                                                                            0]
                                                                        .toString()
                                                                        .split(
                                                                            '.')
                                                                        .last
                                                                        .toString();
                                                              });
                                                            },
                                                            icon: Icon(
                                                                Icons.add)))
                                                : Row(
                                                    children: [
                                                      Icon(Icons.check),
                                                      InkWell(
                                                        child: extention ==
                                                                    'jpg' ||
                                                                extention ==
                                                                    'png' ||
                                                                extention ==
                                                                    'jpeg'
                                                            ? GlobalWidget()
                                                                .DecorativeContainer(
                                                                    Container(
                                                                height: 80,
                                                                width: 80,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image: FileImage(File(snapshot
                                                                          .data
                                                                          .toString()))),
                                                                  shape: ContinuousRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      side: BorderSide(
                                                                          width:
                                                                              2.0,
                                                                          color:
                                                                              Color(0xFFE4E4E4))),
                                                                ),
                                                              ))
                                                            : Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                children: [
                                                                  GlobalWidget()
                                                                      .DecorativeContainer(
                                                                          Container(
                                                                    height: 80,
                                                                    width: 80,
                                                                    child: SfPdfViewer.file(File(
                                                                        snapshot
                                                                            .data
                                                                            .toString())),
                                                                  )),
                                                                  CircleAvatar(
                                                                    child: IconButton(
                                                                        onPressed: () {
                                                                          showBarModalBottomSheet(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            context:
                                                                                context,
                                                                            builder: (context) =>
                                                                                Container(
                                                                              height: 600,
                                                                              width: width,
                                                                              child: SfPdfViewer.file(File(snapshot.data.toString())),
                                                                            ),
                                                                          );
                                                                        },
                                                                        icon: Icon(Icons.expand)),
                                                                  )
                                                                ],
                                                              ),
                                                        onTap: () {
                                                          showBarModalBottomSheet(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              context: context,
                                                              builder: (context) => extention == 'jpg' ||
                                                                      extention ==
                                                                          'png' ||
                                                                      extention ==
                                                                          'jpeg'
                                                                  ? Container(
                                                                      height:
                                                                          600,
                                                                      width:
                                                                          width,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              image: DecorationImage(
                                                                        image: FileImage(File(snapshot
                                                                            .data
                                                                            .toString())),
                                                                      )),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          600,
                                                                      width:
                                                                          width,
                                                                      child: SfPdfViewer.file(File(snapshot
                                                                          .data
                                                                          .toString())),
                                                                    ));
                                                        },
                                                      ),
                                                    ],
                                                  );
                                          })
                                    ],
                                  )
                                ],
                              ),
                            )
                          : SizedBox()
                    ],
                  )),
                  SizedBox(
                    height: 5,
                  ),

                  //address
                  StudentLinkInput(
                    controller: AddressController11,
                    textInputAction: TextInputAction.newline,
                    lable: 'Address',
                    maxLines: 5,
                    hint: 'PT Nagar Lane 1, Kovilakam ...',
                    keyboard: TextInputType.multiline,
                    prefixIcon: Icon(Icons.location_city_outlined),
                    enable: true,
                    padleft: 0.0,
                    sufixIcon: SizedBox(),
                    maxLength: 60,
                    length: 0,
                    regexp: RegExp(''),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            StudentLinkTheme().primary1),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Create Application',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: StudentLinkTheme().h2,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          GlobalData.firstname = fnameController1.text;
                          GlobalData.lastname = LnameController2.text;
                          GlobalData.email = EmailController4.text;
                          GlobalData.phonenumber = PhoneController2.text;
                          GlobalData.dateofbirth = datePicked.toString();
                          GlobalData.parentname = PnameController1.text;
                          GlobalData.parentphone = PnumberController5.text;
                          GlobalData.country = eachcoutryid.toString();
                          GlobalData.state = stateid.toString();
                          GlobalData.district = cityid.toString();
                          GlobalData.address = AddressController11.text;
                        });
                        if (avatalimage == false) {
                          GlobalWidget()
                              .showToast(msg: 'Please select profile photo');
                        } else if (GlobalData.firstname == '')
                          GlobalWidget().showToast(msg: 'Enter first name');
                        else if (RegExp(r"^[\p{L} ,.'-]*$",
                                    caseSensitive: false,
                                    unicode: true,
                                    dotAll: true)
                                .hasMatch(GlobalData.firstname) ==
                            false)
                          GlobalWidget()
                              .showToast(msg: 'Enter valid first name');
                        //     () => Navigator.pop(context));
                        else if (GlobalData.lastname == '')
                          GlobalWidget().showToast(msg: 'Enter last name');
                        else if (RegExp(r"^[\p{L} ,.'-]*$",
                                    caseSensitive: false,
                                    unicode: true,
                                    dotAll: true)
                                .hasMatch(GlobalData.lastname) ==
                            false)
                          GlobalWidget()
                              .showToast(msg: 'Enter valid last name');
                        else if (GlobalData.email == '')
                          GlobalWidget().showToast(msg: 'Enter  email');
                        else if (RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(GlobalData.email) ==
                            false)
                          GlobalWidget().showToast(msg: 'Enter valid email');
                        else if (GlobalData.phonenumber == '')
                          GlobalWidget().showToast(msg: 'Enter phone nuber');
                        else if (PhoneController2.text.length != 10)
                          GlobalWidget().showToast(
                              msg: 'Mobile Number must be of 10 digit');
                        else if (dateofbirthbool == false)
                          GlobalWidget()
                              .showToast(msg: 'Please select date of birth');
                        else if (GlobalData.parentname == '')
                          GlobalWidget().showToast(msg: 'Parent name');
                        else if (GlobalData.parentphone == '')
                          GlobalWidget()
                              .showToast(msg: 'Enter parent phone No');
                        else if (PnumberController5.text.length != 10)
                          GlobalWidget().showToast(
                              msg: 'Mobile Number must be of 10 digit');
                        else if (countrybool == false)
                          GlobalWidget().showToast(msg: 'Select Country');
                        else if (statebool == false)
                          GlobalWidget().showToast(msg: 'Select State');
                        else if (citybool == false)
                          GlobalWidget().showToast(msg: 'Select city');
                        else if (GlobalData.feepaid == '1' &&
                            GlobalData.receiptprrof == '')
                          GlobalWidget()
                              .showToast(msg: 'Please upload receipt');
                        else if (GlobalData.address == '') {
                          GlobalWidget().showToast(msg: 'Enete Address');
                        } else {
                          final progress = ProgressHUD.of(context);
                          progress!.showWithText(
                            'Loading...',
                          );
                          addApplicationForm().then((value) {
                            progress.dismiss();
                          }).onError((error, stackTrace) {
                            progress.dismiss();
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        )));
  }

  Future<void> addApplicationForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var postUri = Uri.parse(
        "https://admission.studentzlink.com/api/v1/saleteam/application");
    var request = http.MultipartRequest("POST", postUri);
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('accessToken')}',
    });
    request.fields['college_id'] = GlobalData.college_id_create;
    request.fields['course_id'] = GlobalData.course_id_create;
    request.fields['batch_id'] = GlobalData.batch_id_create;
    request.fields['first_name'] = GlobalData.firstname;
    request.fields['last_name'] = GlobalData.lastname;
    request.fields['email'] = GlobalData.email;
    request.fields['phone'] = GlobalData.phonenumber;
    request.fields['date_of_birth'] = GlobalData.dateofbirth;
    request.fields['address'] = GlobalData.address;
    request.fields['parent_name'] = GlobalData.parentname;
    request.fields['parent_phone'] = GlobalData.parentphone;
    request.fields['country'] = GlobalData.country;
    request.fields['state'] = GlobalData.state;
    request.fields['city'] = GlobalData.district;
    request.fields['fee_paid'] = GlobalData.feepaid;
    request.fields['address'] = GlobalData.address;
    request.fields['commission'] = GlobalData.commission;
    GlobalData.receiptprrof != ''
        ? request.files.add(await http.MultipartFile.fromPath(
            'attachment', GlobalData.receiptprrof))
        : null;
    request.files.add(
        await http.MultipartFile.fromPath('avatar', GlobalData.AvatarImge));
    var response = await request.send();
    print('image${response.statusCode}');
    if (response.statusCode == 200) {
      print(response);
      var onData = await response.stream.transform(utf8.decoder).first;
      List ononData = [];
      ononData.add(json.decode(onData));

      print("dynamicCallApi RESPONSE : $onData");
      GlobalWidget().showSnackBar(globalKey, 'Application create successfully');
      print(ononData[0]['response']);
      ononData[0]['response'] != null
          ? ShowLoader().failureshow(
              context,
              ' Application created "Please upload documents" ',
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => DocumentUploadForm(
                            applicationid: ononData[0]['response'],
                          )))))
          : GlobalWidget().showSnackBar(globalKey, 'Application id is empty');
      ;
      GlobalData.clearAll();
    } else {
      print("Upload Failed");
      print(response.statusCode);
      GlobalWidget().showSnackBar(globalKey, 'Application Upload failed');
    }
  }
}
