import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dictionary_app/utility/dbconnection.dart';
import 'package:dictionary_app/utility/dictionarymodel.dart';
import 'package:sqflite/sqflite.dart';

import '../favorite_words_route.dart';


List<String> savedWords = List<String>();
class Item {
  const Item(this.name,this.icon);

  final String name;
  final Icon icon;
}
class ResultsPage extends StatefulWidget {
   String definition;
   String Mainlanguage;
   String language1;
   String language2;
  ResultsPage(this.definition,this.language1,this.language2,this.Mainlanguage);
  @override

  _ResultsPageState createState() => _ResultsPageState();

}
class _ResultsPageState extends State<ResultsPage> {



//  String _url = "https://owlbot.info/api/v4/dictionary/";
//  String _token = "6bcd31a2dff4b7e3c3b0c10eda0408625e6f0950";
  Item selectedUser;
  List<Item> users = <Item>[
    const Item('Kistanigna',Icon(Icons.language,color: Colors.greenAccent,)),
    const Item('Amharic',Icon(Icons.language,color:  Colors.greenAccent,)),
    const Item('English',Icon(Icons.language,color:  Colors.greenAccent,)),
  ];
  TextEditingController _controller = TextEditingController();

  StreamController _streamController;
  Stream _stream;

  Timer _debounce;
  Color fevcolor=Colors.black;
  Future _futurevalue;

  void _search (text) async {
    print('element');
    Database db = await DBprovider.db.getdictionary();
  List<Map> result = await db.rawQuery("SELECT content FROM table WHERE content LIKE '%$text%'");

    setState(() {
  result.forEach((element) {
  print('element');
  print(element['English']);
//String  course = result;
  });


  });
  }

//    _streamController.add("waiting");
//    Response response = await get(_url + _controller.text.trim(), headers: {"Authorization": "Token " + _token});
//    _streamController.add(json.decode(response.body));
//  }

  @override
  void initState() {
    super.initState();
    _futurevalue=getdictionary();
    _streamController = StreamController();
    _stream = _streamController.stream;
  }
  List<Map<String, dynamic>> all;

  getdictionary() async{

      all= await DBprovider.db.getdictionary();
      print(all);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[

              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.black26,
                    style:TextStyle(color: Colors.black),
                    onChanged: (String text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                        _search(text);
                      });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Search for a word",
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
//                  _search();
                },
              ),
              Card(
                elevation: 5,
                color: Colors.white,
                child: Expanded(
                  flex: 1,
                  child:DropdownButton<Item>(
                    value: selectedUser==null?selectedUser=users[0]:selectedUser,
                    onChanged: (Item Value) {
                      setState(() {
                        selectedUser = Value;
                        widget.Mainlanguage=selectedUser.name;
                        print(selectedUser.name);
                      });
                    },
                    items: users.map((Item user) {
                      return  DropdownMenuItem<Item>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            user.icon,
                            SizedBox(width: 10,),
                            Text(
                              user.name,
                              style:  TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: FutureBuilder(
        future: _futurevalue,
        builder: (context, snapshot) {

          switch(snapshot.connectionState){
            case ConnectionState.none:
              return Text('Waiting...');
            case ConnectionState.active:
              return  Text('Waiting...');
            case ConnectionState.done:
              return ListView.builder(
                itemCount: all.length,

                itemBuilder: (BuildContext context, int index) {
                  String word=all[index]['Kistanigna'];
                  bool isSaved = savedWords.contains(word);
                  return ListBody(
                    children: <Widget>[
                      Container(
                        color: Color(0xFF111328),
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ListTile(

                                  title: Text(
                                    widget.Mainlanguage=='Kistanigna'?  all[index]['Kistanigna']: all[index][widget.Mainlanguage] + "(" + all[index]['Kistanigna'] +
                                        ")", style: TextStyle(color: Colors.black),),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) => _buildAboutDialog(context),
                                    );
                                    setState(() {
                                      widget.language1=all[index]['Amharic'];
                                      widget.language2=all[index]['English'];
                                      widget.definition=all[index]['Definition'];
                                    });
                                  },
                                ),
                              ),
                              IconButton(

                              icon: Icon(
                                isSaved? Icons.star : Icons.star_border,
                                color: isSaved ? Colors.red : Colors.black,
                              ),
                         onPressed: (){

                             print(word);

                             if (all[index]['Favorite']!="0") {
                               setState(() {
                                 savedWords.remove(word);
                                 DBprovider.db.updateall(all[index]['id'], Dictionary(Amharic: all[index]['Amharic'],Kistanigna: all[index]['Kistanigna'],English: all[index]['English'],Definition: all[index]['Definition'],Favorite: "0"));
                                 DBprovider.db.deletefavorite(all[index]['Kistanigna']);
                             });
                             } else {
                               setState(() {
                                 savedWords.add(word);
                                 var newinfo= Dictionary(Amharic: all[index]['Amharic'],Kistanigna: all[index]['Kistanigna'],English: all[index]['English'],Definition: all[index]['Definition'],Favorite: "1");
                                 DBprovider.db.newdictionary(newinfo);
                                 DBprovider.db.updateall(all[index]['id'], Dictionary(Amharic: all[index]['Amharic'],Kistanigna: all[index]['Kistanigna'],English: all[index]['English'],Definition: all[index]['Definition'],Favorite: "1"));
                               });

                             }


                                      },
                            )
                          ],
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                      )
                    ],
                  );
                },
              );
            default:
              return Text("Loading...",style: TextStyle(fontSize: 40),);
          }

        }
        )
      ),
    );
  }
  Widget _buildAboutDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Definition'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(),
          _buildLogoAttribution(),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Card(elevation: 5,color: Colors.white,child: Text(widget.Mainlanguage=='English'?'Ok':'እሺ',style: const TextStyle(color: Color(0xFF111328)))),
        ),
      ],
    );
  }
  Widget _buildAboutText() {
    return new RichText(
      text: new TextSpan(
        text: widget.language1+'\n\n',
        style: const TextStyle(color: Colors.white),
        children: <TextSpan>[
           TextSpan(text:widget.language2+'\n\n\n',style: TextStyle(color: Colors.white)),

          TextSpan(
            text:widget.definition,style: TextStyle(color: Colors.white)
          ),

          const TextSpan(text: '.'),
        ],
      ),
    );
  }
  Widget _buildLogoAttribution() {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: new Image.asset(
              "assets/flutter.png",
              width: 32.0,
            ),
          ),

        ],
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<StreamController>('_streamController', _streamController));
  }
  Future pushToFavoriteWordsRoute(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => FavoriteWordsRoute(
          favoriteItems: savedWords,
        ),
      ),
    );
  }
}