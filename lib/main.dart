import 'package:flt_snake_game/screens/game_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(SnakeApp());

class SnakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
    );
  }
}
