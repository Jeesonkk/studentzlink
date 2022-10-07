import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:studentz_link/Models/addedbymeshowmodel.dart';
import 'package:studentz_link/Models/rolelist.dart';
import 'package:studentz_link/Models/teamlist.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/Widgets/input_widget.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/datestream.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/taskrolesliststream.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/taskshowstream.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/taskteamliststream.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class TaskAddedByMeShow extends StatefulWidget {
  String taskid;
  TaskAddedByMeShow({Key? key, required this.taskid})
      : super(
          key: key,
        );

  @override
  State<TaskAddedByMeShow> createState() => _TaskAddedByMeShowState();
}

class _TaskAddedByMeShowState extends State<TaskAddedByMeShow> {
  final globalKey = GlobalKey<ScaffoldState>();
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
    status: '',
  );

  TaskshowtData taskshowstream = TaskshowtData();
  GetDatestream datestream = GetDatestream();
  RoleslistData rolesliststream = RoleslistData();
  TeamlistData teamliststream = TeamlistData();
  RoleListModel rolesmodel = RoleListModel(code: 0, response: [], status: '');
  TeamListModel teammodel = TeamListModel(code: 0, response: [], status: '');

  List<bool> isSelected = [];
  List<bool> isSelectededit = [];
  String taskid = '';
  bool feeselect = false;
  String wantreasign = '';
  int selectcolorbool = 0;
  //Edit Task...................................
  TextEditingController tasknameController1 = TextEditingController();
  var tasknamelabel;
  TextEditingController taskdateController1 = TextEditingController();
  var taskdatelabel;
  TextEditingController descriptioncontroller = TextEditingController();
  var taskdescrlabel;

  var datePicked;
  var dateoftask;
  var dateedit;

  String statusupdate = '';
  List RolelistList = [];
  List Roleid = [];
  String roleid = '';
  List teamidlist = [];
  String teamid = '';

  var wantreasignedit;

  bool feeselectedit = false;

  String statusupdateedit = '';

  int selectcoloreditbool = 0;
  @override
  void initState() {
    taskid = GlobalData.taskidbyme0;
    taskshowstream = TaskshowtData();
    taskshowstream.gettaskshowData(taskid: taskid);
    isSelected = [true, false];
    isSelectededit = [true, false];
    datestream = GetDatestream();
    datestream.getediteddate(editeddate: '');
    rolesliststream = RoleslistData();
    teamliststream = TeamlistData();
    rolesliststream.getroleslistData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            'My Tasks',
            style: TextStyle(
                color: Colors.black54,
                letterSpacing: .5,
                fontSize: StudentLinkTheme().h2,
                fontWeight: FontWeight.bold),
          ),
          actions: [],
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
        body: RefreshIndicator(
          onRefresh: () => taskshowstream.gettaskshowData(taskid: taskid),
          child: StreamBuilder(
              stream: taskshowstream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data is AddedbymeShowModel) {
                    addedbymeshowmodel = snapshot.data as AddedbymeShowModel;
                    GlobalData.addedbymetasknameedit =
                        addedbymeshowmodel.response.name;
                    tasknamelabel = GlobalData.addedbymetasknameedit;
                    GlobalData.addedbymetaskdateedit = DateFormat('yyyy-MM-dd')
                        .format(addedbymeshowmodel.response.date)
                        .toString();
                    dateoftask = GlobalData.addedbymetaskdateedit;
                    GlobalData.description = addedbymeshowmodel.response.task;
                    taskdescrlabel = GlobalData.description;
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: StudentLinkTheme().primary1,
                    ),
                  );
                }
                return GlobalWidget().DecorativeContainer(Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  width: width,
                  height: height,
                  child: ListView(
                    children: [
                      //head
                      GlobalWidget().DecorativeContainer(Container(
                        margin: EdgeInsets.only(top: 17, left: 15),
                        width: width,
                        child: Text(
                          addedbymeshowmodel.response.name.toUpperCase(),
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.black87,
                              letterSpacing: .5,
                              fontSize: StudentLinkTheme().h2,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      SizedBox(
                        height: 5,
                      ),
                      GlobalWidget().DecorativeContainer(
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                width: width,
                                child: Text(
                                  ' Assigned To :${addedbymeshowmodel.response.assignedToUser.toString()}',
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: .5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: StudentLinkTheme().h3),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              //date time
                              Container(
                                margin: EdgeInsets.only(top: 2, left: 2),
                                width: width,
                                child: Text(
                                  'Completed on :  ${DateFormat('yyyy-MM-dd').format(addedbymeshowmodel.response.date).toString()}',
                                  textAlign: TextAlign.right,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: .5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: StudentLinkTheme().h4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //sub head with description
                      GlobalWidget().DecorativeContainer(
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: width,
                                    child: Text(
                                      'Description :',
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.bold,
                                          fontSize: StudentLinkTheme().h3),
                                    ),
                                  ),

                                  //description
                                  Container(
                                    margin: EdgeInsets.only(top: 7, left: 5),
                                    width: width,
                                    child: Text(
                                      addedbymeshowmodel.response.task
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
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
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      //ReAssign Task..........................
                      addedbymeshowmodel.response.status != '1'
                          ? Row(
                              children: [
                                Expanded(
                                  child: GlobalWidget()
                                      .DecorativeContainer(Container(
                                    //padding: EdgeInsets.all(10),
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Reasign the task?',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ToggleButtons(
                                          borderColor: Colors.black,
                                          fillColor: selectcoloreditbool == 1
                                              ? StudentLinkTheme().primary1
                                              : selectcoloreditbool == 2
                                                  ? StudentLinkTheme().primary1
                                                  : Colors.white,
                                          borderWidth: 2,
                                          selectedBorderColor: Colors.black,
                                          //selectedColor: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'No',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                          onPressed: (int index) {
                                            setState(() {
                                              for (int i = 0;
                                                  i < isSelectededit.length;
                                                  i++) {
                                                feeselectedit =
                                                    isSelectededit[i] =
                                                        i == index;
                                              }
                                            });
                                            //select fee paid or not
                                            if (feeselectedit == true) {
                                              setState(() {
                                                wantreasignedit = '1';
                                                rolesliststream
                                                    .getroleslistData();
                                                statusupdateedit = '0';
                                                selectcoloreditbool = 1;
                                              });
                                            } else {
                                              setState(() {
                                                wantreasignedit = '0';
                                                selectcoloreditbool = 2;
                                              });
                                            }

                                            print(feeselectedit);
                                          },
                                          isSelected: isSelectededit,
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                //Edit Task.......................................
                                Expanded(
                                  child: Container(
                                    //height: 70,
                                    child: GlobalWidget()
                                        .DecorativeContainer(Container(
                                      // padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Edit the task?',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          ToggleButtons(
                                            borderColor: Colors.black,
                                            fillColor: selectcolorbool == 1
                                                ? StudentLinkTheme().primary1
                                                : selectcolorbool == 2
                                                    ? StudentLinkTheme()
                                                        .primary1
                                                    : Colors.white,
                                            borderWidth: 2,
                                            selectedBorderColor: Colors.black,
                                            //selectedColor: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'No',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                            onPressed: (int index) {
                                              setState(() {
                                                for (int i = 0;
                                                    i < isSelected.length;
                                                    i++) {
                                                  feeselect = isSelected[i] =
                                                      i == index;
                                                  selectcolorbool = 1;
                                                }
                                              });
                                              //select task edit or not...............................
                                              if (feeselect == true) {
                                                showMaterialModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SafeArea(
                                                        child: Container(
                                                          //height: 570,
                                                          color: Colors
                                                              .transparent,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 340,
                                                                  right: 20,
                                                                  left: 20,
                                                                  top: 30),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: GlobalWidget()
                                                              .DecorativeContainer(
                                                                  Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .arrow_back_ios)),
                                                                  Expanded(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Edit Task',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.black,
                                                                            fontSize: 18),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  //New Task Name....................
                                                                  Flexible(
                                                                    fit: FlexFit
                                                                        .loose,
                                                                    flex: 1,
                                                                    child:
                                                                        StudentLinkInputedit(
                                                                      controller:
                                                                          tasknameController1,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      lable:
                                                                          tasknamelabel,
                                                                      hint:
                                                                          'Enter New Task Name',
                                                                      keyboard:
                                                                          TextInputType
                                                                              .name,
                                                                      prefixIcon:
                                                                          Icon(Icons
                                                                              .person_outline_rounded),
                                                                      enable:
                                                                          true,
                                                                      maxLength:
                                                                          10,
                                                                      maxLines:
                                                                          1,
                                                                      padleft:
                                                                          0.0,
                                                                      sufixIcon:
                                                                          SizedBox(),
                                                                      length: 0,
                                                                      regexp: RegExp(
                                                                          "[a-zA-Z]"),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  //Date Edit.............................
                                                                  Flexible(
                                                                    fit: FlexFit
                                                                        .loose,
                                                                    flex: 1,
                                                                    child: GlobalWidget()
                                                                        .DecorativeContainer(
                                                                      Container(
                                                                        height:
                                                                            80,
                                                                        width:
                                                                            300,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            StreamBuilder(
                                                                                stream: datestream.stream,
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.hasData) {
                                                                                    Container(
                                                                                        padding: EdgeInsets.only(left: 10, top: 10),
                                                                                        child: Text(
                                                                                          datePicked == null ? dateoftask.toString() : snapshot.data.toString(),
                                                                                          style: TextStyle(fontSize: StudentLinkTheme().h3, fontWeight: FontWeight.bold),
                                                                                        ));
                                                                                  }
                                                                                  return Container(
                                                                                      padding: EdgeInsets.only(left: 10, top: 10),
                                                                                      child: Text(
                                                                                        datePicked == null ? dateoftask.toString() : snapshot.data.toString(),
                                                                                        style: TextStyle(fontSize: StudentLinkTheme().h3, fontWeight: FontWeight.bold),
                                                                                      ));
                                                                                }),
                                                                            IconButton(
                                                                                onPressed: () async {
                                                                                  datePicked = await DatePicker.showSimpleDatePicker(
                                                                                    context,
                                                                                    initialDate: DateTime.now(),
                                                                                    firstDate: DateTime((DateTime.now().year - 15) - 10, DateTime.now().month, DateTime.now().day),
                                                                                    lastDate: DateTime.now(),
                                                                                    dateFormat: 'yyyy-MM-dd',
                                                                                    locale: DateTimePickerLocale.en_us,
                                                                                    looping: true,
                                                                                  );
                                                                                  setState(() {
                                                                                    GlobalData.taskdateedit = DateFormat('yyyy-MM-dd').format(datePicked).toString();
                                                                                    dateedit = GlobalData.taskdateedit;
                                                                                  });
                                                                                  datestream.getediteddate(editeddate: dateedit);
                                                                                },
                                                                                icon: Icon(Icons.date_range))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              //Edit Description..............................
                                                              StudentLinkInputedit(
                                                                controller:
                                                                    descriptioncontroller,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .next,
                                                                lable:
                                                                    taskdescrlabel,
                                                                hint:
                                                                    'Enter New Description',
                                                                keyboard:
                                                                    TextInputType
                                                                        .name,
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .person_outline_rounded),
                                                                enable: true,
                                                                maxLength: 100,
                                                                maxLines: 8,
                                                                padleft: 0.0,
                                                                sufixIcon:
                                                                    SizedBox(),
                                                                length: 0,
                                                                regexp: RegExp(
                                                                    "[a-zA-Z]"),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.all<
                                                                          Color>(
                                                                      StudentLinkTheme()
                                                                          .primary1),
                                                                  shape: MaterialStateProperty
                                                                      .all<
                                                                          RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  'Update Task',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        StudentLinkTheme()
                                                                            .h2,
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  taskshowstream
                                                                      .gettaskshowData(
                                                                          taskid:
                                                                              taskid);
                                                                  Navigator.pop(
                                                                      context);
                                                                  var User_parm_edit = Uri(
                                                                      scheme:
                                                                          'https',
                                                                      host: Apis
                                                                          .superlink,
                                                                      path: Apis
                                                                              .baselink +
                                                                          Apis.task_show_url +
                                                                          taskid,
                                                                      queryParameters: {
                                                                        'name': tasknameController1
                                                                            .text
                                                                            .toString(),
                                                                        'task': descriptioncontroller
                                                                            .text
                                                                            .toString(),
                                                                        'assigned_to': addedbymeshowmodel
                                                                            .response
                                                                            .assignedTo
                                                                            .toString(),
                                                                        'date':
                                                                            dateedit.toString(),
                                                                        'status': addedbymeshowmodel
                                                                            .response
                                                                            .status
                                                                            .toString()
                                                                      });
                                                                  RestApi()
                                                                      .put(
                                                                          User_parm_edit)
                                                                      .then(
                                                                          (value) {
                                                                    GlobalWidget().showSnackBar(
                                                                        globalKey,
                                                                        value['response']
                                                                            [
                                                                            'msg']);
                                                                    Navigator.pop(
                                                                        context);
                                                                  }).catchError(
                                                                          (onError) {
                                                                    Navigator.pop(
                                                                        context);
                                                                    GlobalWidget().showSnackBar(
                                                                        globalKey,
                                                                        onError
                                                                            .toString());
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          )),
                                                        ),
                                                      );
                                                    },
                                                    context: context);
                                              } else {
                                                setState(() {
                                                  selectcolorbool = 2;
                                                });
                                                Navigator.pop(context);
                                              }

                                              print(feeselect);
                                            },
                                            isSelected: isSelected,
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 5,
                      ),
                      wantreasignedit == '1'
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
                                return GlobalWidget()
                                    .DecorativeContainer(Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CustomSearchableDropDown(
                                          menuMode: true,
                                          dropdownItemStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
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
                      SizedBox(
                        height: 5,
                      ),
                      wantreasignedit == '1' && roleid != ''
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
                                  return SizedBox();
                                }
                                return GlobalWidget()
                                    .DecorativeContainer(Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CustomSearchableDropDown(
                                          menuMode: true,
                                          dropdownItemStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
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
                                            print(teamid);
                                          },
                                        )));
                              })
                          : Container(),
                      wantreasignedit == '1' && teamid != ''
                          ? ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        StudentLinkTheme().primary1),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Re-Assign Task',
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.bold,
                                  fontSize: StudentLinkTheme().h2,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  wantreasignedit = 0;
                                  taskshowstream.gettaskshowData(
                                      taskid: taskid);
                                });
                                var User_parm_edit = Uri(
                                    scheme: 'https',
                                    host: Apis.superlink,
                                    path: Apis.baselink +
                                        Apis.task_show_url +
                                        taskid,
                                    queryParameters: {
                                      'name': tasknamelabel.toString(),
                                      'task': taskdescrlabel.toString(),
                                      'assigned_to': teamid.toString(),
                                      'status': addedbymeshowmodel
                                          .response.status
                                          .toString()
                                    });
                                RestApi().put(User_parm_edit).then((value) {
                                  GlobalWidget().showSnackBar(
                                      globalKey, value['response']['msg']);
                                  Navigator.pop(context);
                                }).catchError((onError) {
                                  // Navigator.pop(context);
                                  print(onError);
                                });
                              },
                            )
                          : SizedBox(),

                      //task_statuses
                      addedbymeshowmodel.response.history.length != 0
                          ? Container(
                              width: width,
                              child: Text(
                                'Task History ',
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
                                  margin: EdgeInsets.only(
                                      top: 7, left: 5, right: 5),
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
                                          addedbymeshowmodel
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
                                              : addedbymeshowmodel.response
                                                  .history[index].remarks
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
                          : SizedBox(),
                    ],
                  ),
                ));
              }),
        ));
  }

  // openSheet() {
  //   showModalBottomSheet(
  //       useRootNavigator: true,
  //       isScrollControlled: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(20),
  //         ),
  //       ),
  //       clipBehavior: Clip.antiAliasWithSaveLayer,
  //       context: context,
  //       builder: (builder) {
  //         return new ListView(
  //           shrinkWrap: true,
  //           children: [
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Center(
  //                 child: Text(
  //               "Edit Task",
  //               style: TextStyle(fontSize: 20),
  //             )),
  //             SizedBox(
  //               height: 20,
  //             ),

  //             //date
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: TextField(
  //                 onTap: () {
  //                   datePicker();
  //                 },
  //                 controller: date_controller,
  //                 cursorColor: primery,
  //                 decoration: InputDecoration(
  //                   filled: true,
  //                   fillColor: Color(0xFFFFFFFF),
  //                   prefixIcon: Icon(Icons.date_range, color: Colors.grey),
  //                   border: OutlineInputBorder(
  //                     borderSide:
  //                         const BorderSide(color: Colors.grey, width: 2.0),
  //                     borderRadius: BorderRadius.all(
  //                       Radius.circular(10),
  //                     ),
  //                   ),
  //                   hintText: ' DD/MM/YY',
  //                   contentPadding:
  //                       EdgeInsets.symmetric(vertical: 3, horizontal: 3),
  //                   isDense: true,
  //                 ),
  //               ),
  //             ),
  //             //time
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: TextField(
  //                 onTap: () {
  //                   timePicker();
  //                 },
  //                 controller: time_controller,
  //                 cursorColor: primery,
  //                 decoration: InputDecoration(
  //                   filled: true,
  //                   fillColor: Color(0xFFFFFFFF),
  //                   prefixIcon: Icon(Icons.timelapse, color: Colors.grey),
  //                   border: OutlineInputBorder(
  //                     borderSide:
  //                         const BorderSide(color: Colors.grey, width: 2.0),
  //                     borderRadius: BorderRadius.all(
  //                       Radius.circular(10),
  //                     ),
  //                   ),
  //                   hintText: ' Time',
  //                   contentPadding:
  //                       EdgeInsets.symmetric(vertical: 3, horizontal: 3),
  //                   isDense: true,
  //                 ),
  //               ),
  //             ),

  //             //name
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: TextField(
  //                 controller: name_controller,
  //                 cursorColor: primery,
  //                 decoration: InputDecoration(
  //                   filled: true,
  //                   fillColor: Color(0xFFFFFFFF),
  //                   prefixIcon: Icon(Icons.title, color: Colors.grey),
  //                   border: OutlineInputBorder(
  //                     borderSide:
  //                         const BorderSide(color: Colors.grey, width: 2.0),
  //                     borderRadius: BorderRadius.all(
  //                       Radius.circular(10),
  //                     ),
  //                   ),
  //                   hintText: 'Task name',
  //                   contentPadding:
  //                       EdgeInsets.symmetric(vertical: 3, horizontal: 3),
  //                   isDense: true,
  //                 ),
  //               ),
  //             ),
  //             //task
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: TextField(
  //                 keyboardType: TextInputType.multiline,
  //                 minLines: 1,
  //                 maxLines: 5,
  //                 controller: task_controller,
  //                 cursorColor: primery,
  //                 decoration: InputDecoration(
  //                   filled: true,
  //                   fillColor: Color(0xFFFFFFFF),
  //                   prefixIcon: Icon(Icons.edit, color: Colors.grey),
  //                   border: OutlineInputBorder(
  //                     borderSide:
  //                         const BorderSide(color: Colors.grey, width: 2.0),
  //                     borderRadius: BorderRadius.all(
  //                       Radius.circular(10),
  //                     ),
  //                   ),
  //                   hintText: 'Task details',
  //                   contentPadding:
  //                       EdgeInsets.symmetric(vertical: 3, horizontal: 3),
  //                   isDense: true,
  //                 ),
  //               ),
  //             ),
  //             //spinnner
  //             Padding(
  //               padding: const EdgeInsets.all(11.0),
  //               child: FormField<String>(
  //                 initialValue: "",
  //                 builder: (FormFieldState<String> state) {
  //                   return InputDecorator(
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(12.0),
  //                             borderSide:
  //                                 BorderSide(color: Colors.grey, width: 2)),
  //                       ),
  //                       child: StatefulBuilder(
  //                         builder: (BuildContext context,
  //                             void Function(void Function()) setState) {
  //                           return DropdownButton(
  //                             hint: Container(
  //                                 width: MediaQuery.of(context).size.width *
  //                                     0.8 /
  //                                     1,
  //                                 child: Text('ReAssigned To')),
  //                             value: selected_spinner,
  //                             items: spinnerList.map((String items) {
  //                               return DropdownMenuItem(
  //                                 value: items,
  //                                 child: Text(items),
  //                               );
  //                             }).toList(),
  //                             onChanged: (value) {
  //                               setState(() {
  //                                 selected_spinner = value;
  //                               });
  //                             },
  //                           );
  //                         },
  //                       ));
  //                 },
  //               ),
  //             ),

  //             //btn
  //             Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: ButtonTheme(
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(13.0),
  //                   //side: BorderSide(color: Colors.red)
  //                 ),
  //                 height: 40.0,
  //                 child: RaisedButton(
  //                   color: Colors.orangeAccent,
  //                   onPressed: () {
  //                     print("cfedfcedf");
  //                     addTask();
  //                   },
  //                   child: Text(
  //                     "Update",
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                 ),
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

  // datePicker() {
  //   showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2022, 1),
  //       lastDate: DateTime(2080, 12),
  //       builder: (context, picker) {
  //         return Theme(
  //           //TODO: change colors
  //           data: ThemeData.light().copyWith(
  //             colorScheme: ColorScheme.dark(
  //               primary: secondary,
  //               onPrimary: Colors.blue,
  //               surface: primery,
  //               onSurface: Colors.black,
  //             ),
  //             dialogBackgroundColor: Colors.white,
  //           ),
  //           child: picker,
  //         );
  //       }).then((selectedDate) {
  //     //TODO: handle selected date
  //     if (selectedDate != null) {
  //       DateTime now = DateTime.now();
  //       date_controller.text = DateFormat('dd-MM-yyyy').format(selectedDate);
  //     }
  //   });
  // }

  // timePicker() {
  //   showTimePicker(
  //     initialTime: TimeOfDay.now(),
  //     context: context,
  //     builder: (context, picker) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           colorScheme: ColorScheme.dark(
  //             primary: secondary,
  //             onPrimary: Colors.blue,
  //             surface: Colors.white,
  //             onSurface: Colors.black,
  //           ),
  //           dialogBackgroundColor: Colors.white,
  //         ),
  //         child: picker,
  //       );
  //     },
  //   ).then((selectedtime) {
  //     if (selectedtime != null) {
  //       parsedTime =
  //           DateFormat.jm().parse(selectedtime.format(context).toString());
  //       time_controller.text = DateFormat('HH:mm').format(parsedTime);
  //     }
  //   });
  // }

  // addTask() {
  //   if (name_controller.text.isEmpty) {
  //     snackBar(context, 'Please enter task name', globalKey);
  //   } else if (task_controller.text.isEmpty) {
  //     snackBar(context, 'Please enter task ', globalKey);
  //   } else if (selected_spinner == null) {
  //     snackBar(context, 'Please select assigned to', globalKey);
  //   } else if (date_controller.text.isEmpty) {
  //     snackBar(context, 'Please select date', globalKey);
  //   } else if (time_controller.text.isEmpty) {
  //     snackBar(context, 'Please select time', globalKey);
  //   } else {
  //     int assigned_to;
  //     final index =
  //         spinnerList.indexWhere((element) => element == selected_spinner);
  //     if (index >= 0) {
  //       assigned_to = index + 1;
  //       print('assigned_to==$assigned_to');
  //     }

  //     var body = {
  //       'name': name_controller.text.toString(),
  //       'task': task_controller.text.toString(),
  //       'assigned_to': assigned_to.toString(),
  //       'date': DateTime.parse('2022-01-12').toString(),
  //       'time': DateFormat('HH:mm').format(parsedTime).toString(),
  //     };

  //     var User_parm = Uri(
  //       scheme: 'https',
  //       host: Main_Url,
  //       path: Base_URL + Addtask_Url,
  //     );
  //     print(User_parm);
  //     Post(User_parm, body).then((value) {
  //       print(jsonDecode(value.body));
  //       if (value.statusCode == 200) {
  //         snackBar(context, 'Task Added', globalKey);
  //         Navigator.pop(context);
  //       } else {
  //         Map msg = json.decode(value.body);
  //         snackBar(context, msg['response']['msg'], globalKey);
  //         Navigator.pop(context);
  //       }
  //     });

  // }
}
