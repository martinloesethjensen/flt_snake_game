import 'package:flt_snake_game/consts.dart';
import 'package:flt_snake_game/snake.dart';
import 'package:flt_snake_game/widgets/position_dot.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static List<int> snakePosition = Snake().positions;

  int foodPosition = 89;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                print(details.delta.direction);
              },
              onHorizontalDragUpdate: (details) {
                print(details.delta.direction);
              },
              child: Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: NUMBER_OF_SQUARES,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: NUMBER_OF_SQUARES_IN_ROW,
                  ),
                  itemBuilder: (context, index) {
                    if (snakePosition.contains(index))
                      return PositionDot(
                        color: Colors.white,
                      );

                    if (foodPosition == index)
                      return PositionDot(
                        color: Colors.green,
                      );

                    return PositionDot(
                      color: Colors.white10,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
