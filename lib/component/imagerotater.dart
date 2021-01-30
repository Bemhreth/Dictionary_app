import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';

class ImageRotater extends StatefulWidget {
  List<String> photos;
  int check;

  ImageRotater(this.photos, this.check);

  @override
  State<StatefulWidget> createState() => new ImageRotaterState();
}

class ImageRotaterState extends State<ImageRotater> {
  var _pos1 = new Random();
  int _pos = 0;
  Timer _timer;

  @override
  void initState() {
    if(widget.check==0){
  const oneSec = const Duration(seconds: 10);
    _timer = new Timer.periodic( oneSec, (Timer timer) => setState( () {
    _pos=_pos1.nextInt(15).toInt();
     }, ), );
    }
    else if(widget.check==1){
      const oneSec = const Duration(seconds: 3);
      _timer = new Timer.periodic( oneSec, (Timer timer) => setState( () {
        _pos=_pos1.nextInt(2).toInt();
      }, ), );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Image.asset(
      widget.photos[_pos],
      gaplessPlayback: true,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }
}