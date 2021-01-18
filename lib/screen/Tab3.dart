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
          child: Center(
             child: Text('no data')
          ),
        ),
      ),
    );
  }
}