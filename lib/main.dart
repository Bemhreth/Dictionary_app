import 'package:flutter/material.dart';
import 'screen/input_page.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:dictionary_app/utility/dbconnection.dart';
import 'package:dictionary_app/utility/dictionarymodel.dart';
import 'package:splashscreen/splashscreen.dart';

 void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
   runApp(MyApp());


}

class MyApp extends StatelessWidget {
  static List<List<dynamic>> def;
  csvtolist() async{

    final myData = await rootBundle.loadString("asset/dictionary.csv");
def=CsvToListConverter(eol: "\n",fieldDelimiter: ",").convert(myData);
//     def = CsvToListConverter(eol: "\n",fieldDelimiter: ",").convert(myData);


    //   File  dictionary=new File( await rootBundle.loadString('asset/dictionary.csv'));
  //   CsvToListConverter c=new CsvToListConverter(eol: "\r\n",fieldDelimiter: ",");
  //   def=c.convert(dictionary.readAsStringSync());
  //   print(def);
     final  List<Map<String, dynamic>> allword= await DBprovider.db.getdictionary();
     if(allword==null){
     print("empty");
      for(int i=0;i<def.length;i++){
     // print(def[i][0]);
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
      primaryColor: Color(0xFFBFEFFF),
      scaffoldBackgroundColor: Color(0xFFBFEFFF),
      ),
      home: new SplashScreen(
          seconds: 3,
          navigateAfterSeconds: InputPage(),
          title: new Text('Welcome In SplashScreen',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
            ),),
          image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          onClick: ()=>print("Flutter Egypt"),
          loaderColor: Colors.red

      ),
    );
  }
}

