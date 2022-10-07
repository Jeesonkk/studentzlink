import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:studentz_link/Models/batchModel.dart';
import 'package:studentz_link/Models/college.dart';
import 'package:studentz_link/Models/course.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/applications_edit_screen2.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/batchstream.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/collegedatastreem.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/coursedatastream.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class ApplicationEdit extends StatefulWidget {
  String college, course, applicationid, college_id, course_id, batch_id;
  ApplicationEdit(
      {Key? key,
      required this.college,
      required this.course,
      required this.applicationid,
      required this.course_id,
      required this.college_id,
      required this.batch_id})
      : super(key: key);

  @override
  State<ApplicationEdit> createState() => _ApplicationEditState();
}

class _ApplicationEditState extends State<ApplicationEdit> {
  CollegelistData collegestream = CollegelistData();
  CourselistData courseliststream = CourselistData();
  CourseModel courselistmodel = CourseModel(code: 0, response: [], status: '');
  CollegeModel collegelistmodel =
      CollegeModel(code: 0, response: [], status: '');
  //BatchStream
  BatchlistData batchstream = BatchlistData();
  BatchModel batchmodel = BatchModel(code: 0, response: [], status: '');

  TextEditingController collegecontroller = TextEditingController();
  TextEditingController coursecontroller = TextEditingController();
  List CollegelistList = [];

  List collegeidlistid = [];

  var collegeid;
  bool changecollegebool = false;

  List courseidlistid = [];

  List CourselistList = [];

  bool changecourseebool = false;

  var courseid;

  var batchid;

  List batchlist = [];

  @override
  void initState() {
    collegestream = CollegelistData();
    courseliststream = CourselistData();
    collegestream.getCollegelistData('');
    courseliststream.getCourselistData(college_id: '');
    batchstream = BatchlistData();
    collegecontroller.text = widget.college;
    coursecontroller.text = widget.course;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey[800],
              )),
          title: Text(
            'Update College and Course',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey[800]),
          )),
      floatingActionButton: AnimatedContainer(
        height: 45,
        margin: EdgeInsets.only(right: 15, bottom: 20),
        duration: Duration(seconds: 1),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              courseid != null
                  ? GlobalData.courseidedit = courseid.toString()
                  : GlobalData.courseidedit = widget.course_id;
              collegeid != null
                  ? GlobalData.collegeidedit = collegeid.toString()
                  : GlobalData.collegeidedit = widget.college_id;
              batchid != null
                  ? GlobalData.batchidedit = batchid.toString()
                  : GlobalData.batchidedit = widget.batch_id;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ApplicationShow(
                        applicationid: widget.applicationid,
                      )),
            );
          },
          child: Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: .5,
              fontWeight: FontWeight.bold,
              fontSize: StudentLinkTheme().h2,
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
      body: SafeArea(
        child: Center(
          child: Container(
            height: 600,
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //college show..........

                SizedBox(
                  height: 7,
                ),
                GlobalWidget().DecorativeContainer(
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 220,
                          child: TextField(
                            controller: collegecontroller,
                            enabled: false,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              collegestream.getCollegelistData('');
                              setState(() {
                                changecollegebool = true;
                              });
                            },
                            icon: Icon(Icons.update))
                      ],
                    ),
                  ),
                ),
                //College Change.............
                changecollegebool == true
                    ? StreamBuilder(
                        stream: collegestream.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data is CollegeModel) {
                              collegelistmodel = snapshot.data as CollegeModel;
                              for (int i = 0;
                                  i < collegelistmodel.response.length;
                                  i++) {
                                CollegelistList.add({
                                  'college_id': collegelistmodel.response[i].id,
                                  'college_name':
                                      collegelistmodel.response[i].name
                                });
                              }
                              collegeidlistid = CollegelistList;
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
                              label: 'College',
                              onChanged: (value) {},
                            )));
                          }
                          return SafeArea(
                            child: Padding(
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
                                      collegelistmodel.response.map((e) {
                                            return e.name;
                                          }).toList() ??
                                          [],
                                  items: collegeidlistid,
                                  label: 'College',
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      collegeidlistid.clear();
                                      changecollegebool = false;
                                      collegeid = value['college_id'];
                                      collegecontroller.text =
                                          value['college_name'];
                                    });

                                    courseliststream.getCourselistData(
                                        college_id: collegeid.toString());
                                  },
                                ))),
                          );
                        })
                    : SizedBox(),
                //cousre show.............
                GlobalWidget().DecorativeContainer(
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 220,
                          child: TextField(
                            controller: coursecontroller,
                            enabled: false,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              courseliststream.getCourselistData(
                                  college_id: collegeid.toString());
                              collegeid != null
                                  ? setState(() {
                                      changecourseebool = true;
                                    })
                                  : null;
                            },
                            icon: Icon(Icons.update))
                      ],
                    ),
                  ),
                ),
                //course change.........................
                changecourseebool == true
                    ? StreamBuilder(
                        stream: courseliststream.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data is CourseModel) {
                              courselistmodel = snapshot.data as CourseModel;
                              for (int i = 0;
                                  i < courselistmodel.response.length;
                                  i++) {
                                CourselistList.add({
                                  'course_id': courselistmodel.response[i].id,
                                  'course_name':
                                      courselistmodel.response[i].name,
                                });
                              }
                              courseidlistid = CourselistList;
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
                              label: 'Course',
                              onChanged: (value) {},
                            )));
                          }
                          return SafeArea(
                            child: Padding(
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
                                      courselistmodel.response.map((e) {
                                            return e.name;
                                          }).toList() ??
                                          [],
                                  items: courseidlistid,
                                  label: 'Course',
                                  onChanged: (value) {
                                    print(value);
                                    batchstream.getbatchlistData(
                                        course_id:
                                            value['course_id'].toString());
                                    setState(() {
                                      courseidlistid.clear();
                                      changecourseebool = false;
                                      courseid = value['course_id'];
                                      coursecontroller.text =
                                          value['course_name'];
                                      //batchid = value['batch_id'];
                                    });

                                    courseliststream.getCourselistData(
                                        college_id: collegeid.toString());
                                  },
                                ))),
                          );
                        })
                    : SizedBox(),
                SizedBox(
                  height: 5,
                ),
                //Batch
                courseid != null
                    ? StreamBuilder(
                        stream: batchstream.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data is BatchModel) {
                              batchmodel = snapshot.data as BatchModel;
                              for (int j = 0;
                                  j < batchmodel.response.length;
                                  j++) {
                                batchlist.add({
                                  'batch_id': batchmodel.response[j].id,
                                  'batch_name': batchmodel.response[j].name
                                });
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
                          return GlobalWidget()
                              .DecorativeContainer(CustomSearchableDropDown(
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            menuMode: true,
                            dropdownItemStyle:
                                TextStyle(fontWeight: FontWeight.bold),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            backgroundColor: Colors.white,
                            dropDownMenuItems:
                                batchlist.map((e) => e['batch_name']).toList(),
                            items: batchlist.map((e) => e['batch_id']).toList(),
                            label: 'Batch',
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                batchlist.clear();
                                GlobalData.batch_id_create = value.toString();
                                batchid = GlobalData.batch_id_create;
                              });

                              //courseliststream.getCourselistData(college_id: collegeid.toString());
                            },
                          ));
                        })
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
