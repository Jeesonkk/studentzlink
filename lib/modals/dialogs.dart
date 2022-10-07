// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:studentz_link/student_link_global_widget.dart';
// import 'package:studentz_link/utils/styles.dart';

// class Dialogs {
//   void _dialogTemplate(
//       {required BuildContext context,
//       @required title,
//       Color color = Colors.white,
//       bool barrierDismissible = true,
//       Widget? content,
//       List<Widget>? actions}) async {
//     showDialog(
//         //useSafeArea: true,
//         barrierDismissible: barrierDismissible,
//         context: context,
//         builder: (BuildContext context) {
//           return Container(
//             width: MediaQuery.of(context).size.width,
//             child: Theme(
//               data: Theme.of(context).copyWith(dialogBackgroundColor: color),
//               child: AlertDialog(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12),
//                     ),
//                   ),
//                   title: title == null
//                       ? null
//                       : TextView(
//                           title,
//                           color: CoupledTheme().primaryBlue,
//                           size: 18,
//                         ),
//                   content: content,
//                   actions: actions),
//             ),
//           );
//         }).then((value) {
//       editTextController.clear();
//     });
//   }

//   showDialogExitApp(context1) {
//     return _dialogTemplate(
//       context: context1,
//       title: "Do you want to exit Coupled?",
//       actions: <Widget>[
//         CustomButton(
//           width: 80,
//           borderRadius: BorderRadius.circular(2.0),
//           gradient: LinearGradient(colors: [Colors.white, Colors.white]),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: TextView(
//               "No",
//               size: 16,
//               color: Colors.black,
//             ),
//           ),
//           onPressed: () {
//             Navigator.of(context1).pop();
//           },
//         ),
//         CustomButton(
//           width: 80,
//           borderRadius: BorderRadius.circular(2.0),
//           gradient: LinearGradient(colors: [
//             StudentLinkTheme().primary1,
//             StudentLinkTheme().primary2
//           ]),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: TextView(
//               "Yes",
//               size: 16,
//             ),
//           ),
//           onPressed: () {
//             // print('object');
//             // SystemNavigator.pop();
//             if (Platform.isIOS) {
//               Navigator.pop(context1);
//               exit(0);
//             } else {
//               SystemNavigator.pop(animated: true);
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
