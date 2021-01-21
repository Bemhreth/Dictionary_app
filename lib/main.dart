import 'package:flutter/material.dart';
import 'screen/input_page.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:dictionary_app/utility/dbconnection.dart';
import 'package:dictionary_app/utility/dictionarymodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
 void main() async{
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final pages = [
     'asset/welcome1.jpg',
   'asset/welcome2.jpg',
    'asset/welcome3.jpg',
  ];

  static List<List<dynamic>> def;
  csvtolist() async{

    final myData = await rootBundle.loadString("asset/dictionary.csv");
def=CsvToListConverter(eol: "\n",fieldDelimiter: ",").convert(myData);
     final  List<Map<String, dynamic>> allword= await DBprovider.db.getdictionary();
     if(allword==null){
      for(int i=0;i<def.length;i++){
         var newinfo= Dictionary(Amharic: def[i][0],Kistanigna: def[i][1],English: def[i][2],Definition: def[i][3],Favorite: "0");
         await DBprovider.db.newdictionary(newinfo);
       }
   }else{
       print("ther is");
     }
  }



  @override
  Widget build(BuildContext context) {
    csvtolist();
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
      primaryColor: Color(0xFFadcf1a),
      scaffoldBackgroundColor: Color(0xFFadcf1a),
      ),
      home:InputPage()
    );
  }
}

