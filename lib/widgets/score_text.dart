import 'package:flutter/material.dart';

class ScoreTextWidget extends StatelessWidget {
  const ScoreTextWidget({
    Key key,
    @required this.text,
    @required this.score,
  }) : super(key: key);

  final int score;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      text: TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 19.0),
        children: [
          TextSpan(
            text: "$text: ".toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "$score"),
        ],
      ),
    );
  }
}
