import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/customdrawer/drawerWodget.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/customdrawer/flutter_advanced_drawer.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/posttask.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/task_added_by_me1.dart';
import 'package:studentz_link/screens/HomeScreen/TaskScreen_widgets/task_added_to_me0.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  final _advancedDrawerControllertask = AdvancedDrawerController();
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnimationController controller = AnimationController(
      vsync: this,
    );
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AdvancedDrawer(
        drawer: DrawerWidget(),
        controller: _advancedDrawerControllertask,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        animationController: controller,
        animationCurve: Curves.easeInOut,
        backdropColor: StudentLinkTheme().secondarybg,
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              key: globalKey,
              appBar: AppBar(
                actions: [
                  Container(
                      margin: EdgeInsets.only(right: 25),
                      child: IconButton(
                        icon: ImageIcon(
                          AssetImage(
                              'assets/images/home_screen/icons/addtask.png'),
                          color: Colors.black87,
                          size: 25,
                        ),
                        onPressed: () {
                          showMaterialModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: SafeArea(
                                      child: ListView(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Container(
                                            height: 50,
                                            width: width,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color:
                                                    StudentLinkTheme().primary1,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(
                                                                10))),
                                            child: Container(
                                              width: width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Add Task',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        letterSpacing: .5,
                                                        fontSize:
                                                            StudentLinkTheme()
                                                                .h2,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          PostTask(),
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                      )),
                ],
                //tab baraddtask
                bottom: TabBar(
                  indicator: ContainerTabIndicator(
                    widthFraction: 0.4,
                    width: 40,
                    height: 5,
                    color: StudentLinkTheme().primary1,
                    padding: const EdgeInsets.only(top: 20),
                    radius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        'Added by me',
                        style: TextStyle(
                            color: Colors.black87,
                            letterSpacing: .5,
                            fontWeight: FontWeight.bold,
                            fontSize: StudentLinkTheme().h3),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Assigned to me',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .5,
                            fontSize: StudentLinkTheme().h3),
                      ),
                    ),
                  ],
                ),

                backgroundColor: Colors.white,
                elevation: 0,

                //title
                title: Text(
                  'My Tasks',
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
                    valueListenable: _advancedDrawerControllertask,
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
              ),
              body: TabBarView(children: [
                AddedByme(),
                AddedTome(),
              ]),
            )));
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerControllertask.showDrawer();
  }
}
