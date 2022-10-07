import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:studentz_link/Models/addedbymeshowmodel.dart';
import 'package:studentz_link/Models/rolelist.dart';
import 'package:studentz_link/Models/teamlist.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/taskrolesliststream.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/taskshowstream.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/taskteamliststream.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class TaskAddedToMeShow extends StatefulWidget {
  String taskname;
  TaskAddedToMeShow({Key? key, required this.taskname}) : super(key: key);

  @override
  State<TaskAddedToMeShow> createState() => _TaskAddedToMeShowState();
}

class _TaskAddedToMeShowState extends State<TaskAddedToMeShow> {
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController RemarkController = TextEditingController();
  AddedbymeShowModel addedbymeshowmodel = AddedbymeShowModel(
      code: 0,
      response: TaskShowResponse(
          assignedTo: 0,
          createdAt: 0,
          createdBy: 0,
          date: '',
          id: 0,
          name: '',
          status: '',
          task: '',
          time: '',
          updatedAt: null,
          remarks: '',
          updatedBy: 0,
          history: [],
          assignedToUser: ''),
      status: '');

  TaskshowtData taskshowstream = TaskshowtData();
  RoleslistData rolesliststream = RoleslistData();
  TeamlistData teamliststream = TeamlistData();
  RoleListModel rolesmodel = RoleListModel(code: 0, response: [], status: '');
  TeamListModel teammodel = TeamListModel(code: 0, response: [], status: '');

