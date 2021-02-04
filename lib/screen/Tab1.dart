import 'package:flutter/material.dart';


class Tab1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('help'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child:Image.asset('asset/fidel.jpg'),
            ),
            Container(
              color: Colors.white,
              child:Image.asset('asset/help1.jpeg'),
            ),
            Container(
              color: Colors.white,
              child:Image.asset('asset/help2.jpeg'),
            ),
          ],
        ),
      )

       );
  }
}