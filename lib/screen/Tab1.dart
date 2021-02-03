import 'package:flutter/material.dart';


class Tab1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('የክስታንኛ የፊደል ገበታ'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child:Image.asset('asset/fidel.jpg'),
        ),
      )

       );
  }
}