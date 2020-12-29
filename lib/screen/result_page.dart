import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:dictionary_app/utility/dbconnection.dart';

class Item {
  const Item(this.name,this.icon);

  final String name;
  final Icon icon;
}
class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}
class _ResultsPageState extends State<ResultsPage> {

//  String _url = "https://owlbot.info/api/v4/dictionary/";
//  String _token = "6bcd31a2dff4b7e3c3b0c10eda0408625e6f0950";
  Item selectedUser;
  List<Item> users = <Item>[
    const Item('Kistanigna',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
    const Item('Amharic',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
    const Item('English',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
  ];
  TextEditingController _controller = TextEditingController();

  StreamController _streamController;
  Stream _stream;

  Timer _debounce;
  Color fevcolor=Colors.black;
  Future _futurevalue;

//  _search() async {
//    if (_controller.text == null || _controller.text.length == 0) {
//      _streamController.add(null);
//      return;
//    }

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
    String language;
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
//                        _search();
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
              Expanded(
                flex: 1,
                child:DropdownButton<Item>(
                  hint:  Text("Select language",style: TextStyle(color: Colors.white),),
                  value: selectedUser,
                  onChanged: (Item Value) {
                    setState(() {
                      selectedUser = Value;
                      language=selectedUser.name;
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
                  return ListBody(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(

                                title: Text(
                                 language==null? _controller.text.trim() + "(" + all[index]['Kistanigna'] +
                            ")": _controller.text.trim() + "(" + all[index][language] +
                                      ")", style: TextStyle(color: Colors.black),),
                                onTap: () {
                                  setState(() {
                                    if (fevcolor == Colors.red)
                                      fevcolor = Colors.black;
                                    else
                                      fevcolor = Colors.red;
                                  });
                                },
                              ),
                            ),
                            IconButton(

                              icon: Icon(
                                fevcolor == Colors.red ? Icons.star : Icons.star_border,
                                color: fevcolor,
                              ),

                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(all[index]['Definition']),
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
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<StreamController>('_streamController', _streamController));
  }
}