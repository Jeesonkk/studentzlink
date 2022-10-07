import 'package:flutter/material.dart';
import 'package:studentz_link/utils/styles.dart';

Widget applicationlistingwidget(
    {dynamic width,
    required String firstandlastname,
    required String college_name,
    required String course_name,
    required String applicationId,
    required Widget feeverifyicon,
    required Color feeverifycolor,
    required Widget docverifyicon,
    required Color docverifycolor,
    required String feepaidornottext,
    required Color feepaidornottextcolor}) {
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
          child: Text(
            firstandlastname.toString().toUpperCase(),
            softWrap: true,
            style: TextStyle(
                color: Colors.black87,
                letterSpacing: .5,
                fontSize: StudentLinkTheme().h3,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 6,
        ),

        //Collage name
        Container(
          //  margin: EdgeInsets.only(top: 5,),
          width: width,
          child: Row(
            children: [
              Container(
                  height: 15,
                  width: 15,
                  child: Image.asset(
                    "assets/images/home_screen/graduation.png",
                    color: Colors.black,
                  )),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 180,
                child: Text(
                  college_name.toString().toUpperCase(),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: Colors.black45,
                      letterSpacing: .5,
                      fontWeight: FontWeight.bold,
                      fontSize: StudentLinkTheme().h4),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 6,
        ),

        //Course name
        Row(
          children: [
            Container(
                height: 15,
                width: 15,
                child: Image.asset("assets/images/home_screen/course.jpeg")),
            SizedBox(
              width: 5,
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 3,
              ),
              width: width,
              child: Text(
                course_name.toString().toUpperCase(),
                softWrap: true,
                style: TextStyle(
                    color: Colors.black54,
                    letterSpacing: .5,
                    fontWeight: FontWeight.bold,
                    fontSize: StudentLinkTheme().h4),
              ),
            ),
          ],
        ),

        //ID
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(
            top: 2,
          ),
          width: width,
          child: Text(
            applicationId.toString().toUpperCase(),
            softWrap: true,
            style: TextStyle(
                color: Colors.grey,
                letterSpacing: .5,
                fontWeight: FontWeight.bold,
                fontSize: StudentLinkTheme().h4),
          ),
        ),
        Row(
          children: [
            //fee verify
            Row(
              children: [
                feeverifyicon,
                Text(
                  'Fee',
                  style: TextStyle(
                      color: feeverifycolor, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(width: 3),
            Row(
              children: [
                docverifyicon,
                Text(
                  'Document',
                  style: TextStyle(
                      color: docverifycolor, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(width: 25),
            Text(
              feepaidornottext,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: feepaidornottextcolor),
            ),
          ],
        )
      ],
    ),
  );
}
