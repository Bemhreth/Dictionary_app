import 'package:dictionary_app/component/imagerotater.dart';

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

  List<String> images=[
    'asset/1.jpg',
    'asset/2.jpg',
    'asset/3.jpg',
    'asset/4.jpg',
    'asset/5.jpg',
    'asset/6.jpg',
    'asset/7.jpg',
    'asset/8.jpg',
    'asset/ምድረ.jpg',
    'asset/እንሰት.jpg',
    'asset/እንሰት1.jpg',
    'asset/እንሾሽላ1.jpg',
    'asset/እንሾሽላ2.jpg',
    'asset/ገበጣ.jpg',
    'asset/ጉራጌ.jpg',
    'asset/ጉራጌ1.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
//          title:Text('Kistani Dictionary'),
          backgroundColor: Colors.white,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: ImageRotater(images),
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
                    bottom: TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.home),text: 'Home', ),
                        Tab(icon: Icon(Icons.favorite), text: 'Favourites',),
                        Tab(icon: Icon(Icons.more_horiz), text: 'About',),
                      ],
                    )
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





