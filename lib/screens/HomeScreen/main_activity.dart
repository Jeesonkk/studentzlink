import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentz_link/Models/college.dart';
import 'package:studentz_link/Models/course.dart';
import 'package:studentz_link/resources/repository.dart';
import 'package:studentz_link/screens/HomeScreen/AdmissionScreen/admission_body.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/application_body.dart';
import 'package:studentz_link/screens/HomeScreen/Application_Creation/courseandcollegeselection.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/BottonNavigation/bootom_nav_app_bar.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/BottonNavigation/layout.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/collegedatastreem.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/coursedatastream.dart';
import 'package:studentz_link/screens/HomeScreen/HomeSreen_screens/home_body.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen/taskpage.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/utils/styles.dart';

class MainAcitivty extends StatefulWidget {
  int choosedFragment = 0;
  MainAcitivty({required this.choosedFragment});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainAcitivty>
    with TickerProviderStateMixin {
  int _lastSelected = 0;

  bool visible = false;

  List CollegelistList = [];
  List Collegeid = [];

  int college_id = 0;

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  CollegelistData collegestream = CollegelistData();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _selectedTab(widget.choosedFragment);
    collegestream.getCollegelistData('');
    //GetRole();
  }

  var fragments = [
    HomeBody(),
    TaskScreen(),
    ApplicationBody(),
    AdmissionBody()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(child: fragments[_lastSelected]),
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        selectedColor: StudentLinkTheme().primary1,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(
              iconData: 'assets/images/home_screen/house.png', text: 'Home'),
          FABBottomAppBarItem(
              iconData: 'assets/images/home_screen/task.png', text: 'Tasks'),
          FABBottomAppBarItem(
              iconData: 'assets/images/home_screen/std.png',
              text: 'Applications'),
          FABBottomAppBarItem(
              iconData: 'assets/images/home_screen/fees.png',
              text: 'Admission'),
        ],
        backgroundColor: Colors.white,
        centerItemText: '',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(
          context), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
            position: Offset(offset.dx, offset.dy - icons.length * 35.0),
            child: Text(''));
      },
      child: FloatingActionButton(
        backgroundColor: StudentLinkTheme().primary1,
        onPressed: () async {
          collegestream.getCollegelistData('');

          showMaterialModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: SafeArea(
                        child: ListView(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        //College andcourse selection
                        CollegeCourseselctnandDisplay()
                      ],
                    )),
                  ));
        },

        child: ImageIcon(
          AssetImage('assets/images/home_screen/icons/addapplication.png'),
          size: 23,
          color: Colors.white,
        ),
        elevation: 2.0,
        //addapplication.jpeg
      ),
    );
  }
}
