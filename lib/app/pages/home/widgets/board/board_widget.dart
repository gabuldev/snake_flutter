import 'package:flutter/material.dart';
import 'package:snake/app/pages/home/home_module.dart';
import 'package:snake/app/pages/home/widgets/food/food_widget.dart';
import 'package:snake/app/pages/home/widgets/snake/snake_bloc.dart';
import 'package:snake/app/pages/home/widgets/snake/snake_widget.dart';
import 'package:snake/app/shared/models/food_model.dart';
import 'package:snake/app/shared/models/position_model.dart';
import 'package:snake/app/shared/models/snake_model.dart';

class BoardWidget extends StatefulWidget {
  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  var bloc = HomeModule.to.getBloc<SnakeBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      color: Colors.green,
      child: Stack(
        children: <Widget>[
          Center(
            child: StreamBuilder<List<FoodModel>>(
                stream: bloc.foodOut,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FoodWidget(
                      foods: snapshot.data,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
          Center(
            child: StreamBuilder<List<PositionModel>>(
                stream: bloc.positionOut,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SnakeWidget(
                      snake: SnakeModel(body: snapshot.data),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
