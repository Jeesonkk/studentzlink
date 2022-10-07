import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:studentz_link/Models/notifications.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/customdrawer/drawerWodget.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/customdrawer/flutter_advanced_drawer.dart';
import 'package:studentz_link/screens/HomeScreen/HomeScreen_widgets/notificationliststream.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with TickerProviderStateMixin {
  final _advancedDrawerController = AdvancedDrawerController();
  NotificationModel notificationmodel =
      NotificationModel(code: 0, response: [], status: '');
  NotificationlistData notificationstreamdata = NotificationlistData();

  @override
  void initState() {
    notificationstreamdata = NotificationlistData();
    notificationstreamdata.getnotificationlistData();
    super.initState();
  }

  // int _selectedIndex = 0;
  // List isSelected = [];
  // _onSelected(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    AnimationController controller = AnimationController(
      vsync: this,
    );
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 550) / 2;
    final double itemWidth = size.width / 2;
    return AdvancedDrawer(
        drawer: DrawerWidget(),
        controller: _advancedDrawerController,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        animationController: controller,
        animationCurve: Curves.easeInOut,
        backdropColor: StudentLinkTheme().secondarybg,
        child: Scaffold(
            appBar: AppBar(
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

              backgroundColor: Colors.white,
              elevation: 0,

              //title
              title: Text(
                'Notifications',
                softWrap: true,
                style: TextStyle(
                    color: Colors.black54,
                    letterSpacing: .5,
                    fontSize: StudentLinkTheme().h2,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey[600],
                        )),
                  ),
                )
              ],

              //drawer
            ),
            body: RefreshIndicator(
                color: StudentLinkTheme().primary1,
                onRefresh: () =>
                    notificationstreamdata.getnotificationlistData(),
                child: StreamBuilder(
                    stream: notificationstreamdata.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data is NotificationModel) {
                          notificationmodel =
                              snapshot.data as NotificationModel;
                        }
                      } else {
                        return RefreshIndicator(
                          color: StudentLinkTheme().primary1,
                          onRefresh: () =>
                              notificationstreamdata.getnotificationlistData(),
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
                        );
                      }
                      return ListView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: notificationmodel.response.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GlobalWidget().DecorativeContainer(
                                  Container(
                                    width: width,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //tittle
                                        Text(
                                          notificationmodel
                                              .response[index].title,
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              letterSpacing: .5,
                                              fontSize: StudentLinkTheme().hdes,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        //assigned to
                                        Text(
                                          notificationmodel
                                              .response[index].content,
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Colors.black45,
                                              letterSpacing: .5,
                                              fontWeight: FontWeight.w600,
                                              fontSize: StudentLinkTheme().h4),
                                        ),

                                        //date time
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            DateFormat('yyyy-MM-dd')
                                                .format(notificationmodel
                                                    .response[index].date)
                                                .toString(),
                                            textAlign: TextAlign.right,
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    StudentLinkTheme().h4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 5,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    }))));
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}




// Container(
//                                         width: width,
//                                         padding: EdgeInsets.all(12),
//                                         child: Column(
//                                           children: [
//                                             //tittle
//                                             Text(
//                                               notificationmodel
//                                                   .response[index].title,
//                                               softWrap: true,
//                                               style: TextStyle(
//                                                   color: Colors.black87,
//                                                   letterSpacing: .5,
//                                                   fontSize:
//                                                       StudentLinkTheme().hdes,
//                                                   fontWeight: FontWeight.bold),
//                                             ),

//                                             //assigned to
//                                             Text(
//                                               notificationmodel
//                                                   .response[index].content,
//                                               softWrap: true,
//                                               style: TextStyle(
//                                                   color: Colors.black54,
//                                                   letterSpacing: .5,
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize:
//                                                       StudentLinkTheme().h4),
//                                             ),

//                                             //date time
//                                             Text(
//                                               formate1,
//                                               textAlign: TextAlign.right,
//                                               softWrap: true,
//                                               style: TextStyle(
//                                                   color: Colors.black45,
//                                                   letterSpacing: .5,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize:
//                                                       StudentLinkTheme().h4),
//                                             ),
//                                           ],
//                                         ),
//                                       ),