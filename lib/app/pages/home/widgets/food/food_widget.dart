import 'package:flutter/material.dart';
import 'package:snake/app/shared/models/food_model.dart';

class FoodWidget extends StatelessWidget {
  final List<FoodModel> foods;

  const FoodWidget({Key key, this.foods}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: foods
            .map((i) => Positioned(
                  bottom: i.position.y,
                  left: i.position.x,
                  child: Container(
                    width: i.height,
                    height: i.height,
                    color: i.color,
                  ),
                ))
            .toList());
  }
}
