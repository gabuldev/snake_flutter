import 'package:flutter/material.dart';
import 'package:snake/app/pages/home/home_module.dart';
import 'package:snake/app/pages/home/widgets/board/board_widget.dart';

import 'widgets/snake/snake_bloc.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bloc = HomeModule.to.getBloc<SnakeBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: BoardWidget(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                      child: Text("UP"),
                      onPressed: () {
                        bloc.walking(Direction.up);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text("LEFT"),
                          onPressed: () {
                            bloc.walking(Direction.left);
                          },
                        ),
                        FlatButton(
                          child: Text("RIGHT"),
                          onPressed: () {
                            bloc.walking(Direction.right);
                          },
                        ),
                      ],
                    ),
                    FlatButton(
                      child: Text("DOWN"),
                      onPressed: () {
                        bloc.walking(Direction.down);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
