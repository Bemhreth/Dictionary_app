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
class Tab2 extends StatefulWidget {
  String definition;
  String Mainlanguage;
  String language1;
  String language2;
  Tab2(this.definition,this.language1,this.language2,this.Mainlanguage);
  @override

  _Tab2State createState() => _Tab2State();

}
class _Tab2State extends State<Tab2> {

  Item selectedUser;
  List<Item> users = <Item>[
    const Item('ክስታንኛ',Icon(Icons.language,color: Colors.black,)),
    const Item('አማርኛ',Icon(Icons.language,color:  Colors.black,)),
    const Item('English',Icon(Icons.language,color:  Colors.black,)),
  ];
  TextEditingController _controller = TextEditingController();


  Timer _debounce;
  var itemCount=1;
  StreamController _streamController;
  Stream _stream;
  Future _futurevalue;



  @override
  void initState() {
    super.initState();
    _futurevalue=getdictionary();

  }
  List<Map<String, dynamic>> all;
  List<Map<String, dynamic>> alls;


  getdictionary() async{

    alls= await DBprovider.db.getfavorite();
    print("favorit database $all");
    if(alls!=null){
      print("favorit database $all");
      setState(() {
        all=alls;
      });
      itemCount=alls.length;
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(38.0),
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: DropdownButton<Item>(
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
                      itemCount: itemCount,

                      itemBuilder: (BuildContext context, int index) {

                        return alls!=null? ListBody(
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
                                  IconButton(icon: Icon(Icons.delete,color: Colors.red,)
                                      ,
                                      onPressed: (){
                                        setState(() {
                                          DBprovider.db.deletefavorite(all[index]['Kistanigna']);
                                          getdictionary();
                                          DBprovider.db.updatefev(all[index]['Kistanigna'],0);
                                        });
                                      }
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                            )
                          ],
                        ):Center(child: Text("No Favorite!",style: TextStyle(fontSize: 40),),);
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
          TextSpan(text:widget.language2+'\n\n\n'),

          TextSpan(
            text:widget.definition,
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