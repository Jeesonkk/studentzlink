import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studentz_link/Models/applicationlistmodel.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/applicationdetails.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/applications_edit_screen2.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreenTank/application_dummy_widget.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreenTank/applicationlistingwidget.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreenTank/applicationscreenstream.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/customdrawer/drawerWodget.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/customdrawer/flutter_advanced_drawer.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class ApplicationBody extends StatefulWidget {
  const ApplicationBody({Key? key}) : super(key: key);

  @override
  State<ApplicationBody> createState() => _ApplicationBodyState();
}

class _ApplicationBodyState extends State<ApplicationBody>
    with TickerProviderStateMixin {
  //ApplivationStream.....//
  ApplicationlistData applicationstream = ApplicationlistData();
  ApplicationListModel applicationmodel =
      ApplicationListModel(code: 0, response: [], status: '');

  //Appdar.....//
  final _advancedDrawerController = AdvancedDrawerController();
//search......//
  TextEditingController controller = TextEditingController();
  //filter........//
  var selectedValue;
  String statusupdate = '';
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
    applicationstream = ApplicationlistData();
    applicationstream.getapplicationlistData();
    super.initState();
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
                'Applications',
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
                                applicationstream.getapplicationlistData(
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
                                    applicationstream.getapplicationlistData(
                                        status: statusupdate);
                                  } else if (selectedValue == 'Completed') {
                                    statusupdate = '1';
                                    applicationstream.getapplicationlistData(
                                        status: statusupdate);
                                  } else {
                                    statusupdate = '';
                                    applicationstream.getapplicationlistData(
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
              onRefresh: () => applicationstream.getapplicationlistData(),
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: StreamBuilder(
                      stream: applicationstream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data is ApplicationListModel) {
                            applicationmodel =
                                snapshot.data as ApplicationListModel;
                          }
                        } else {
                          return RefreshIndicator(
                            color: StudentLinkTheme().primary1,
                            onRefresh: () =>
                                applicationstream.getapplicationlistData(),
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
                                itemCount: applicationmodel.response.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      print(applicationmodel
                                          .response[index].status);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ApplicationDetails(
                                                  applicationid:
                                                      applicationmodel
                                                          .response[index].id
                                                          .toString(),
                                                  applicationstatus:
                                                      applicationmodel
                                                          .response[index]
                                                          .status,
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
                                              padding: EdgeInsets.all(10),
                                              decoration: ShapeDecoration(
                                                color: applicationmodel
                                                            .response[index]
                                                            .status ==
                                                        0
                                                    ? StudentLinkTheme()
                                                        .statusyellowcolor
                                                    : applicationmodel
                                                                .response[index]
                                                                .status ==
                                                            1
                                                        ? StudentLinkTheme()
                                                            .statusgreencolor
                                                        : applicationmodel
                                                                    .response[
                                                                        index]
                                                                    .status ==
                                                                2
                                                            ? StudentLinkTheme()
                                                                .statusredcolor
                                                            : Colors.grey,
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
                                              height: 45,
                                              width: 150,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Center(
                                                    child: applicationmodel
                                                                .response[index]
                                                                .status ==
                                                            0
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
                                                        : applicationmodel
                                                                    .response[
                                                                        index]
                                                                    .status ==
                                                                1
                                                            ? const Text(
                                                                'Approved',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : applicationmodel
                                                                        .response[
                                                                            index]
                                                                        .status ==
                                                                    2
                                                                ? const Text(
                                                                    'Cancelled',
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
                                                  IconButton(
                                                      onPressed: () {
                                                        var getshare_parm = Uri(
                                                          scheme: 'https',
                                                          host: Apis.superlink,
                                                          path: Apis.baselink +
                                                              'share-application/' +
                                                              applicationmodel
                                                                  .response[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                        );
                                                        print(getshare_parm);
                                                        RestApi()
                                                            .get(getshare_parm)
                                                            .then(
                                                                (value) async {
                                                          print(value['data']);
                                                          await ShowLoader().failureshow(
                                                              context,
                                                              '  Share a Application of :${(applicationmodel.response[index].name).toString().toUpperCase()}',
                                                              () => Share.share(
                                                                      value[
                                                                          'data'],
                                                                      subject:
                                                                          'Application of :  ${(applicationmodel.response[index].name).toString().toUpperCase()}')
                                                                  .then((value) =>
                                                                      Navigator.pop(
                                                                          context)));
                                                        }).catchError(
                                                                (onError) {
                                                          GlobalWidget().showToast(
                                                              msg:
                                                                  'Error : $onError');
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.share,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            applicationlistingwidget(
                                                firstandlastname: applicationmodel
                                                    .response[index].name,
                                                college_name: applicationmodel
                                                    .response[index].collegeName
                                                    .toString(),
                                                course_name: applicationmodel
                                                    .response[index].course
                                                    .toString(),
                                                applicationId: applicationmodel
                                                    .response[index]
                                                    .applicationId
                                                    .toString(),
                                                feepaidornottext: applicationmodel.response[index].applicationFee == 1
                                                    ? 'Application Fee Paid'
                                                    : 'Application Fee Not Paid',
                                                feeverifycolor: applicationmodel.response[index].verify == 1
                                                    ? Colors.green
                                                    : Colors.black,
                                                docverifyicon: applicationmodel
                                                            .response[index]
                                                            .documentVerified ==
                                                        1
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      )
                                                    : Icon(Icons.close),
                                                docverifycolor: applicationmodel.response[index].documentVerified == 1
                                                    ? Colors.green
                                                    : Colors.black,
                                                feeverifyicon: applicationmodel.response[index].verify == 1
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      )
                                                    : Icon(Icons.close),
                                                feepaidornottextcolor: applicationmodel.response[index].applicationFee == 1 ? Colors.green : StudentLinkTheme().statusredcolor),
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
