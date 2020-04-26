import 'package:flutter/material.dart';

class PositionDot extends StatelessWidget {
  final Color color;

  const PositionDot({Key key, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(color: color),
        ),
      ),
    );
  }
}