  String taskid0 = '';
  String status = '';
  String? dropdwonvalue;
  Object? selectedValue;
  String statusupdate = '';
  List RolelistList = [];
  List Roleid = [];
  String roleid = '';
  List teamidlist = [];
  String teamid = '';
  bool feeselect = false;
  String wantreasign = '0';
  final ShowLoader showLoader = ShowLoader();
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
            "Pending",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          value: "Pending"),
      DropdownMenuItem(
          child: Text(
            "Completed",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          value: "Completed"),
    ];
    return menuItems;
  }

  List<bool> isSelected = [];
  @override
  void initState() {
    taskid0 = GlobalData.taskidbyme;
    taskshowstream = TaskshowtData();
    taskshowstream.gettaskshowData(taskid: taskid0);
    rolesliststream = RoleslistData();
    teamliststream = TeamlistData();
    rolesliststream.getroleslistData();
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: globalKey,
        // backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            widget.taskname.toString().toUpperCase(),
            softWrap: true,
            style: TextStyle(
              color: Colors.black87,
              letterSpacing: .5,
              fontWeight: FontWeight.bold,
              fontSize: StudentLinkTheme().h2,
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
        ),
        body: StreamBuilder(
            stream: taskshowstream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data is AddedbymeShowModel) {
                  addedbymeshowmodel = snapshot.data as AddedbymeShowModel;
                }
              } else {
                return snapshot.hasError
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
                      );
              }
              return Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                width: width,
                height: height,
                child: ListView(
                  children: [
                    //head
                    GlobalWidget().DecorativeContainer(
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 17),
                              width: width,
                              child: Text(
                                addedbymeshowmodel.response.name
                                    .toString()
                                    .toUpperCase(),
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: .5,
                                    fontSize: StudentLinkTheme().h2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 7),
                              width: width,
                              child: Text(
                                'Assigned by : ${addedbymeshowmodel.response.createdBy.toString()}',
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.black45,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: StudentLinkTheme().h3),
                              ),
                            ),

                            //date time
                            Container(
                              margin: EdgeInsets.only(top: 2, left: 2),
                              width: width,
                              child: Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(
                                        addedbymeshowmodel.response.createdAt)
                                    .toString(),
                                softWrap: true,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: StudentLinkTheme().h3),
                              ),
                            ),

                            //sub head with description
                            Container(
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
                                          'Description :',
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: .5,
                                              fontWeight: FontWeight.bold,
                                              fontSize: StudentLinkTheme().h3),
                                        ),
                                      ),

                                      //description
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 7, left: 5),
                                        width: width,
                                        child: Text(
                                          addedbymeshowmodel.response.task,
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black45,
                                              letterSpacing: .5,
                                              fontWeight: FontWeight.bold,
                                              fontSize: StudentLinkTheme().h4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    addedbymeshowmodel.response.status != '1'
                        ? GlobalWidget().DecorativeContainer(Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Do you want to reasign the task?',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ToggleButtons(
                                  borderColor: Colors.black,
                                  fillColor: StudentLinkTheme().primary1,
                                  borderWidth: 2,
                                  selectedBorderColor: Colors.black,
                                  selectedColor: Colors.white,
                                  borderRadius: BorderRadius.circular(0),
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'No',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int i = 0;
                                          i < isSelected.length;
                                          i++) {
                                        feeselect = isSelected[i] = i == index;
                                      }
                                    });
                                    //select fee paid or not
                                    if (feeselect == true) {
                                      setState(() {
                                        wantreasign = '1';
                                        rolesliststream.getroleslistData();
                                        statusupdate = '0';
                                      });
                                    } else {
                                      setState(() {
                                        wantreasign = '0';
                                      });
                                    }

                                    print(feeselect);
                                  },
                                  isSelected: isSelected,
                                ),
                              ],
                            ),
                          ))
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    wantreasign == '1'
                        ? StreamBuilder(
                            stream: rolesliststream.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data is RoleListModel) {
                                  rolesmodel = snapshot.data as RoleListModel;
                                  for (int i = 0;
                                      i < rolesmodel.response.length;
                                      i++) {
                                    RolelistList.add(
                                        rolesmodel.response[i].name);
                                  }
                                  Roleid = RolelistList;
                                  print(Roleid);
                                }
                              } else {
                                return Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 1.3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      StudentLinkTheme().primary1),
                                ));
                              }
                              return GlobalWidget().DecorativeContainer(Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CustomSearchableDropDown(
                                    menuMode: true,
                                    dropdownItemStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    backgroundColor: Colors.white,
                                    dropDownMenuItems: Roleid.map((e) {
                                          return e;
                                        }).toList() ??
                                        [],
                                    items: Roleid,
                                    label: 'Assigned to',
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        Roleid.clear();
                                        roleid = value;
                                        teamliststream.getroleslistData(
                                            rolenamefroui: value);
                                      });
                                    },
                                  )));
                            })
                        : SizedBox(),
                    wantreasign == '1' && roleid != ''
                        ? StreamBuilder(
                            stream: teamliststream.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data is TeamListModel) {
                                  teammodel = snapshot.data as TeamListModel;
                                  for (int i = 0;
                                      i < teammodel.response.length;
                                      i++) {
                                    teamidlist.add(teammodel.response[i].id);
                                  }
                                }
                              } else {
                                return CustomSearchableDropDown(
                                    menuMode: true,
                                    dropdownItemStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    backgroundColor: Colors.white,
                                    dropDownMenuItems: [],
                                    items: [],
                                    label: 'Assigned to',
                                    onChanged: (value) {});
                              }
                              return GlobalWidget().DecorativeContainer(Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CustomSearchableDropDown(
                                    menuMode: true,
                                    dropdownItemStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    backgroundColor: Colors.white,
                                    dropDownMenuItems:
                                        teammodel.response.map((e) {
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
                                        teamid = value.toString();
                                      });
                                    },
                                  )));
                            })
                        : Container(),
                    SizedBox(
                      height: 5,
                    ),
                    teamid != ''
                        ? Container(
                            margin: EdgeInsets.only(top: 10, left: 7),
                            child: TextField(
                              minLines: 2,
                              maxLines: 5,
                              controller: RemarkController,
                              cursorColor: StudentLinkTheme().primary1,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                fillColor: StudentLinkTheme().primary1,
                                hoverColor: StudentLinkTheme().primary1,
                                hintText: 'write remark',
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    teamid != ''
                        ? AnimatedContainer(
                            height: 45,
                            duration: Duration(seconds: 1),
                            child: ElevatedButton(
                              onPressed: () {
                                //updateStatus();
                                if (statusupdate == '') {
                                  showLoader.failureshow(
                                      context,
                                      'Please select status of task',
                                      () => Navigator.pop(context));
                                } else {
                                  var User_parm = Uri(
                                      scheme: 'https',
                                      host: Apis.superlink,
                                      path: Apis.baselink +
                                          Apis.task_show_url +
                                          addedbymeshowmodel.response.id
                                              .toString(),
                                      queryParameters: {
                                        'status': statusupdate.toString(),
                                        'remarks':
                                            RemarkController.text.toString(),
                                        'assigned_to': teamid,
                                        'task': addedbymeshowmodel.response.task
                                            .toString()
                                      });

                                  RestApi().put(User_parm).then((value) {
                                    GlobalWidget().showSnackBar(
                                        globalKey, value['response']['msg']);
                                    Navigator.pop(context);
                                  }).catchError((onError) {
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: Text(
                                'Update Status',
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.bold,
                                  fontSize: StudentLinkTheme().h2,
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          StudentLinkTheme().primary1),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13.0),
                                  ))),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    //update status
                    addedbymeshowmodel.response.status != '1' &&
                            wantreasign != '1'
                        ? GlobalWidget().DecorativeContainer(
                            Container(
                                margin: EdgeInsets.only(top: 15, bottom: 25),
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
                                          child: Row(
                                            children: [
                                              Text(
                                                'Update Status :',
                                                softWrap: true,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    letterSpacing: .5,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        StudentLinkTheme().h3),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DropdownButton(
                                                  hint: Text(
                                                    'status',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  value: selectedValue,
                                                  items: dropdownItems,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedValue = newValue!;
                                                      print(selectedValue);
                                                      if (selectedValue ==
                                                          'Pending') {
                                                        statusupdate = '0';
                                                      } else {
                                                        statusupdate = '1';
                                                      }
                                                    });
                                                  },
                                                  underline: SizedBox(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: 10, left: 7),
                                          child: TextField(
                                            minLines: 2,
                                            maxLines: 5,
                                            controller: RemarkController,
                                            cursorColor:
                                                StudentLinkTheme().primary1,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: InputDecoration(
                                              fillColor:
                                                  StudentLinkTheme().primary1,
                                              hoverColor:
                                                  StudentLinkTheme().primary1,
                                              hintText: 'write remark',
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0)),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        AnimatedContainer(
                                          height: 45,
                                          duration: Duration(seconds: 1),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              //updateStatus();
                                              if (statusupdate == '') {
                                                showLoader.failureshow(
                                                    context,
                                                    'Please select status of task',
                                                    () =>
                                                        Navigator.pop(context));
                                              } else {
                                                var User_parm = Uri(
                                                    scheme: 'https',
                                                    host: Apis.superlink,
                                                    path: Apis.baselink +
                                                        Apis.task_show_url +
                                                        addedbymeshowmodel
                                                            .response.id
                                                            .toString(),
                                                    queryParameters: {
                                                      'status': statusupdate
                                                          .toString(),
                                                      'remarks':
                                                          RemarkController.text
                                                              .toString(),
                                                      'assigned_to':
                                                          addedbymeshowmodel
                                                              .response
                                                              .assignedTo
                                                              .toString(),
                                                      'task': addedbymeshowmodel
                                                          .response.task
                                                          .toString()
                                                    });

                                                RestApi()
                                                    .put(User_parm)
                                                    .then((value) {
                                                  GlobalWidget().showSnackBar(
                                                      globalKey,
                                                      value['response']['msg']);
                                                  Navigator.pop(context);
                                                }).catchError((onError) {
                                                  Navigator.pop(context);
                                                });
                                              }
                                            },
                                            child: Text(
                                              'Update Status',
                                              softWrap: true,
                                              style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.bold,
                                                fontSize: StudentLinkTheme().h2,
                                              ),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        StudentLinkTheme()
                                                            .primary1),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13.0),
                                                ))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          )
                        : SizedBox(),

                    SizedBox(
                      height: 5,
                    ),

                    //task_statuses
                    addedbymeshowmodel.response.history.length != 0
                        ? Container(
                            width: width,
                            child: Text(
                              'Task History  ',
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.bold,
                                  fontSize: StudentLinkTheme().h2),
                            ),
                          )
                        : SizedBox(),
                    addedbymeshowmodel.response.history.length != 0
                        ? Divider(
                            thickness: 1.5,
                            color: Colors.grey[300],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    //task_history
                    addedbymeshowmodel.response.history.length != 0
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemCount:
                                addedbymeshowmodel.response.history.length,
                            itemBuilder: (context, int index) {
                              return GlobalWidget()
                                  .DecorativeContainer(Container(
                                margin:
                                    EdgeInsets.only(top: 7, left: 5, right: 5),
                                width: width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat('yyyy-MM-dd')
                                          .format(addedbymeshowmodel.response
                                              .history[index].createdAt)
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.bold,
                                          fontSize: StudentLinkTheme().h4),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        addedbymeshowmodel.response
                                                    .history[index].history ==
                                                null
                                            ? ''
                                            : addedbymeshowmodel
                                                .response.history[index].history
                                                .toString(),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: Colors.black45,
                                            letterSpacing: .5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: StudentLinkTheme().h4),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        addedbymeshowmodel.response
                                                    .history[index].remarks ==
                                                null
                                            ? ''
                                            : addedbymeshowmodel
                                                .response.history[index].remarks
                                                .toString(),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: Colors.black45,
                                            letterSpacing: .5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: StudentLinkTheme().h4),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 5,
                              );
                            },
                          )
                        : SizedBox()
                  ],
                ),
              );
            }));
  }
}
