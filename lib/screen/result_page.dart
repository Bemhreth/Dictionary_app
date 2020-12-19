import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:dictionary_app/utility/dbconnection.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}
class _ResultsPageState extends State<ResultsPage> {

  String _url = "https://owlbot.info/api/v4/dictionary/";
  String _token = "6bcd31a2dff4b7e3c3b0c10eda0408625e6f0950";

  TextEditingController _controller = TextEditingController();

  StreamController _streamController;
  Stream _stream;

  Timer _debounce;
  Color fevcolor=Colors.black;
  Future _futurevalue;

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");
    Response response = await get(_url + _controller.text.trim(), headers: {"Authorization": "Token " + _token});
    _streamController.add(json.decode(response.body));
  }

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

    List<String> savedWords = List<String>();
    String word = "yes";
    bool isClicked=savedWords.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
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
                        _search();
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
                  _search();
                },
              )
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
                                  _controller.text.trim() + "(" + all[index]['Kistanigna'] +
                                      ")", style: TextStyle(color: Colors.black),),
                              ),
                            ),
                            IconButton(

                              icon: Icon(
                                fevcolor == Colors.red ? Icons.star : Icons
                                    .star_border,
                                color: fevcolor,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (fevcolor == Colors.red)
                                    fevcolor = Colors.black;
                                  else
                                    fevcolor = Colors.red;
                                });
                              },
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
              return Text("Failed",style: TextStyle(fontSize: 40),);
          }

        }
        )
      ),
    );
  }
}