import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studentz_link/Models/admissionlistmodel.dart';
import 'package:studentz_link/resources/repository.dart';
import 'package:studentz_link/screens/HomeScreen/AdmissionScreen/admission_show_body.dart';
import 'package:studentz_link/screens/HomeScreen/AdmissionScreenTank/admissionlistingwidget.dart';
import 'package:studentz_link/screens/HomeScreen/AdmissionScreenTank/admissionliststream.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreenTank/application_dummy_widget.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/customdrawer/drawerWodget.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/customdrawer/flutter_advanced_drawer.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class AdmissionBody extends StatefulWidget {
  const AdmissionBody({Key? key}) : super(key: key);

  @override
  State<AdmissionBody> createState() => _AdmissionBodyState();
}

class _AdmissionBodyState extends State<AdmissionBody>
    with TickerProviderStateMixin {
  //ApplivationStream.....//
  AdmissionlistData admissionstream = AdmissionlistData();
  AdmissionListListModel admissionmodel =
      AdmissionListListModel(code: 0, response: [], status: '');

  //Appdar.....//
  final _advancedDrawerController = AdvancedDrawerController();
//search......//
  TextEditingController controller = TextEditingController();
  //filter........//
  var selectedValue;
  String statusupdate = '';

  String id = '';
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
            "Pending",
            style: TextStyle(color: Colors.white),
          ),
          value: "Pending"),
      DropdownMenuItem(
          child: Text(
            "Completed",
            style: TextStyle(color: Colors.white),
          ),
          value: "Completed"),
      DropdownMenuItem(
          child: Text(
            "All",
            style: TextStyle(color: Colors.white),
          ),
          value: "All"),
    ];
    return menuItems;
  }

  //Init......//
  @override
  void initState() {
    admissionstream = AdmissionlistData();
    admissionstream.getadmissionlistData();

    super.initState();
    Repository().fetchProfile().then((value) {
      setState(() {
        id = value.roles[0];
      });
    });
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    AnimationController _controller = AnimationController(
      vsync: this,
    );
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AdvancedDrawer(
        drawer: DrawerWidget(),
        controller: _advancedDrawerController,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        animationController: _controller,
        animationCurve: Curves.easeInOut,
        backdropColor: StudentLinkTheme().secondarybg,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Admissions',
                softWrap: true,
                style: TextStyle(
                    color: Colors.black54,
                    letterSpacing: .5,
                    fontSize: StudentLinkTheme().h2,
                    fontWeight: FontWeight.bold),
              ),

              //drawer
              leading: IconButton(
                color: Colors.grey,
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),

              bottom: PreferredSize(
                  // ignore: sort_child_properties_last
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            width: width * 0.8,
                            padding: const EdgeInsets.only(left: 10.0, top: 8),
                            child: TextField(
                              controller: controller,
                              onChanged: (searchtext) {
                                admissionstream.getadmissionlistData(
                                    searchword: searchtext);
                              },
                              cursorColor: StudentLinkTheme().primary1,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
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
                        const SizedBox(
                          width: 5,
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
                                    admissionstream.getadmissionlistData(
                                        status: statusupdate);
                                  } else if (selectedValue == 'Completed') {
                                    statusupdate = '1';
                                    admissionstream.getadmissionlistData(
                                        status: statusupdate);
                                  } else {
                                    statusupdate = '';
                                    admissionstream.getadmissionlistData(
                                        status: statusupdate);
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
                  preferredSize: Size.fromHeight(50.0)),
            ),
            //Body.......................
            body: RefreshIndicator(
              color: StudentLinkTheme().primary1,
              onRefresh: () => admissionstream.getadmissionlistData(),
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: StreamBuilder(
                      stream: admissionstream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data is AdmissionListListModel) {
                            admissionmodel =
                                snapshot.data as AdmissionListListModel;
                          }
                        } else {
                          return RefreshIndicator(
                            color: StudentLinkTheme().primary1,
                            onRefresh: () =>
                                admissionstream.getadmissionlistData(),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
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
                        return ListView(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: admissionmodel.response.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdmissionShowPage(
                                                  applicationid: admissionmodel
                                                      .response[index].id
                                                      .toString(),
                                                  applicationname:
                                                      admissionmodel
                                                          .response[index].name,
                                                )),
                                      );
                                    },
                                    child: Card(
                                      elevation: 8,
                                      child: GlobalWidget().DecorativeContainer(
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Container(
                                              decoration: ShapeDecoration(
                                                color: admissionmodel
                                                            .response[index]
                                                            .status ==
                                                        '0'
                                                    ? StudentLinkTheme()
                                                        .statusyellowcolor
                                                    : admissionmodel
                                                                .response[index]
                                                                .status ==
                                                            '4'
                                                        ? StudentLinkTheme()
                                                            .statusgreencolor
                                                        : admissionmodel
                                                                    .response[
                                                                        index]
                                                                    .status ==
                                                                '2'
                                                            ? StudentLinkTheme()
                                                                .statusredcolor
                                                            : admissionmodel
                                                                        .response[
                                                                            index]
                                                                        .status ==
                                                                    '3'
                                                                ? Colors.orange
                                                                : Colors.white,
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Color(0x1FA0A0A0),
                                                    spreadRadius: 1,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 3),
                                                  )
                                                ],
                                                shape:
                                                    ContinuousRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        side: BorderSide(
                                                            width: 2.0,
                                                            color: Color(
                                                                0xFFE4E4E4))),
                                              ),
                                              height: 40,
                                              width: 150,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: admissionmodel
                                                                .response[index]
                                                                .status ==
                                                            '0'
                                                        ? const Text(
                                                            'Pending',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : admissionmodel
                                                                    .response[
                                                                        index]
                                                                    .status ==
                                                                '4'
                                                            ? const Text(
                                                                'Completed',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : admissionmodel
                                                                        .response[
                                                                            index]
                                                                        .status ==
                                                                    '2'
                                                                ? Text(
                                                                    'Rejected',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : null,
                                                  ),
                                                  id == 'partner'
                                                      ? admissionmodel
                                                                  .response[
                                                                      index]
                                                                  .firstYearFeeStatus ==
                                                              0
                                                          ? admissionmodel
                                                                      .response[
                                                                          index]
                                                                      .commissionSent !=
                                                                  1
                                                              ? IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AdvanceCustomAlert(
                                                                              admissionmodel.response[index].id,
                                                                              admissionmodel.response[index].commission);
                                                                        });
                                                                  },
                                                                  icon: ImageIcon(
                                                                      AssetImage(
                                                                          "assets/images/home_screen/icons/share.png"),
                                                                      size: 18,
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              : SizedBox()
                                                          : SizedBox()
                                                      : SizedBox()
                                                ],
                                              ),
                                            ),
                                            admissionlistingwidget(
                                                firstandlastname: admissionmodel
                                                    .response[index].name,
                                                college_name: admissionmodel
                                                    .response[index].collegeName
                                                    .toString(),
                                                course_name: admissionmodel
                                                    .response[index].courseName
                                                    .toString(),
                                                firstYearFeeStatus:
                                                    admissionmodel
                                                        .response[index]
                                                        .firstYearFeeStatus,
                                                id: id,
                                                requestcommissionpressed:
                                                    () {}),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 0,
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      })),
            )));
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
