import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:studentz_link/Models/commissionmodel.dart';
import 'package:studentz_link/screens/HomeScreen/commissionscreentank.dart/commissionliststream.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

class CommissionReceivePage extends StatefulWidget {
  const CommissionReceivePage({Key? key}) : super(key: key);

  @override
  State<CommissionReceivePage> createState() => _CommissionReceivePageState();
}

class _CommissionReceivePageState extends State<CommissionReceivePage> {
  CommissionlistData commissionstream = CommissionlistData();
  CommissionModel commissionmodel =
      CommissionModel(code: 0, response: [], status: '');
  @override
  void initState() {
    commissionstream = CommissionlistData();
    commissionstream.getCommissionlistData('1');
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
                  onRefresh: () => commissionstream.getCommissionlistData('1'),
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
              return Container(
                padding: EdgeInsets.all(10),
                child: RefreshIndicator(
                    color: StudentLinkTheme().primary1,
                    onRefresh: () =>
                        commissionstream.getCommissionlistData('1'),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      shrinkWrap: true,
                      itemCount: commissionmodel.response.length,
                      itemBuilder: (BuildContext context, int index) {
                        String name = commissionmodel.response[index].name;
                        String id = commissionmodel
                            .response[index].applicationId
                            .toString();
                        return GlobalWidget().DecorativeContainer(
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
                                          fontSize: StudentLinkTheme().h2,
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
                                            commissionmodel
                                                .response[index].applicationId,
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: .5,
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
                                        commissionmodel.response[index].paid ==
                                                1
                                            ? Text('Payment :Approved',
                                                softWrap: true,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    letterSpacing: .5,
                                                    fontSize:
                                                        StudentLinkTheme().h4,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            : Text('Payment :Rejected',
                                                softWrap: true,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    letterSpacing: .5,
                                                    fontSize:
                                                        StudentLinkTheme().h4,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        Container(
                                          width: 5,
                                        ),
                                        commissionmodel.response[index].paid ==
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
                                        Image.asset(
                                          'assets/images/home_screen/commission.jpeg',
                                          height: 20,
                                          width: 20,
                                        ),
                                        Container(
                                          width: 5,
                                        ),
                                        Text(
                                          commissionmodel
                                              .response[index].commissionAmount,
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: .5,
                                              fontWeight: FontWeight.bold,
                                              fontSize: StudentLinkTheme().h4),
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
                                          'assets/images/home_screen/graduation.png',
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
                                              color: Colors.black,
                                              letterSpacing: .5,
                                              fontWeight: FontWeight.bold,
                                              fontSize: StudentLinkTheme().h4),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //date time
                                  Container(
                                    margin: EdgeInsets.only(top: 5, left: 2),
                                    width: width,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        DateFormat('yyyy-MM-dd')
                                            .format(commissionmodel
                                                .response[index].date)
                                            .toString(),
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: .5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: StudentLinkTheme().h4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 5,
                        );
                      },
                    )),
              );
            }));
  }
}
