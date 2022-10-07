import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:share_plus/share_plus.dart';
import 'package:studentz_link/Models/course.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/coursedatastream.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class Courselist extends StatefulWidget {
  Courselist({
    Key? key,
  }) : super(key: key);

  @override
  State<Courselist> createState() => _CourselistState();
}

class _CourselistState extends State<Courselist> {
  TextEditingController controller = TextEditingController();
  CourselistData courselist = CourselistData();
  CourseModel corsemodel = CourseModel(code: 0, response: [], status: '');
  String course_id = '';
  String college_share = '';
  String college_name = '';
  @override
  void initState() {
    course_id = GlobalData.college_id;
    college_name = GlobalData.college_name;
    college_share = GlobalData.college_share;
    courselist = CourselistData();
    courselist.getCourselistData(college_id: course_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Share.share(college_share, subject: college_name);
                  },
                ))
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.all(5),
            child: GlobalWidget().DecorativeContainer(
              IconButton(
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
          ),
          automaticallyImplyLeading: false,
          title: Text(
            college_name,
            style: TextStyle(
                color: Colors.black54,
                letterSpacing: .5,
                fontSize: StudentLinkTheme().h2,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 10, right: 10),
          children: [
            SizedBox(
              height: 5,
            ),
            GlobalWidget().DecorativeContainer(
              Container(
                width: width,
                padding: const EdgeInsets.only(
                    left: 10.0, top: 8, right: 10, bottom: 14),
                child: TextField(
                  controller: controller,
                  onChanged: (searchText) {
                    courselist.getCourselistData(
                        college_id: course_id, searchword: searchText);
                  },
                  onSubmitted: (v) {
                    courselist.getCourselistData(
                        college_id: course_id, searchword: v);
                  },
                  cursorColor: StudentLinkTheme().primary1,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFFFFFFF),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    hintText: ' Search',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                    isDense: true,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            StreamBuilder(
                stream: courselist.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data is CourseModel) {
                      corsemodel = snapshot.data as CourseModel;
                    }
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          StudentLinkTheme().primary1),
                    ));
                  }
                  return RefreshIndicator(
                    color: StudentLinkTheme().primary1,
                    onRefresh: () =>
                        courselist.getCourselistData(college_id: course_id),
                    child: Container(
                      height: height,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: corsemodel.response.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GlobalWidget().DecorativeContainer(ListTile(
                            leading: Image.asset(
                              "assets/images/home_screen/course.png",
                              height: 35,
                              width: 35,
                            ),
                            trailing: GlobalWidget().DecorativeContainer(
                              Container(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Text(
                                    corsemodel.response[index].batches == null
                                        ? '0'
                                        : (corsemodel
                                                .response[index].pendingSeats
                                                .toString() +
                                            '/' +
                                            corsemodel
                                                .response[index].totalSeats
                                                .toString()),
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              corsemodel.response[index].name,
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                  fontSize: StudentLinkTheme().hdes,
                                  fontWeight: FontWeight.bold),
                            ),
                          ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 4,
                          );
                        },
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
