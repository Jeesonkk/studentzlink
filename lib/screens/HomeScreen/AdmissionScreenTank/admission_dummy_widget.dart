import 'package:flutter/material.dart';
import 'package:studentz_link/utils/styles.dart';

Widget admissionlistingdummywidget({
  dynamic width,
}) {
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
            child: Container(
              height: 20,
              width: 400,
            )),
        SizedBox(
          height: 6,
        ),

        //Collage name
        Container(
            //  margin: EdgeInsets.only(top: 5,),
            width: width,
            child: Container(
              height: 20,
              width: 300,
            )),

        const SizedBox(
          height: 6,
        ),

        //Course name
        Container(
            margin: const EdgeInsets.only(
              top: 3,
            ),
            width: width,
            child: Container(
              height: 20,
              width: 200,
            )),

        //ID
        Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(
              top: 2,
            ),
            width: width,
            child: Container(height: 10, width: 100)),
      ],
    ),
  );
}
