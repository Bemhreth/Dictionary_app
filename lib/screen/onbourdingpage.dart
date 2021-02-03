import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'input_page.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  List<Map> all=List<Map>();

  Future<void> _onIntroEnd(context) async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => InputPage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('asset/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "",
          body:
          "",
          image: _buildImage('intro2'),
//          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kistane Gurage People's Development Association",
          body:
          "All right reserved, No part of this publication may be reproduced, stored in a retrieval system, or transmitted, in any form or by any means, without the prior permission in writing of Kistane Gurage People's Development Association.",
          image: _buildImage('intro1'),
//          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body:
          "",
          image: _buildImage('intro3'),
//          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip',style: TextStyle(color: Colors.black),),
      next: const Icon(Icons.arrow_forward,color: Colors.black),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.black,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}