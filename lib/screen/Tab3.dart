import 'package:flutter/material.dart';


class Tab3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar:AppBar(
//        title: Text('About'),
//      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Text(' Kistanigna – Amharic – English \n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Dictionary',
              style: TextStyle(color: Color(0xFF8b0000),fontWeight: FontWeight.bold,fontSize: 30),),
              Text('Published by:  © Kistane Gurage People\'s Development Association',
                style: TextStyle(color: Color(0xFF8b0000),fontWeight: FontWeight.bold,fontSize: 30),),
            ],
          ),
        ),
      ),
    );
  }
}