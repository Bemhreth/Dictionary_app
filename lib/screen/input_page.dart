import 'package:dictionary_app/component/imagerotater.dart';

import 'Tab2.dart';
import 'Tab3.dart';
import 'package:flutter/material.dart';
import 'result_page.dart';



class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;
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
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
      return <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            forceElevated: boxIsScrolled,
            backgroundColor: Colors.white,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: ImageRotater(images,0),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home,color: Color(0xFF8b0000),),text: 'Home', ),
                Tab(icon: Icon(Icons.favorite,color: Color(0xFF8b0000),), text: 'Favourites',),
                Tab(icon: Icon(Icons.more_horiz,color: Color(0xFF8b0000),), text: 'About',),
              ],
              controller: _tabController,
              labelColor: Color(0xFF8b0000),
            ),
          ),
//          SliverFixedExtentList(
//            itemExtent: 900.0,
//            delegate: SliverChildListDelegate(
//              [
//                DefaultTabController(
//                  length: 3,
//                  child: Scaffold(
//
//                    appBar: AppBar(
//                      bottom: TabBar(
//                        tabs: [
//                          Tab(icon: Icon(Icons.home),text: 'Home', ),
//                          Tab(icon: Icon(Icons.favorite), text: 'Favourites',),
//                          Tab(icon: Icon(Icons.more_horiz), text: 'About',),
//                        ],
//                      )
//                    ),
//                    body: TabBarView(
//                      children: [
//                        ResultsPage('ኣመረተ','English','Amharic','Kistanigna',null),
//                        Tab2('ኣመረተ','English','Amharic','Kistanigna'),
//                        Tab3(),
//                      ],
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
     ];
      },
            body:TabBarView(
              children: <Widget>[
                ResultsPage('ኣመረተ','English','Amharic','Kistanigna',null),
                Tab2('ኣመረተ','English','Amharic','Kistanigna'),
                Tab3(),
              ],
              controller: _tabController,
            ),
      ),
    );
  }
}





