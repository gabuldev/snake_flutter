import 'package:flutter/material.dart';
import 'package:snake/app/shared/models/position_model.dart';

class FoodModel {
  final double height;
  final Color color;
  final PositionModel position;

  FoodModel({this.height = 20, this.color = Colors.yellow, this.position});
}
