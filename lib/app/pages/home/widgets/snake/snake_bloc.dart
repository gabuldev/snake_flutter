import 'dart:async';
import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:snake/app/shared/models/food_model.dart';
import 'package:snake/app/shared/models/position_model.dart';
import 'package:snake/app/shared/models/snake_model.dart';

enum Direction { up, down, left, right }

class SnakeBloc extends BlocBase {
  final SnakeModel snake;

  Direction lastDirection;

  Timer walkingTimer;

  SnakeBloc(this.snake) {
    positionOut = position.stream;
    positionIn = position.sink;

    foodOut = foods.stream;
    foodIn = foods.sink;
    randFood();
  }

//SNAKE
  var position = BehaviorSubject<List<PositionModel>>.seeded([
    PositionModel(0.0, 0.0, head: true),
    /* PositionModel(20.0, 0.0),
    PositionModel(40.0, 0.0),
    PositionModel(60.0, 0.0),
    PositionModel(80.0, 0.0),
    PositionModel(100.0, 0.0)*/
  ]);
  Observable<List<PositionModel>> positionOut;
  Sink<List<PositionModel>> positionIn;

  //FOOD
  var foods = BehaviorSubject<List<FoodModel>>();
  Observable<List<FoodModel>> foodOut;
  Sink<List<FoodModel>> foodIn;
  List<FoodModel> get foodsValue => foods.value;

//FUCNTIONS FOOD

//FUNCTIONS SNAKE
  updatePosition(PositionModel pos) {
    var lastList = position.value;
    var last = lastList.last;
    var firstPosition = lastList.first;
    firstPosition.head = false;
    var newPosition = lastList.first + pos; // Da cabeca

    var deleteFood;
    bool isFood = false;

    List<PositionModel> newList = [];

    if (!lastList.contains(newPosition)) {
      //VERIFICA SE ESTA NA POSICAO DA COMIDA,
      foodsValue.forEach((i) {
        if (i.position == newPosition) {
          deleteFood = i;
          isFood = true;
          return true;
        } else {
          return false;
        }
      });

      if (newPosition.x >= 0 &&
          newPosition.x < 400 &&
          newPosition.y >= 0 &&
          newPosition.y < 400) {
        newPosition.head = true;
        newList.add(newPosition);
        positionIn.add(newList);
        lastList.removeAt(0);

        lastList.forEach((i) {
          if (firstPosition.x >= 0 &&
              firstPosition.x < 400 &&
              firstPosition.y >= 0 &&
              firstPosition.y < 400) {
            newList.add(firstPosition);
            positionIn.add(newList);
            firstPosition = i;
          }
        });

//SE TEVE COMIDA, ELE TEM QUE REMOVER E ADICIONAR NA ULTIMA POSICAO
        if (isFood) {
          var food = foodsValue;
          food.remove(deleteFood);
          if (food.length == 0) {
            randFood();
          } else {
            foodIn.add(food);
          }

          newList.add(last);
          positionIn.add(newList);
        }
      }
    }
  }

  void randFood() {
    List<FoodModel> foods = <FoodModel>[];
    var numberFood = Random().nextInt(20);
    for (var i = 0; i < numberFood; i++) {
      foods.add(FoodModel(
          position: PositionModel(
              Random().nextInt(20) * 20.0, Random().nextInt(20) * 20.0)));
    }
    foodIn.add(foods);
  }

  void walking(Direction direction) {
    switch (direction) {
      case Direction.up:
        {
          if (lastDirection != Direction.down) {
            lastDirection = Direction.up;
            updatePosition(PositionModel(0.0, snake.height));
            resetWalkingTimer();
          }
        }
        break;
      case Direction.down:
        {
          if (lastDirection != Direction.up) {
            lastDirection = Direction.down;
            updatePosition(PositionModel(0.0, -snake.height));
            resetWalkingTimer();
          }
        }
        break;
      case Direction.left:
        {
          if (lastDirection != Direction.right) {
            lastDirection = Direction.left;
            updatePosition(PositionModel(-snake.height, 0.0));
            resetWalkingTimer();
          }
        }
        break;
      case Direction.right:
        {
          if (lastDirection != Direction.left) {
            lastDirection = Direction.right;
            updatePosition(PositionModel(snake.height, 0.0));
            resetWalkingTimer();
          }
        }
        break;
      default:
    }
  }

  void walkByTouchPosition(double touchX, double touchY) {
    switch (lastDirection) {
      case Direction.up:
      case Direction.down:
        {
          if (touchX < position.value.first.x)
            walking(Direction.left);
          else if (touchX > position.value.first.x)
            walking(Direction.right);
        }
        break;
      case Direction.left:
      case Direction.right:
        {
          if (touchY < position.value.first.y)
            walking(Direction.down);
          else if (touchY > position.value.first.y)
            walking(Direction.up);
        }
        break;
      default:
    }
  }

  void resetWalkingTimer() {
    if (walkingTimer != null)
      walkingTimer.cancel();

    walkingTimer = Timer.periodic(Duration(seconds: 1), (_) => walking(lastDirection));
  }

  @override
  void dispose() {
    position.close();
    positionIn.close();
    foods.close();
    foodIn.close();
    super.dispose();
  }
}
