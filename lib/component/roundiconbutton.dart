import 'package:flutter/material.dart';

class roundIconButton extends StatelessWidget {
  roundIconButton({@required this.icon,@required this.function});
  final IconData icon;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: function,
      elevation: 0.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
