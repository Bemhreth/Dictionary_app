import 'package:flutter/material.dart';

import 'constants.dart';

class customData extends StatelessWidget {
  final IconData icons;
  final String text;
  customData({this.icons,this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icons,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(text, style: klableTextStyle)
      ],
    );
  }
}