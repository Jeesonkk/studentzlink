import 'package:dialog_loader/dialog_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/HomeScreen/main_activity.dart';
import 'package:studentz_link/student_link_global_data.dart';

import 'package:studentz_link/utils/styles.dart';

class GlobalWidget {
  Widget studentlint_textFormfield(
      {Function(String)? onSubmitted,
      Function()? onTap,
      Color? clr,
      TextEditingController? mobile_number_controller,
      String? labetext,
      hinttext}) {
    return Container(
      padding: EdgeInsets.only(top: 20, right: 25, left: 25),
      child: TextField(
        onSubmitted: onSubmitted,
        onTap: onTap,
        maxLength: 10,
        maxLines: 1,
        cursorColor: clr,
        controller: mobile_number_controller,
        keyboardType: TextInputType.phone,
        style: TextStyle(
          letterSpacing: .5,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
          fontSize: StudentLinkTheme().h3,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: StudentLinkTheme().primary1),
          ),
          labelStyle: TextStyle(
            color: StudentLinkTheme().disText,
            letterSpacing: .5,
            fontSize: 16,
          ),
          labelText: labetext,
          hintStyle: TextStyle(
            color: StudentLinkTheme().disText,
            letterSpacing: .5,
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.phone_android,
            color: clr,
          ),
          hintText: hinttext,
          border: OutlineInputBorder(),
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget DecorativeContainer(Widget child,
      {Color colorborder = const Color(0xFFE4E4E4)}) {
    return Container(
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          colors: [StudentLinkTheme().kGreyLightestest, Colors.white],
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x1FA0A0A0),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          )
        ],
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 2.0, color: colorborder)),
      ),
      child: child,
    );
  }

  Widget submitButton({String? buttontext, Function()? onPressed}) {
    return Container(
      width: 150,
      height: 55,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(StudentLinkTheme().primary1),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          child: Text(
            buttontext!,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: .5,
              fontWeight: FontWeight.bold,
              fontSize: StudentLinkTheme().h3,
            ),
          ),
          onPressed: onPressed),
    );
  }

  showSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, String msg,
      {SnackBarAction? actions, bool floating = false}) {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
          content: Text(msg),
          behavior:
              floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
          duration:
              actions == null ? Duration(seconds: 2) : Duration(seconds: 10),
          action: actions),
    );
  }

  void showToast({msg}) {
    Fluttertoast.showToast(
      backgroundColor: StudentLinkTheme().primary1,
      textColor: Colors.white,
      timeInSecForIosWeb: 5,
      msg: msg ?? '',
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
// class TextView extends StatelessWidget {
//   final String text;
//   final double size, _size, textScaleFactor;
//   final Color color;
//   final int maxLines;
//   final double lineSpacing;
//   final TextOverflow overflow;
//   final FontWeight fontWeight;
//   final TextAlign textAlign;
//   final TextDecoration decoration;

//   TextView(
//     this.text, {
//     Key? key,
//      this.size,
//      this.textAlign,
//      this.color,
//      this.textScaleFactor,
//      this.fontWeight,
//      this.overflow,
//      this.maxLines,
//      this.lineSpacing,
//      this.decoration,
//   })  : _size = size == null ? 12.0 : size,
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       softWrap: true,
//       maxLines: maxLines,
//       overflow: overflow,
//       textAlign: textAlign != null ? textAlign : TextAlign.start,
//       textScaleFactor: textScaleFactor,
//       style: TextStyle(
//         letterSpacing: 1.2,
//         decoration: decoration,
//         height: lineSpacing,
//         color: color != null ? color : Colors.white,
//         textBaseline: TextBaseline.alphabetic,
//         fontWeight: fontWeight != null ? fontWeight : FontWeight.bold,
//         fontFamily: 'Bariol',
//         fontSize: _size,
//       ),
//     );
//   }
// }
class ShowLoader {
  static late DialogLoader _dialogLoader;

  Future<void> show(BuildContext context) async {
    _dialogLoader = DialogLoader(context: context);
    _dialogLoader.show(
      theme: LoaderTheme.dialogCircle,
      title: Text("Loading"),
      leftIcon: CircularProgressIndicator(
        color: StudentLinkTheme().primary1,
      ),
    );
  }

  Future<void> successshow(BuildContext context, String msg) async {
    _dialogLoader = DialogLoader(context: context);
    _dialogLoader.show(
        theme: LoaderTheme.dialogCircle,
        title: Text(msg),
        leftIcon: Icon(Icons.create));
  }

  Future<void> failureshow(
      BuildContext context, String msg, Function()? onPressed) async {
    _dialogLoader = DialogLoader(context: context);
    _dialogLoader.show(
        theme: LoaderTheme.dialogCircle,
        title: Text(
          msg,
          style: TextStyle(
              color: StudentLinkTheme().primary1, fontWeight: FontWeight.bold),
        ),
        leftIcon: MaterialButton(
          onPressed: onPressed,
          child: Text(
            'ok',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ));
  }

  void update(String title, IconData leftIcon,
      {Color colors: Colors.black87, required BuildContext context}) async {
    _dialogLoader = DialogLoader(context: context);
    _dialogLoader.update(
      title: Text(
        title,
        style: TextStyle(color: colors),
      ),
      leftIcon: Icon(
        leftIcon,
        color: colors,
      ),
      // autoClose: false,
      // barrierDismissible: true,
    );
  }
}

class StudentLinkDropDown extends StatefulWidget {
  String dropdownvalue;
  var items = [];
  var hint;
  var onChanges;

  StudentLinkDropDown(
      {required this.dropdownvalue,
      required this.items,
      this.hint,
      this.onChanges});

  @override
  _StudentLinkDropDownState createState() => _StudentLinkDropDownState();
}

class _StudentLinkDropDownState extends State<StudentLinkDropDown> {
  @override
  Widget build(BuildContext context) {
    if (widget.items == null) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0.5,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
          child: DropdownButtonFormField(
            hint: Text(
              widget.hint,
              style: TextStyle(
                letterSpacing: .5,
                fontWeight: FontWeight.w500,
                color: StudentLinkTheme().disText,
                fontSize: StudentLinkTheme().h3,
              ),
            ),
            decoration: InputDecoration(border: InputBorder.none),
            value: widget.dropdownvalue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: [''].map((items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (newValue) {
              widget.dropdownvalue = newValue.toString();
              widget.onChanges(newValue);
            },
          ),
        ),
      );
    } else {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0.5,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
          child: DropdownButtonFormField(
            hint: Text(
              widget.hint,
              style: TextStyle(
                letterSpacing: .5,
                fontWeight: FontWeight.w500,
                color: StudentLinkTheme().disText,
                fontSize: StudentLinkTheme().h3,
              ),
            ),
            decoration: InputDecoration(border: InputBorder.none),
            value: widget.dropdownvalue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: widget.items.map((items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (newValue) {
              widget.dropdownvalue = newValue.toString();
              widget.onChanges(newValue);
            },
          ),
        ),
      );
    }
  }
}

class AdvanceCustomAlert extends StatelessWidget {
  AdvanceCustomAlert(this.applicationId, this.commissionamount);
  var applicationId, commissionamount;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = commissionamount;
    return ProgressHUD(
        child: Builder(
            builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Stack(
                  //overflow: Overflow.visible,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(26))),
                      height: 200,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Comission Request',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: controller,
                              readOnly: true,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_balance_wallet,
                                    color: Colors.black),
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                                hintText: controller.text,
                                hintStyle: TextStyle(color: Colors.black),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 4),
                                isDense: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(26))),
                            width: 120,
                            child: RaisedButton(
                              onPressed: () {
                                final progress = ProgressHUD.of(context);
                                progress!.showWithText('Loading...');
                                var Body = {
                                  'application_id': applicationId.toString(),
                                  'commission_amount':
                                      controller.text.toString(),
                                };
                                Uri commision = Uri(
                                  scheme: 'https',
                                  host: Apis.superlink,
                                  path: Apis.baselink + Apis.commission_url,
                                );
                                RestApi().Post(commision, Body).then((value) {
                                  progress.dismiss();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainAcitivty(
                                                choosedFragment: 3,
                                              )),
                                      (route) => false);
                                  GlobalWidget()
                                      .showToast(msg: 'Commission Requested');
                                }).catchError((onError) {
                                  progress.dismiss();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainAcitivty(
                                                choosedFragment: 3,
                                              )),
                                      (route) => false);
                                  GlobalWidget().showToast(
                                      msg:
                                          '${onError} So Unable to send request');
                                });
                              },

                              //color: StudentLinkTheme().p,
                              child: Text(
                                'Send',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}

