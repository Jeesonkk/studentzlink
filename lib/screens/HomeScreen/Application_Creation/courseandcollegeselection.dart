import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:studentz_link/Models/batchModel.dart';
import 'package:studentz_link/Models/college.dart';
import 'package:studentz_link/Models/course.dart';
import 'package:studentz_link/resources/repository.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/Widgets/input_widget.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/batchstream.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/collegedatastreem.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/coursedatastream.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class CollegeCourseselctnandDisplay extends StatefulWidget {
  const CollegeCourseselctnandDisplay({Key? key}) : super(key: key);

  @override
  State<CollegeCourseselctnandDisplay> createState() =>
      _CollegeCourseselctnandDisplayState();
}

class _CollegeCourseselctnandDisplayState
    extends State<CollegeCourseselctnandDisplay> {
  TextEditingController CommissionController4 = TextEditingController();
  TextEditingController CollegeController4 = TextEditingController();
  TextEditingController CourseController4 = TextEditingController();
  TextEditingController UniversityController4 = TextEditingController();
  TextEditingController BatchController4 = TextEditingController();
  TextEditingController controller = TextEditingController();
  CollegelistData collegestream = CollegelistData();
  CourselistData courseliststream = CourselistData();
  CourseModel courselistmodel = CourseModel(code: 0, response: [], status: '');
  CollegeModel collegelistmodel =
      CollegeModel(code: 0, response: [], status: '');

  List CollegelistList = [];

  List Collegeid = [];

  int college_id = 0;

  String id = '';

  var selectedValue;

  String dropdownItems = '';

  List<Batch> batch = [];

  //BatchStream
  BatchlistData batchstream = BatchlistData();
  BatchModel batchmodel = BatchModel(code: 0, response: [], status: '');

  List batchlist = [];

  bool batchbool = false;
  @override
  void initState() {
    collegestream = CollegelistData();
    courseliststream = CourselistData();
    collegestream.getCollegelistData('');
    batchstream = BatchlistData();

    super.initState();
    Repository().fetchProfile().then((value) {
      setState(() {
        id = value.roles[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GlobalWidget().DecorativeContainer(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: StudentLinkTheme().primary2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select Your College ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: StudentLinkTheme().h2),
            ),
          ),
        ),
        StreamBuilder(
            stream: collegestream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data is CollegeModel) {
                  collegelistmodel = snapshot.data as CollegeModel;
                  Collegeid = CollegelistList;
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
                  child: Column(
                    children: [
                      //college search.............................
                      Container(
                        width: width,
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 8, right: 10, bottom: 12),
                        child: TextField(
                          controller: controller,
                          onChanged: (searchText) {
                            collegestream.getCollegelistData(searchText);
                          },
                          onSubmitted: (v) {
                            collegestream.getCollegelistData(v);
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
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
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
                      //Collegelist...................
                      ListView.separated(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: collegelistmodel.response.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GlobalWidget().DecorativeContainer(ListTile(
                            onTap: () {
                              setState(() {
                                GlobalData.college_name_create =
                                    collegelistmodel.response[index].name;
                                GlobalData.college_id_create = collegelistmodel
                                    .response[index].id
                                    .toString();
                              });
                              courseliststream.getCourselistData(
                                  college_id: collegelistmodel
                                      .response[index].id
                                      .toString(),
                                  searchword: '');
                              //courselist......
                              showMaterialModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                      child: SafeArea(
                                          child: ListView(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                          ),
                                          //College andcourse selection
                                          StreamBuilder(
                                              stream: courseliststream.stream,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  if (snapshot.data
                                                      is CourseModel) {
                                                    courselistmodel = snapshot
                                                        .data as CourseModel;
                                                  }
                                                } else {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.white,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            StudentLinkTheme()
                                                                .primary1),
                                                  ));
                                                }
                                                return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: GlobalWidget()
                                                        .DecorativeContainer(
                                                            Column(
                                                      children: [
                                                        //coursehead...............
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          color:
                                                              StudentLinkTheme()
                                                                  .primary2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              'Select Your  Course',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      StudentLinkTheme()
                                                                          .h2),
                                                            ),
                                                          ),
                                                        ),
                                                        //course search..........
                                                        Container(
                                                          width: width,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  top: 8,
                                                                  right: 10,
                                                                  bottom: 14),
                                                          child: TextField(
                                                            controller:
                                                                controller,
                                                            onChanged:
                                                                (searchText) {
                                                              courseliststream.getCourselistData(
                                                                  college_id:
                                                                      GlobalData
                                                                          .college_id_create,
                                                                  searchword:
                                                                      searchText);
                                                            },
                                                            onSubmitted: (v) {
                                                              courseliststream
                                                                  .getCourselistData(
                                                                      college_id:
                                                                          GlobalData
                                                                              .college_id_create,
                                                                      searchword:
                                                                          v);
                                                            },
                                                            cursorColor:
                                                                StudentLinkTheme()
                                                                    .primary1,
                                                            decoration:
                                                                const InputDecoration(
                                                              filled: true,
                                                              fillColor: Color(
                                                                  0xFFFFFFFF),
                                                              prefixIcon: Icon(
                                                                  Icons.search,
                                                                  color: Colors
                                                                      .grey),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          15),
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          15),
                                                                ),
                                                              ),
                                                              hintText:
                                                                  ' Search',
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          3,
                                                                      horizontal:
                                                                          3),
                                                              isDense: true,
                                                            ),
                                                          ),
                                                        ),
                                                        //courselist..........................
                                                        ListView.separated(
                                                          physics:
                                                              ClampingScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              courselistmodel
                                                                  .response
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return GlobalWidget()
                                                                .DecorativeContainer(
                                                                    ListTile(
                                                              onTap: () {
                                                                setState(() {
                                                                  GlobalData
                                                                          .course_id_create =
                                                                      courselistmodel
                                                                          .response[
                                                                              index]
                                                                          .id
                                                                          .toString();
                                                                  GlobalData.batch_id_create = courselistmodel
                                                                      .response[
                                                                          index]
                                                                      .batches[
                                                                          0]
                                                                      .id
                                                                      .toString();
                                                                  GlobalData
                                                                          .course_name_create =
                                                                      courselistmodel
                                                                          .response[
                                                                              index]
                                                                          .name;
                                                                  GlobalData
                                                                          .university_name_create =
                                                                      courselistmodel
                                                                          .response[
                                                                              index]
                                                                          .universityName;
                                                                  GlobalData.batch = courselistmodel
                                                                      .response[
                                                                          index]
                                                                      .batches[
                                                                          0]
                                                                      .name
                                                                      .toString();

                                                                  CollegeController4
                                                                          .text =
                                                                      GlobalData
                                                                          .college_name_create;
                                                                  CourseController4
                                                                          .text =
                                                                      GlobalData
                                                                          .course_name_create;
                                                                  UniversityController4
                                                                          .text =
                                                                      GlobalData
                                                                          .university_name_create;
                                                                  dropdownItems =
                                                                      GlobalData
                                                                          .batch;
                                                                  CommissionController4
                                                                      .text = '';
                                                                });
                                                                batchstream.getbatchlistData(
                                                                    course_id: courselistmodel
                                                                        .response[
                                                                            index]
                                                                        .id
                                                                        .toString());
                                                                //Show subitted course and college details.....................
                                                                showMaterialModalBottomSheet(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    context:
                                                                        context,
                                                                    builder: (context) => Container(
                                                                        decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                                                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                                                        child: ListView(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 100,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Flexible(
                                                                                  fit: FlexFit.loose,
                                                                                  flex: 1,
                                                                                  child: StudentLinkInput(
                                                                                    controller: CollegeController4,
                                                                                    textInputAction: TextInputAction.next,
                                                                                    lable: 'College',
                                                                                    enable: false,
                                                                                    keyboard: TextInputType.name,
                                                                                    prefixIcon: Container(height: 3, width: 3, padding: EdgeInsets.all(15), child: Image.asset("assets/images/home_screen/graduation.png")),
                                                                                    maxLength: 9,
                                                                                    maxLines: 2,
                                                                                    padleft: 0.0,
                                                                                    sufixIcon: SizedBox(),
                                                                                    length: 0,
                                                                                    regexp: RegExp(''),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Flexible(
                                                                                  fit: FlexFit.loose,
                                                                                  flex: 1,
                                                                                  child: StudentLinkInput(
                                                                                    controller: CourseController4,
                                                                                    textInputAction: TextInputAction.next,
                                                                                    lable: 'Course',
                                                                                    enable: false,
                                                                                    keyboard: TextInputType.name,
                                                                                    prefixIcon: Container(height: 8, width: 8, padding: EdgeInsets.all(15), child: Image.asset("assets/images/home_screen/course.jpeg")),
                                                                                    maxLength: 9,
                                                                                    maxLines: 2,
                                                                                    padleft: 0.0,
                                                                                    sufixIcon: SizedBox(),
                                                                                    length: 0,
                                                                                    regexp: RegExp(''),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),

                                                                            //University
                                                                            StudentLinkInput(
                                                                              controller: UniversityController4,
                                                                              textInputAction: TextInputAction.next,
                                                                              lable: 'University',
                                                                              enable: false,
                                                                              keyboard: TextInputType.emailAddress,
                                                                              prefixIcon: Container(height: 8, width: 8, padding: EdgeInsets.all(15), child: Image.asset("assets/images/home_screen/university.png")),
                                                                              maxLength: 9,
                                                                              maxLines: 2,
                                                                              padleft: 0.0,
                                                                              sufixIcon: SizedBox(),
                                                                              length: 0,
                                                                              regexp: RegExp(''),
                                                                            ),

                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),

                                                                            //Batch
                                                                            StreamBuilder(
                                                                                stream: batchstream.stream,
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.hasData) {
                                                                                    if (snapshot.data is BatchModel) {
                                                                                      batchmodel = snapshot.data as BatchModel;

                                                                                      for (int j = 0; j < batchmodel.response.length; j++) {
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
                                                                                      valueColor: AlwaysStoppedAnimation<Color>(StudentLinkTheme().primary1),
                                                                                    ));
                                                                                  }
                                                                                  return GlobalWidget().DecorativeContainer(CustomSearchableDropDown(
                                                                                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                                                                    menuMode: true,
                                                                                    dropdownItemStyle: TextStyle(fontWeight: FontWeight.bold),
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                    backgroundColor: Colors.white,
                                                                                    dropDownMenuItems: batchlist.map((e) => e['batch_name']).toList(),
                                                                                    items: batchlist.map((e) => e['batch_id']).toList(),
                                                                                    label: 'Batch',
                                                                                    onChanged: (value) {
                                                                                      print(value);
                                                                                      setState(() {
                                                                                        batchlist.clear();
                                                                                        GlobalData.batch_id_create = value.toString();
                                                                                        batchbool = true;
                                                                                      });

                                                                                      //courseliststream.getCourselistData(college_id: collegeid.toString());
                                                                                    },
                                                                                  ));
                                                                                }),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            if (id !=
                                                                                'partner')
                                                                              Container()
                                                                            else
                                                                              //Commission
                                                                              StudentLinkInput(
                                                                                controller: CommissionController4,
                                                                                textInputAction: TextInputAction.next,
                                                                                lable: 'Commission',
                                                                                hint: 'eg :₹ 2000.00',
                                                                                keyboard: TextInputType.number,
                                                                                prefixIcon: Container(height: 8, width: 8, padding: EdgeInsets.all(15), child: Image.asset("assets/images/home_screen/commission.jpeg")),
                                                                                enable: true,
                                                                                maxLength: 9,
                                                                                maxLines: 2,
                                                                                padleft: 0.0,
                                                                                sufixIcon: SizedBox(),
                                                                                length: 0,
                                                                                regexp: RegExp(''),
                                                                              ),
                                                                            Container(
                                                                              height: 50,
                                                                              child: ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all<Color>(StudentLinkTheme().primary1),
                                                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                    RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: Text(
                                                                                  'Next',
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    letterSpacing: .5,
                                                                                    fontSize: StudentLinkTheme().h2,
                                                                                  ),
                                                                                ),
                                                                                onPressed: () {
                                                                                  if (batchbool == false)
                                                                                    ShowLoader().failureshow(context, 'Please select batch', () => Navigator.pop(context));
                                                                                  else if (CommissionController4.text.toString().isEmpty && id != 'sale-team')
                                                                                    ShowLoader().failureshow(context, 'Please Enter Commission Amount', () => Navigator.pop(context));
                                                                                  else {
                                                                                    setState(() {
                                                                                      GlobalData.commission = CommissionController4.text.toString();
                                                                                    });
                                                                                    Navigator.pushReplacementNamed(context, '/applicationcreationform');
                                                                                  }
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )));
                                                                ///////////////////////////////////////////////////////Show subitted course and college details.............
                                                              },
                                                              leading:
                                                                  Image.asset(
                                                                "assets/images/home_screen/course.png",
                                                                height: 35,
                                                                width: 35,
                                                              ),
                                                              trailing:
                                                                  GlobalWidget()
                                                                      .DecorativeContainer(
                                                                Container(
                                                                  height: 40,
                                                                  width: 40,
                                                                  child: Center(
                                                                      child: Icon(
                                                                          Icons
                                                                              .arrow_forward_ios)),
                                                                ),
                                                              ),
                                                              title: Text(
                                                                courselistmodel
                                                                    .response[
                                                                        index]
                                                                    .name,
                                                                softWrap: true,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontSize:
                                                                        StudentLinkTheme()
                                                                            .hdes,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ));
                                                          },
                                                          separatorBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return SizedBox(
                                                              height: 4,
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    )));
                                              })
                                        ],
                                      ))));
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  collegelistmodel.response[index].logoUrl),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                            ),
                            title: Text(
                              collegelistmodel.response[index].name,
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
                    ],
                  ));
            }),
      ],
    ));
  }
}
