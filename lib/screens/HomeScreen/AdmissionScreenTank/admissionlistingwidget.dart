import 'package:flutter/material.dart';
import 'package:studentz_link/utils/styles.dart';

Widget admissionlistingwidget(
    {dynamic width,
    required String firstandlastname,
    required String college_name,
    required String course_name,
    required String id,
    required int firstYearFeeStatus,
    required Function()? requestcommissionpressed}) {
  return Container(
    width: width,
    padding: EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Name
        Container(
          //margin: EdgeInsets.only(top: 6,),
          width: width,
          child: Row(
            children: [
              Text(
                firstandlastname.toString().toUpperCase(),
                softWrap: true,
                style: TextStyle(
                    color: Colors.black87,
                    letterSpacing: .5,
                    fontSize: StudentLinkTheme().h3,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 6,
        ),

        //Collage name
        Container(
          //  margin: EdgeInsets.only(top: 5,),
          width: 180,
          child: Text(
            'College:' + college_name.toString().toUpperCase(),
            softWrap: true,
            overflow: TextOverflow.clip,
            style: TextStyle(
                color: Colors.black54,
                letterSpacing: .5,
                fontWeight: FontWeight.bold,
                fontSize: StudentLinkTheme().h4),
          ),
        ),

        const SizedBox(
          height: 6,
        ),

        //Course name
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 3,
              ),
              width: width,
              child: Text(
                'Course:' + course_name,
                softWrap: true,
                style: TextStyle(
                    color: Colors.black54,
                    letterSpacing: .5,
                    fontWeight: FontWeight.bold,
                    fontSize: StudentLinkTheme().h4),
              ),
            ),
            if (id != 'Partner')
              Container()
            else if (firstYearFeeStatus == 0)
              IconButton(
                  splashRadius: 20,
                  iconSize: 15,
                  icon: ImageIcon(
                    AssetImage("assets/images/home_screen/icons/share.png"),
                    color: StudentLinkTheme().primary1,
                  ),
                  onPressed: requestcommissionpressed)
            else
              Container()
          ],
        ),

        //ID
      ],
    ),
  );
}
