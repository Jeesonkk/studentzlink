import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studentz_link/Models/college.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/collegedatastreem.dart';
import 'package:studentz_link/services/navigation_service.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class CollegeList extends StatefulWidget {
  const CollegeList({Key? key}) : super(key: key);

  @override
  State<CollegeList> createState() => _CollegeListState();
}

class _CollegeListState extends State<CollegeList> {
  TextEditingController controller = TextEditingController();
  CollegelistData collegelist = CollegelistData();
  CollegeModel collegemodel = CollegeModel(code: 0, response: [], status: '');
  @override
  void initState() {
    collegelist = CollegelistData();
    collegelist.getCollegelistData('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          'Colleges',
          style: TextStyle(
              color: Colors.black54,
              letterSpacing: .5,
              fontSize: StudentLinkTheme().h2,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 5,
            ),
            //===================searchfield===================//
            GlobalWidget().DecorativeContainer(
              Container(
                width: width,
                padding: const EdgeInsets.only(
                    left: 10.0, top: 8, right: 10, bottom: 12),
                child: TextField(
                  controller: controller,
                  onChanged: (searchText) {
                    collegelist.getCollegelistData(searchText);
                  },
                  onSubmitted: (v) {
                    collegelist.getCollegelistData(v);
                  },
                  cursorColor: StudentLinkTheme().primary1,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFFFFFFF),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
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
            SizedBox(
              height: 5,
            ),
            //======================Collegelist=================//
            StreamBuilder(
                stream: collegelist.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data is CollegeModel) {
                      collegemodel = snapshot.data as CollegeModel;
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
                    onRefresh: () => collegelist.getCollegelistData(''),
                    child: Container(
                      height: height,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: collegemodel.response.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GlobalWidget().DecorativeContainer(ListTile(
                            onTap: () {
                              setState(() {
                                GlobalData.college_name =
                                    collegemodel.response[index].name;
                                GlobalData.college_id =
                                    collegemodel.response[index].id.toString();
                                GlobalData.college_share =
                                    collegemodel.response[index].link;
                              });
                              Navigator.pushNamed(context, '/courselist');
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  collegemodel.response[index].logoUrl),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                            ),
                            title: Text(
                              collegemodel.response[index].name,
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                  fontSize: StudentLinkTheme().h2,
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
    ));
  }
}
