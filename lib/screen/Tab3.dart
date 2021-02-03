import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Tab1.dart';


class Tab3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Text(' Kistanigna – Amharic – English',
              style: TextStyle(color: Color(0xFF8b0000),fontWeight: FontWeight.bold,fontSize: 20),),
              Center(
                child: Text('Dictionary',
                  style: TextStyle(color: Color(0xFF8b0000),fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              SizedBox(height: 35,),
              FlatButton(onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => Tab1()),
                  );
              }, child:Card(
                elevation: 5,
                color:Color(0xFFadcf1a),
                child: Text('የክስታንኛ የፊደል ገበታ ለመመልከት ይህንን ይጫኑ',
                  style: TextStyle(color: Color(0xFF8b0000),fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),),
              SizedBox(height: 35,),
              Text('Introduction: Kistanigna is a language spoken among the Gurage People.',
                style: TextStyle(color: Color(0xFF8b0000),fontSize: 19),
              ),
              SizedBox(height: 35,),
              Text('Published by:  © Kistane Gurage People\'s Development Association',
                style: TextStyle(color: Color(0xFF8b0000),fontSize: 19),),
              SizedBox(height: 35,),

              Text('Developed by: Bemhereth Gezahegn and Amanuel Chala',
                style: TextStyle(color: Color(0xFF8b0000),fontSize: 19),),

              SizedBox(height: 60,),
              RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            style: TextStyle(color: Color(0xFF8b0000),fontSize: 20),
                            text: "To learn more ",


                        ),
                        TextSpan(
                            style: TextStyle(color: Colors.red,fontSize: 20,decoration: TextDecoration.underline,),
                            text: "Click here",
                            recognizer: TapGestureRecognizer()..onTap =  () async{
                              var url = "https://drive.google.com/file/d/1LmaZwU_Ji0qS52Rf7ZVeRKjn7u627nWf/view?usp=drivesdk";
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            }
                        ),
                      ]
                  )),
              SizedBox(height: 15,),
              Center(
                child: Text('V1.0',
                  style: TextStyle(color: Color(0xFF8b0000),fontWeight: FontWeight.bold,fontSize: 30),),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text('©2021 Ejbat ',
                  style: TextStyle(color: Color(0xFF8b0000),fontWeight: FontWeight.bold,fontSize: 30),),
              ),

            ],
          ),

        ),

      ),
    );
  }
}