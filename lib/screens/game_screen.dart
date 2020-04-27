import 'package:flt_snake_game/consts.dart';
import 'package:flt_snake_game/models/direction.dart';
import 'package:flt_snake_game/snake.dart';
import 'package:flt_snake_game/widgets/position_dot.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static List<int> snakePosition = [45, 65, 85, 105, 125];
  var random = Random();
  int foodPosition;
  Direction direction;

  bool isPaused = true;
  bool gameStarted = false;
  bool gameOver = false;

  void startGame() {
    snakePosition = [45, 65, 85, 105, 125];
    direction = Direction.DOWN;
    generateNewFood();
    const Duration duration = Duration(milliseconds: 300);
    Timer.periodic(duration, (timer) {
      if (!isPaused) {
        updateSnake();
      }
//      if (gameOver) {
//        timer.cancel();
//        _showGameOverScreen()
//      }
    });
  }

  void generateNewFood() {
    foodPosition = random.nextInt(NUMBER_OF_SQUARES - 1);
  }

  void updateSnake() {
    setState(() {
      switch (direction) {
        case Direction.LEFT:
          addSnakePositionWhen(
              condition: snakePosition.last % 20 == 0,
              truePosition: snakePosition.last - 1 + 20,
              falsePosition: snakePosition.last - 1);
          break;
        case Direction.RIGHT:
          addSnakePositionWhen(
              condition: (snakePosition.last + 1) % 20 == 0,
              truePosition: snakePosition.last + 1 - 20,
              falsePosition: snakePosition.last + 1);
          break;
        case Direction.UP:
          addSnakePositionWhen(
              condition: snakePosition.last < 20,
              truePosition: snakePosition.last - 20 + NUMBER_OF_SQUARES,
              falsePosition: snakePosition.last - 20);
          break;
        case Direction.DOWN:
          addSnakePositionWhen(
              condition: snakePosition.last > 680,
              truePosition: snakePosition.last + 20 - NUMBER_OF_SQUARES,
              falsePosition: snakePosition.last + 20);
          break;
      }

      if (snakePosition.last == foodPosition) {
        // TODO: point system
        generateNewFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  void addSnakePositionWhen(
      {bool condition, int truePosition, int falsePosition}) {
    return (condition)
        ? snakePosition.add(truePosition)
        : snakePosition.add(falsePosition);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          child: (isPaused) ? Icon(Icons.play_arrow) : Icon(Icons.pause),
          onPressed: () => updateGameState(),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.direction < 0 && direction != Direction.UP && direction != Direction.DOWN) {
                    direction = Direction.UP;
                  } else if (details.delta.direction > 0 && direction != Direction.UP && direction != Direction.DOWN) {
                    direction = Direction.DOWN;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.direction > 0 && direction != Direction.LEFT && direction != Direction.RIGHT) {
                    direction = Direction.LEFT;
                  } else if (details.delta.direction == 0.0 && direction != Direction.LEFT && direction != Direction.RIGHT) {
                    direction = Direction.RIGHT;
                  }
                },
                child: Container(
                  child: buildGridView(),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: GFButton(
                  color: GFColors.DARK,
                  text: (isPaused) ? "START" : "PAUSE",
                  onPressed: () => updateGameState(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateGameState() {
    return setState(() {
      if (!gameStarted) {
        startGame();
        gameStarted = true;
      }
      isPaused = !isPaused;
    });
  }

  GridView buildGridView() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: NUMBER_OF_SQUARES,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: NUMBER_OF_SQUARES_IN_ROW),
      itemBuilder: (context, index) {
        if (snakePosition.contains(index)) {
          return PositionDot(color: Colors.white);
        }

        if (foodPosition == index) {
          return PositionDot(color: Colors.green);
        }

        return PositionDot(color: Colors.white10);
      },
    );
  }
}
