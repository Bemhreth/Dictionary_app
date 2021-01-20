import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dictionary_app/utility/dbconnection.dart';
import 'package:dictionary_app/utility/dictionarymodel.dart';


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
   String T;
  ResultsPage(this.definition,this.language1,this.language2,this.Mainlanguage,this.T);
  @override

  _ResultsPageState createState() => _ResultsPageState();

}
class _ResultsPageState extends State<ResultsPage> {

  Item selectedUser;
  List<Item> users = <Item>[
    const Item('ክስታንኛ',Icon(Icons.language,color: Colors.greenAccent,)),
    const Item('አማርኛ',Icon(Icons.language,color:  Colors.greenAccent,)),
    const Item('English',Icon(Icons.language,color:  Colors.greenAccent,)),
  ];
  TextEditingController _controller = TextEditingController();

  StreamController _streamController;
  Stream _stream;
  List<Map> all=List<Map>();
  List<Map> alls=List<Map>();
  List<Map> allz=List<Map>();
  List<Map<String, dynamic>> all1=List<Map<String, dynamic>>();
  Timer _debounce;
  Color fevcolor=Colors.black;
  Future _futurevalue;

  void _search (text)  {
        if(text.isNotEmpty) {
          print(text);
      List<Map> dListData = List<Map>();
      allz.forEach((element) {
        print('kinda');
        switch (widget.Mainlanguage) {
          case 'English':
            print('yes');
            element['English'].toString().toLowerCase();
            if( element['English'].contains(text.toLowerCase())){
              dListData.add(element);
            }
            break;
          case 'Amharic':
            if( element['Amharic'].contains(text)){
              dListData.add(element);
            }
            break;
          case 'Kistanigna':
            if( element['Kistanigna'].contains(text)){
              dListData.add(element);
            }
            break;
        }
      });
      setState(()  {
        all.clear();
        all.addAll(dListData);
        dListData.clear();
      });
      return;
    } else {
      setState(()  {
        all.clear();
        getdictionary();
      });
    }
  }
  @override
  Future<void> initState()  {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    _futurevalue=getdictionary();
  }


  getdictionary() async{
    alls= List.of(await DBprovider.db.getdictionary());
    all= List.of(await DBprovider.db.getdictionary());
    allz= List.of(await DBprovider.db.getdictionary());
    setState(() {
      all=alls;
//      print(all);
    });
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
//                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.black26,
                    style:TextStyle(color: Colors.black),
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    onFieldSubmitted:(String text){
                      _search(text);
                      setState(() {
                        widget.T=text;
                      });
                    },
                    onChanged: (String text) {
                        if (_debounce?.isActive ?? false) _debounce.cancel();
                        _debounce = Timer(const Duration(milliseconds: 1000), () {
                          setState(() {
                              _search(text);
                            widget.T=text;
                          });
                        });
                    },
                    decoration: InputDecoration(
                      hintText: (widget.Mainlanguage=='English')?"Search in English": (widget.Mainlanguage=='Amharic')?"በአማርኛ ይፈልጉ":"በክስታንኛ ሻ",
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
                  _search(widget.T);
                },
              ),
              Card(
                elevation: 5,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    DropdownButton<Item>(
                      dropdownColor: Colors.white,
                      value: selectedUser==null?selectedUser=users[0]:selectedUser,
                      onChanged: (Item Value) {
                        setState(() {
                          selectedUser = Value;
                          (selectedUser.name=='ክስታንኛ')?widget.Mainlanguage='Kistanigna':(selectedUser.name=='አማርኛ')?widget.Mainlanguage='Amharic':widget.Mainlanguage=selectedUser.name;
                          print(selectedUser.name);
                        });
                      },
                      items: users.map((Item user) {
                        return  DropdownMenuItem<Item>(
                          value: user,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 15,),
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
                    Icon(Icons.arrow_drop_down,color: Colors.black,)
                  ],
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
              return Center(child: Text('Waiting...'));
            case ConnectionState.active:
              return  Center(child: Text('Waiting...'));
            case ConnectionState.done:
              return ListView.builder(
                itemCount: all.length,

                itemBuilder: (BuildContext context, int index) {
                  String word=all[index]['Kistanigna'];
                  bool isSaved = savedWords.contains(word);
                  return ListBody(
                    children: <Widget>[
                      Card(
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
                              all[index]['Favorite']!="0"? Icons.star : Icons.star_border,
                              color: all[index]['Favorite']!="0" ? Colors.red : Colors.black,
                            ),
                       onPressed: (){

//                           print(word);

                           if (all[index]['Favorite']!="0") {
                             setState(() {
                               //savedWords.remove(word);
                               DBprovider.db.updateall(all[index]['id'], Dictionary(Amharic: all[index]['Amharic'],Kistanigna: all[index]['Kistanigna'],English: all[index]['English'],Definition: all[index]['Definition'],Favorite: "0"));
                               DBprovider.db.deletefavorite(all[index]['Kistanigna']);
                               getdictionary();
                           });
                           } else {
                             setState(() {
                              // savedWords.add(word);
                               var newinfo= Dictionary(Amharic: all[index]['Amharic'],Kistanigna: all[index]['Kistanigna'],English: all[index]['English'],Definition: all[index]['Definition'],Favorite: "1");
                               DBprovider.db.newsfavorite(newinfo);
                               DBprovider.db.updateall(all[index]['id'], Dictionary(Amharic: all[index]['Amharic'],Kistanigna: all[index]['Kistanigna'],English: all[index]['English'],Definition: all[index]['Definition'],Favorite: "1"));
                               getdictionary();
                             });

                           }


                                    },
                          )
                        ],
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                      )
                    ],
                  );
                },
              );
            default:
              return Center(child: Text("Loading...",style: TextStyle(fontSize: 40),));
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
}