class AdvanceCustomAlertcustom extends StatelessWidget {
  AdvanceCustomAlertcustom({required this.applicationlink, required this.head});
  String applicationlink;
  String head;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = applicationlink;
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          //overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(26))),
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    head,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: controller,
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_balance_wallet,
                            color: Colors.grey),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        hintText: controller.text,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(26))),
                    width: 120,
                    child: RaisedButton(
                      onPressed: () async {},
                      color: Colors.orangeAccent,
                      child: Text(
                        'Share',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class AppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_1 = Paint()
      ..color = const Color(0xff112c4f)
      ..style = PaintingStyle.fill;

    Path path_1 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * .08, 0.0)
      ..cubicTo(
          size.width * 0.04,
          0.0, //x1,y1
          0.0,
          0.04, //x2,y2
          0.0,
          0.1 * size.width //x3,y3
          );

    Path path_2 = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width * .92, 0.0)
      ..cubicTo(
          size.width * .96,
          0.0, //x1,y1
          size.width,
          0.96, //x2,y2
          size.width,
          0.1 * size.width //x3,y3
          );

    Paint paint_2 = Paint()
      ..color = const Color(0xff112c4f)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path_3 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0);

    canvas.drawPath(path_1, paint_1);
    canvas.drawPath(path_2, paint_1);
    canvas.drawPath(path_3, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [Pending, Approved, All];

  static const Pending = MenuItem(text: 'Pending', icon: Icons.pending);
  static const Approved =
      MenuItem(text: 'Approved', icon: Icons.approval_rounded);
  static const All = MenuItem(text: 'All', icon: Icons.all_inbox);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
