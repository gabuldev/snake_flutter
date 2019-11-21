import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:snake/app/shared/models/position_model.dart';

class SnakeModel {
  final double height;
  final Color color;
  final List<PositionModel> body;
  SnakeModel({this.body, this.height = 20, this.color = Colors.red});
}
