import 'dart:convert';
import 'dart:io';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentz_link/Models/applicationshowmodel.dart';
import 'package:studentz_link/Models/getcities.dart';
import 'package:studentz_link/Models/getcountry.dart';
import 'package:studentz_link/Models/getstate.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/application_edit_screen3_doc.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/applicationdetails.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreenTank/applicationshowstream.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/Widgets/input_widget.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/citystream.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/coutrystream.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/statestream.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApplicationShow extends StatefulWidget {
  String applicationid;
  ApplicationShow({
    Key? key,
    required this.applicationid,
  }) : super(key: key);

  @override
  State<ApplicationShow> createState() => _ApplicationShowState();
}

class _ApplicationShowState extends State<ApplicationShow> {
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
  //Showsubmitted application......................
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

  var selectedDate;
  String country = '';
  String state = '';
  String district = '';

  dynamic datePicked;
  //initial load...........
  String firstnamelabel = '';
  String lastnamelabel = '';
  String emaillabel = '';
  String dateofbirth = '';

  String phonenumberlabel = '';

  String parentnamelabel = '';

  String parentnumberlabel = '';

  String addresslabel = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    coutrystream = CountrylistData();
    statestream = StatelistData();
    citystream = CitylistData();
    coutrystream.getcountryslistData();
    statestream.getstatelistData();
    citystream.getcitieslistData();
    applicationshowdata = ApplicationShowData();
    applicationshowdata.getapplicationshowData(
        applicationid: widget.applicationid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateDocuments(
                              application_id: widget.applicationid,
                            )),
                  );
                },
                icon: Icon(
                  Icons.upload_file,
                  color: Colors.grey[800],
                ))
          ],
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
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ApplicationDetails(
                                applicationid: widget.applicationid,
                                applicationstatus: 0,
                              )),
                      (route) => false);
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
        body: StreamBuilder(
            stream: applicationshowdata.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data is ApplicationShowModel) {
                  applicationshowmodel = snapshot.data as ApplicationShowModel;
                  GlobalData.AvatarImgeedit =
                      applicationshowmodel.response.imageUrl.toString();
                  GlobalData.firstnameedit =
                      applicationshowmodel.response.firstName.toString();

                  firstnamelabel = GlobalData.firstnameedit;

                  GlobalData.lastnameedit =
                      applicationshowmodel.response.lastName.toString();
                  lastnamelabel = GlobalData.lastnameedit;

                  GlobalData.emailedit =
                      applicationshowmodel.response.email.toString();
                  emaillabel = GlobalData.emailedit;
                  GlobalData.phonenumberedit =
                      applicationshowmodel.response.phone.toString();
                  phonenumberlabel = GlobalData.phonenumberedit;
                  GlobalData.dateofbirthedit = DateFormat('yyyy-MM-dd')
                      .format(applicationshowmodel.response.dateOfBirth);
                  dateofbirth = GlobalData.dateofbirthedit;
                  GlobalData.parentnameedit =
                      applicationshowmodel.response.parentName.toString();
                  parentnamelabel = GlobalData.parentnameedit;
                  GlobalData.parentphonenumberedit =
                      applicationshowmodel.response.parentPhone.toString();
                  parentnumberlabel = GlobalData.parentphonenumberedit;
                  GlobalData.addressedit =
                      applicationshowmodel.response.address.toString();
                  addresslabel = GlobalData.addressedit;
                  GlobalData.countryedit =
                      applicationshowmodel.response.country;
                  country = GlobalData.countryedit;
                  GlobalData.countryidedit =
                      applicationshowmodel.response.countryId;
                  eachcoutryid = GlobalData.countryidedit;
                  GlobalData.stateedit = applicationshowmodel.response.state;
                  state = GlobalData.stateedit;
                  GlobalData.stateidedit =
                      applicationshowmodel.response.stateId;
                  stateid = GlobalData.stateidedit;
                  GlobalData.cityedit = applicationshowmodel.response.city;
                  district = GlobalData.cityedit;
                  GlobalData.cityidedit = applicationshowmodel.response.cityId;
                  cityid = GlobalData.cityidedit;
                }
              } else {
                return RefreshIndicator(
                  color: StudentLinkTheme().primary1,
                  onRefresh: () => applicationshowdata.getapplicationshowData(
                      applicationid: widget.applicationid),
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
              return Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    //avatar
                    InkWell(
                        onTap: () async {
                          setState(() {
                            GlobalData.AvatarImge = '';
                          });
                          var result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                          );
                          setState(() {
                            GlobalData.AvatarImge = result!.paths[0].toString();
                          });
                          print('selected img${GlobalData.AvatarImge}');
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            radius: 48, // Image radius
                            backgroundImage: FileImage(
                                File(GlobalData.AvatarImge),
                                scale: 1),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              radius: 48,
                              backgroundImage: NetworkImage(
                                  GlobalData.AvatarImgeedit,
                                  scale: 1),
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: StudentLinkInputedit(
                            controller: fnameController1,
                            textInputAction: TextInputAction.next,
                            lable: firstnamelabel,
                            //hint: 'Student',
                            keyboard: TextInputType.name,
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            enable: true,
                            maxLength: 30,
                            maxLines: 1,
                            padleft: 0.0,
                            sufixIcon: SizedBox(),
                            length: 0,
                            regexp: RegExp("[a-zA-Z]"),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: StudentLinkInputedit(
                            controller: LnameController2,
                            textInputAction: TextInputAction.next,
                            lable: lastnamelabel,
                            hint: 'Name',
                            keyboard: TextInputType.name,
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            enable: true,
                            maxLength: 30,
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
                      width: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //email
                    StudentLinkInputedit(
                      controller: EmailController4,
                      textInputAction: TextInputAction.next,
                      lable: emaillabel,
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
                    StudentLinkInputedit(
                      maxLength: 10,
                      controller: PhoneController2,
                      textInputAction: TextInputAction.next,
                      lable: phonenumberlabel,
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
                      Container(
                        height: 40,
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  datePicked == null
                                      ? dateofbirth.toString()
                                      : DateFormat.yMMMEd()
                                          .format(datePicked)
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: StudentLinkTheme().h3,
                                      fontWeight: FontWeight.bold),
                                )),
                            IconButton(
                                onPressed: () async {
                                  datePicked =
                                      await DatePicker.showSimpleDatePicker(
                                    context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(
                                        (DateTime.now().year - 15) - 10,
                                        DateTime.now().month,
                                        DateTime.now().day),
                                    lastDate: DateTime.now(),
                                    dateFormat: 'yyyy-MM-dd',
                                    locale: DateTimePickerLocale.en_us,
                                    looping: true,
                                  );
                                },
                                icon: Icon(Icons.date_range))
                          ],
                        ),
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
                          child: StudentLinkInputedit(
                            controller: PnameController1,
                            textInputAction: TextInputAction.next,
                            lable: parentnamelabel,
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
                          child: StudentLinkInputedit(
                            controller: PnumberController5,
                            textInputAction: TextInputAction.next,
                            lable: parentnumberlabel,
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
                                CountrylistList.add(
                                    countrymodel.response[i].id);
                              }
                              countryid = CountrylistList;
                              print(countryid);
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
                              label: country,
                              onChanged: (value) {},
                            )));
                          }
                          return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GlobalWidget()
                                  .DecorativeContainer(CustomSearchableDropDown(
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                menuMode: true,
                                dropdownItemStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                backgroundColor: Colors.white,
                                dropDownMenuItems:
                                    countrymodel.response.map((e) {
                                          return e.name;
                                        }).toList() ??
                                        [],
                                items: countryid,
                                label: country,
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    countryid.clear();
                                    eachcoutryid = value;
                                  });
                                  statestream.getstatelistData(
                                      country_code: value.toString());
                                },
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  backgroundColor: Colors.white,
                                  dropDownMenuItems: [],
                                  items: [],
                                  label: state,
                                  onChanged: (value) {},
                                )));
                              }
                              return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: GlobalWidget().DecorativeContainer(
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
                                        staemodel.response.map((e) {
                                              return e.name;
                                            }).toList() ??
                                            [],
                                    items: Stateid,
                                    label: state,
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        Stateid.clear();
                                        stateid = value;
                                      });
                                      citystream.getcitieslistData(
                                          state_code: value.toString());
                                    },
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  backgroundColor: Colors.white,
                                  dropDownMenuItems: [],
                                  items: [],
                                  label: district,
                                  onChanged: (value) {},
                                )));
                              }
                              return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: GlobalWidget().DecorativeContainer(
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
                                        citymodel.response.map((e) {
                                              return e.city.toString();
                                            }).toList() ??
                                            [],
                                    items: Cityid,
                                    label: district,
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        Cityid.clear();
                                        cityid = value;
                                      });
                                    },
                                  )));
                            })
                        : Container(),

                    SizedBox(
                      height: 5,
                    ),

                    //address
                    StudentLinkInputedit(
                      controller: AddressController11,
                      textInputAction: TextInputAction.newline,
                      lable: addresslabel,
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
                    ElevatedButton(
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
                        'Update Application',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontWeight: FontWeight.bold,
                          fontSize: StudentLinkTheme().h2,
                        ),
                      ),
                      onPressed: () {
                        addApplicationForm();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            }));
  }

  Future<void> addApplicationForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GlobalWidget().showToast(msg: 'Please Wait...');

    var postUri = Uri.parse(
        "https://admission.studentzlink.com/api/v1/saleteam/update-application");
    var request = new http.MultipartRequest("POST", postUri);
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('accessToken')}',
    });

    request.fields['id'] = widget.applicationid;
    request.fields['college_id'] = GlobalData.collegeidedit;
    request.fields['course_id'] = GlobalData.courseidedit;
    request.fields['batch_id'] = GlobalData.batchidedit;
    request.fields['first_name'] = fnameController1.text.isEmpty
        ? firstnamelabel
        : fnameController1.text.toString();
    request.fields['last_name'] = LnameController2.text.isEmpty
        ? lastnamelabel
        : LnameController2.text.toString();
    request.fields['email'] = EmailController4.text.isEmpty
        ? emaillabel
        : EmailController4.text.toString();
    request.fields['phone'] = PhoneController2.text.isEmpty
        ? phonenumberlabel
        : PhoneController2.text.toString();
    request.fields['date_of_birth'] =
        datePicked == null ? dateofbirth : datePicked.toString();
    request.fields['address'] = AddressController11.text.isEmpty
        ? addresslabel
        : AddressController11.text.toString();
    request.fields['parent_name'] = PnameController1.text.isEmpty
        ? parentnamelabel
        : PnameController1.text.toString();
    request.fields['parent_phone'] = PnumberController5.text.isEmpty
        ? parentnumberlabel
        : PnumberController5.text.toString();
    request.fields['country'] = eachcoutryid.toString();
    request.fields['state'] = stateid.toString();
    request.fields['city'] = cityid.toString();
    //request.fields['receipt_remark'] = 'dfgdfg';
    GlobalData.receiptprrof != ''
        ? request.files.add(await http.MultipartFile.fromPath(
            'attachment', GlobalData.receiptprrof))
        : null;

    GlobalData.AvatarImge != ''
        ? request.files.add(
            await http.MultipartFile.fromPath('avatar', GlobalData.AvatarImge))
        : null;

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Image Uploaded");
      //GlobalData.clearAll();
      GlobalWidget().showToast(msg: 'Application Update successfully...');

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => ApplicationDetails(
                    applicationid: widget.applicationid,
                    applicationstatus: 0,
                  )),
          (route) => false);
    } else {
      GlobalWidget().showToast(msg: 'Application Update Not successfully...');

      GlobalData.clearAll();
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}
