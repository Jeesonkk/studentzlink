import 'dart:convert';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';

import 'package:intl/intl.dart';
import 'package:studentz_link/Models/rolelist.dart';
import 'package:studentz_link/Models/teamlist.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen/taskpage.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/taskrolesliststream.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/taskteamliststream.dart';
import 'package:studentz_link/screens/HomeScreen/main_activity.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

class PostTask extends StatefulWidget {
  PostTask({Key? key}) : super(key: key);

  @override
  State<PostTask> createState() => _PostTaskState();
}

class _PostTaskState extends State<PostTask> {
  RoleslistData rolesliststream = RoleslistData();
  TeamlistData teamliststream = TeamlistData();
  RoleListModel rolesmodel = RoleListModel(code: 0, response: [], status: '');
  TeamListModel teammodel = TeamListModel(code: 0, response: [], status: '');

  String? selectedTime;
  var dt = DateTime.now();

  int currentmonth = 0;
  int currentyear = 0;
  int currentday = 0;
  TextEditingController name_controller = TextEditingController();
  TextEditingController task_controller = TextEditingController();

  List RolelistList = [];
  List Roleid = [];
  List TeamlistList = [];

  String roleid = '';
  List teamidlist = [];
  int teamid = 0;

  String? selday;
  String? selmonth;
  String? selyear;

  bool dismiss = false;

  var pickeddate;

  dynamic datePicked;

  bool dateofbirthbool = false;

  @override
  void initState() {
    // TODO: implement initState
    selectedTime = DateFormat('kk:mm a').format(dt);
    currentmonth = dt.month;
    currentyear = dt.year;
    currentday = dt.day;
    rolesliststream = RoleslistData();
    teamliststream = TeamlistData();
    rolesliststream.getroleslistData();
    super.initState();
  }

  final ShowLoader showLoader = ShowLoader();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10),
      color: StudentLinkTheme().primary1,
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //date
              GlobalWidget().DecorativeContainer(
                Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          datePicked = await DatePicker.showSimpleDatePicker(
                            context,
                            initialDate: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day),
                            firstDate: DateTime((DateTime.now().year),
                                DateTime.now().month, DateTime.now().day),
                            lastDate: DateTime(DateTime.now().year + 3,
                                DateTime.now().month + 12, DateTime.now().day),
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
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day),
                                      firstDate: DateTime(
                                          (DateTime.now().year),
                                          DateTime.now().month,
                                          DateTime.now().day),
                                      lastDate: DateTime(
                                          DateTime.now().year + 3,
                                          DateTime.now().month + 12,
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
                                  padding: EdgeInsets.only(
                                      left: 10, top: 10, right: 45),
                                  child: pickeddate == null
                                      ? Text(
                                          'Date',
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
                              'Can,t be Empty',
                              style: TextStyle(color: Colors.red),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
              //SizedBox(width: 3),
              //time
              // Expanded(
              //   child: Container(
              //     width: 80,
              //     height: 67,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       border: Border.all(color: Colors.white),
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     child: MaterialButton(
              //         child: Text(selectedTime.toString()),
              //         onPressed: () {
              //           showCustomTimePicker(
              //               context: context,
              //               // It is a must if you provide selectableTimePredicate
              //               onFailValidation: (context) =>
              //                   print('Unavailable selection'),
              //               initialTime: TimeOfDay(hour: 1, minute: 0),
              //               selectableTimePredicate: (time) =>
              //                   time!.hour > 0 &&
              //                   time.hour < 24 &&
              //                   time.minute % 1 == 0).then((time) => setState(
              //               () => selectedTime = time?.format(context)));
              //         }),
              //   ),
              // )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          //name
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              controller: name_controller,
              cursorColor: StudentLinkTheme().primary1,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                prefixIcon: Icon(Icons.title, color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                hintText: 'Task name',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                isDense: true,
              ),
            ),
          ),
          // //task
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 5,
              controller: task_controller,
              cursorColor: StudentLinkTheme().primary1,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                prefixIcon: Icon(Icons.edit, color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                hintText: 'Task details',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                isDense: true,
              ),
            ),
          ),
          StreamBuilder(
              stream: rolesliststream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data is RoleListModel) {
                    rolesmodel = snapshot.data as RoleListModel;
                    for (int i = 0; i < rolesmodel.response.length; i++) {
                      RolelistList.add(rolesmodel.response[i].name);
                    }
                    Roleid = RolelistList;
                    print(Roleid);
                  }
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        StudentLinkTheme().primary1),
                  ));
                }
                return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CustomSearchableDropDown(
                      menuMode: true,
                      dropdownItemStyle: TextStyle(fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: Colors.white,
                      dropDownMenuItems: Roleid.map((e) {
                            return e;
                          }).toList() ??
                          [],
                      items: Roleid,
                      label: 'Assigned team to',
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          Roleid.clear();
                          roleid = value;
                          teamliststream.getroleslistData(rolenamefroui: value);
                        });
                      },
                    ));
              }),
          roleid != ''
              ? StreamBuilder(
                  stream: teamliststream.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data is TeamListModel) {
                        teammodel = snapshot.data as TeamListModel;
                        for (int i = 0; i < teammodel.response.length; i++) {
                          teamidlist.add(teammodel.response[i].id);
                        }
                      }
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            StudentLinkTheme().primary1),
                      ));
                    }
                    return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CustomSearchableDropDown(
                          menuMode: true,
                          dropdownItemStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          backgroundColor: Colors.white,
                          dropDownMenuItems: teammodel.response.map((e) {
                                return e.name;
                              }).toList() ??
                              [],
                          items: teammodel.response.map((e) {
                            return e.id;
                          }).toList(),
                          label: 'Assigned to',
                          onChanged: (value) {
                            print(value);

                            setState(() {
                              teamid = value;
                              TeamlistList.clear();
                            });
                          },
                        ));
                  })
              : Container(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: Text(
              'Add Task',
              style: TextStyle(
                color: StudentLinkTheme().primary1,
                letterSpacing: .5,
                fontWeight: FontWeight.bold,
                fontSize: StudentLinkTheme().h2,
              ),
            ),
            onPressed: () {
              if (pickeddate == null)
                showLoader.failureshow(context, 'Please select date',
                    () => Navigator.pop(context));
              else if (name_controller.text.isEmpty)
                showLoader.failureshow(context, 'Please enter task name',
                    () => Navigator.pop(context));
              else if (task_controller.text.isEmpty)
                showLoader.failureshow(context, 'Please enter task description',
                    () => Navigator.pop(context));
              else if (teamid == 0)
                showLoader.failureshow(context, 'Please select assigned user',
                    () => Navigator.pop(context));
              else {
                DateTime date = DateFormat.jm().parse(selectedTime.toString());
                var body = {
                  'name': name_controller.text.toString(),
                  'task': task_controller.text.toString(),
                  'assigned_to': teamid.toString(),
                  'date': pickeddate,
                  'time': DateFormat("HH:mm").format(date).toString(),
                };

                var User_parm = Uri(
                  scheme: 'https',
                  host: Apis.superlink,
                  path: Apis.baselink + Apis.addtask,
                );
                RestApi().Post(User_parm, body).then((onValue) {
                  print(onValue['response']['msg']);
                  showLoader.successshow(context, onValue['response']['msg']);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainAcitivty(
                                choosedFragment: 1,
                              )),
                      (route) => false);

                  name_controller.text = '';
                  task_controller.text = '';
                }).catchError((onError) {
                  print(onError);
                  showLoader.failureshow(context, onError.toString(),
                      () => Navigator.pop(context));
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
