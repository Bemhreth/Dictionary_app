import 'Tab2.dart';
import 'Tab3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'result_page.dart';



class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {


  @override
  Widget build(BuildContext context) {
    //csvtolist();
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
//          centerTitle: true,
          pinned: true,

          title:Text('Kistanigna Dictionary'),
//          FlatButton(
//
//        onPressed: () => {
//        Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => Tab3()),
//        )},
//    child: Column( // Replace with a Row for horizontal icon + text
//    children: <Widget>[
//    Icon(Icons.info)
//    ],)),
          backgroundColor: Colors.green,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset('asset/forest.jpg', fit: BoxFit.cover),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 900.0,
          delegate: SliverChildListDelegate(
            [
              DefaultTabController(
                length: 3,
                child: Scaffold(

                  appBar: AppBar(
//                    title: Card(
//                      child: TextField(
//                        decoration: InputDecoration(
//                            border: InputBorder.none,
//                            hintText: 'What are you looking for?'
//                        ),
//                      ),
//                    ),
                    bottom: TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.home),text: 'Home', ),
                        Tab(icon: Icon(Icons.favorite), text: 'Favourites',),
                        Tab(icon: Icon(Icons.info), text: 'About',),
                      ],
                    ),
                    // title: Text('Tabs Demo'),
                  ),
                  body: TabBarView(
                    children: [
                      ResultsPage('ኣመረተ','English','Amharic','Kistanigna',null),
                      Tab2('ኣመረተ','English','Amharic','Kistanigna'),
                      Tab3(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}





