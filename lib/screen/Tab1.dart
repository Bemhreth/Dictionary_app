//
//import '../component/reusablecard.dart';
//import 'package:flutter/material.dart';
//
//
//import '../component/customdata.dart';
//import '../constants.dart';
//import 'result_page.dart';
//
//class Tab1 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return TabMain();
//  }
//}
//
///// This is the stateless widget that the main application instantiates.
//class TabMain extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        child: Column(
//          children: <Widget>[
//            Expanded(
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: ReusableCard(
//                      ontap:  (){
//                        Navigator.push(context,MaterialPageRoute(
//                            builder: (context){
//                              return ResultsPage(
//
//                              );
//                            }
//                        ));
//                      },
//                      colour: kpagecolor,
//                      cardChild: customData(
//                        icons: Icons.person,
//                        text: 'All',
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    child: ReusableCard(
//                      ontap:  (){
//                        Navigator.push(context,MaterialPageRoute(
//                            builder: (context){
//                              return ResultsPage(
//
//                              );
//                            }
//                        ));
//                      },
//                      colour: kpagecolor,
//                      cardChild: customData(
//                        icons: Icons.person,
//                        text: 'Plants',
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Expanded(
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: ReusableCard(
//                      ontap:  (){
//                        Navigator.push(context,MaterialPageRoute(
//                            builder: (context){
//                              return ResultsPage(
//
//                              );
//                            }
//                        ));
//                      },
//                      colour: kpagecolor,
//                      cardChild: customData(
//                        icons: Icons.person,
//                        text: 'Animal',
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    child: ReusableCard(
//                      ontap:  (){
//                        Navigator.push(context,MaterialPageRoute(
//                            builder: (context){
//                              return ResultsPage(
//
//                              );
//                            }
//                        ));
//                      },
//                      colour: kpagecolor,
//                      cardChild: customData(
//                        icons: Icons.person,
//                        text: 'Foods',
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Expanded(
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: ReusableCard(
//                      ontap:  (){
//                        Navigator.push(context,MaterialPageRoute(
//                            builder: (context){
//                              return ResultsPage(
//
//                              );
//                            }
//                        ));
//                      },
//                      colour: kpagecolor,
//                      cardChild: customData(
//                        icons: Icons.person,
//                        text: 'Drinks',
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    child: ReusableCard(
//                      ontap:  (){
//                        Navigator.push(context,MaterialPageRoute(
//                            builder: (context){
//                              return ResultsPage(
//
//                              );
//                            }
//                        ));
//                      },
//                      colour: kpagecolor,
//                      cardChild: customData(
//                        icons: Icons.person,
//                        text: 'Goods',
//                      ),
//                    ),
//                  ),
//
//                ],
//              ),
//            ),
//          ],
//        )
//    );
//  }
//}