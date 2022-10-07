import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:studentz_link/Models/tasklist.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/Widgets/input_widget.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/task_added_byme1_show.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/task_list_stream.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class AddedByme extends StatefulWidget {
  const AddedByme({Key? key}) : super(key: key);

  @override
  State<AddedByme> createState() => _AddedBymeState();
}

class _AddedBymeState extends State<AddedByme> {
  TasklistData taskliststream = TasklistData();
  TaskModel taskmodel = TaskModel(status: '', response: [], code: 0);

  var selectedValue;
  String statusupdate = '';
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        child: Text(
          "Pending",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        value: "Pending",
      ),
      DropdownMenuItem(
          child: Text("Completed",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          value: "Completed"),
      DropdownMenuItem(
          child: Text("All",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          value: "All"),
    ];
    return menuItems;
  }

  @override
  void initState() {
    taskliststream = TasklistData();
    taskliststream.gettasklistData(taskstatus: '', created_by: '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.0),
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 25.0, top: 8, right: 25),
                        child: TextField(
                          controller: controller,
                          onChanged: (searchText) {
                            taskliststream.gettasklistData(
                                taskstatus: '',
                                created_by: '1',
                                search: searchText);
                          },
                          cursorColor: StudentLinkTheme().primary1,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            hintText: ' Search',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 3),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                          customButton: const Icon(Icons.filter_alt),
                          customItemsIndexes: const [3],
                          customItemsHeight: 8,
                          items: [...dropdownItems.map((e) => e)],
                          onChanged: (newValue) {
                            print(newValue);
                            setState(() {
                              selectedValue = newValue!;
                              print(selectedValue);

                              if (selectedValue == 'Pending') {
                                statusupdate = '0';
                                taskliststream.gettasklistData(
                                    taskstatus: statusupdate, created_by: '1');
                              } else if (selectedValue == 'Completed') {
                                statusupdate = '1';
                                taskliststream.gettasklistData(
                                    taskstatus: statusupdate, created_by: '1');
                              } else {
                                statusupdate = '';
                                taskliststream.gettasklistData(
                                    taskstatus: statusupdate, created_by: '1');
                              }
                            });
                          },
                          itemHeight: 48,
                          itemPadding:
                              const EdgeInsets.only(left: 16, right: 16),
                          dropdownWidth: 160,
                          dropdownPadding:
                              const EdgeInsets.symmetric(vertical: 6),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: StudentLinkTheme().primary1,
                          ),
                          dropdownElevation: 8,
                          offset: const Offset(0, 8),
                        ))),
                  ],
                ),
              ),
            )),
        body: RefreshIndicator(
          color: StudentLinkTheme().primary1,
          onRefresh: () =>
              taskliststream.gettasklistData(taskstatus: '', created_by: '1'),
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                SizedBox(
                  height: 4,
                ),
                StreamBuilder(
                    stream: taskliststream.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data is TaskModel) {
                          taskmodel = snapshot.data as TaskModel;
                        }
                      } else {
                        return RefreshIndicator(
                          color: StudentLinkTheme().primary1,
                          onRefresh: () => taskliststream.gettasklistData(
                              taskstatus: '', created_by: '1'),
                          child: Container(
                            height: height,
                            width: width,
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
                          ),
                        );
                      }
                      return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: taskmodel.response.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: GlobalWidget().DecorativeContainer(
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: ShapeDecoration(
                                      color: taskmodel.response[index].status ==
                                              '0'
                                          ? StudentLinkTheme().statusyellowcolor
                                          : taskmodel.response[index].status ==
                                                  '1'
                                              ? StudentLinkTheme()
                                                  .statusgreencolor
                                              : Colors.white,
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x1FA0A0A0),
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          side: BorderSide(
                                              width: 2.0,
                                              color: Color(0xFFE4E4E4))),
                                    ),
                                    height: 40,
                                    width: 120,
                                    child: Center(
                                      child: taskmodel.response[index].status ==
                                              '0'
                                          ? Center(
                                              child: const Text(
                                                'Pending',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          : taskmodel.response[index].status ==
                                                  '1'
                                              ? Center(
                                                  child: const Text(
                                                    'Completed',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              : Text(
                                                  'Asigned',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // print(TaskId);
                                      // Routing(
                                      //     context: context,
                                      //     To: AddedTaskDetails(
                                      //         names: name,
                                      //         description: description,
                                      //         TaskId: TaskId,
                                      //         date: date,
                                      //         time: time,
                                      //         userId: userId,
                                      //         origdate: origdate));
                                      GlobalData.taskidbyme0 = taskmodel
                                          .response[index].id
                                          .toString();
                                      Navigator.pushNamed(
                                          context, '/taskaddedbymeshowdata');
                                    },
                                    child: Container(
                                      width: width,
                                      padding: EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //tittle
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width: 180,
                                            child: Text(
                                              taskmodel.response[index].name
                                                  .toString()
                                                  .toUpperCase(),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: .5,
                                                  fontSize:
                                                      StudentLinkTheme().hdes,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),

                                          //assigned to
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, left: 2),
                                            width: width,
                                            child: Text(
                                              '${taskmodel.response[index].assignedUserRole[0]['name']}|${taskmodel.response[index].assignedUser}',
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  letterSpacing: .5,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      StudentLinkTheme().h4),
                                            ),
                                          ),

                                          //date time
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 2, left: 2),
                                            width: width,
                                            child: Text(
                                              DateFormat('yyyy-MM-dd')
                                                  .format(taskmodel
                                                      .response[index]
                                                      .createdAt)
                                                  .toString(),
                                              softWrap: true,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  letterSpacing: .5,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      StudentLinkTheme().h4),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 4,
                          );
                        },
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
