import 'package:flutter/material.dart';

import '../constants.dart';


class bottombutton extends StatelessWidget {

  bottombutton({@required this.ontap, @required this.title});

  final Function ontap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        child: Center(child: Text(title,style: klargeTextSyle,)),
        color: kbotomcolor,
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(bottom: 20.0),
        width: double.infinity,
        height: kbottomContainerHeight,
      ),
    );
  }
}