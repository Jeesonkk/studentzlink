import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studentz_link/Models/commissionmodel.dart';
import 'package:studentz_link/screens/HomeScreen/commissionscreentank.dart/commissionliststream.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class CommissionRequestPage extends StatefulWidget {
  const CommissionRequestPage({Key? key}) : super(key: key);

  @override
  State<CommissionRequestPage> createState() => _CommissionRequestPageState();
}

class _CommissionRequestPageState extends State<CommissionRequestPage> {
  CommissionlistData commissionstream = CommissionlistData();
  CommissionModel commissionmodel =
      CommissionModel(code: 0, response: [], status: '');
  @override
  void initState() {
    commissionstream = CommissionlistData();
    commissionstream.getCommissionlistData('0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: StreamBuilder(
            stream: commissionstream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data is CommissionModel) {
                  commissionmodel = snapshot.data as CommissionModel;
                }
              } else {
                return RefreshIndicator(
                  color: StudentLinkTheme().primary1,
                  onRefresh: () => commissionstream.getCommissionlistData('0'),
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
              return RefreshIndicator(
                  color: StudentLinkTheme().primary1,
                  onRefresh: () => commissionstream.getCommissionlistData('0'),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    itemCount: commissionmodel.response.length,
                    itemBuilder: (BuildContext context, int index) {
                      String name = commissionmodel.response[index].name;
                      String id = commissionmodel.response[index].applicationId
                          .toString();
                      return Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            child: GlobalWidget().DecorativeContainer(
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: width,
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      //tittle
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: width,
                                        child: Text(
                                          name.toString().toUpperCase(),
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              letterSpacing: .5,
                                              fontSize: StudentLinkTheme().hdes,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                      id != null
                                          ?
                                          //ID
                                          Container(
                                              margin: EdgeInsets.only(top: 5),
                                              width: width,
                                              child: Text(
                                                commissionmodel.response[index]
                                                    .applicationId
                                                    .toString(),
                                                softWrap: true,
                                                style: TextStyle(
                                                    letterSpacing: .5,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        StudentLinkTheme().h4),
                                              ),
                                            )
                                          : Container(),

                                      Container(
                                        margin: EdgeInsets.only(top: 9),
                                        width: width,
                                        child: Row(
                                          children: [
                                            commissionmodel.response[index]
                                                        .status ==
                                                    1
                                                ? Text(
                                                    'Payment :success',
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        letterSpacing: .5,
                                                        fontSize:
                                                            StudentLinkTheme()
                                                                .h4),
                                                  )
                                                : Text(
                                                    'Payment :pending',
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        letterSpacing: .5,
                                                        fontSize:
                                                            StudentLinkTheme()
                                                                .h4),
                                                  ),
                                            Container(
                                              width: 5,
                                            ),
                                            commissionmodel.response[index]
                                                        .status ==
                                                    1
                                                ? Image.asset(
                                                    'assets/images/home_screen/icons/success.png',
                                                    height: 15,
                                                    width: 15,
                                                  )
                                                : Image.asset(
                                                    'assets/images/home_screen/icons/pending.png',
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                          ],
                                        ),
                                      ),

                                      //amount
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 8,
                                        ),
                                        width: width,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .account_balance_wallet_rounded,
                                              size: 20,
                                              color: Colors.black54,
                                            ),
                                            Container(
                                              width: 5,
                                            ),
                                            Text(
                                              commissionmodel.response[index]
                                                  .commissionAmount,
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  letterSpacing: .5,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      StudentLinkTheme().h4),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //collage and course
                                      Container(
                                        margin: EdgeInsets.only(top: 9),
                                        width: width,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/home_screen/std.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                            Container(
                                              width: 5,
                                            ),
                                            Text(
                                              commissionmodel
                                                  .response[index].collegeName,
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  letterSpacing: .5,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      StudentLinkTheme().h4),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Container(
                                      //   margin: EdgeInsets.only(top: 5),
                                      //   width: width,
                                      //   child: Row(
                                      //     children: [
                                      //       Container(
                                      //         width: 25,
                                      //       ),
                                      //       Text(
                                      //         commissionmodel.response[index].,
                                      //         softWrap: true,
                                      //         style: GoogleFonts.roboto(
                                      //           textStyle: TextStyle(
                                      //               color: Colors.grey,
                                      //               letterSpacing: .5,
                                      //               fontSize: h4),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),

                                      //date time
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 5, left: 2),
                                        width: width,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            commissionmodel.response[index].date
                                                .toString(),
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    StudentLinkTheme().h4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                  ));
            }));
  }
}
