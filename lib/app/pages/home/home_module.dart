import 'package:snake/app/pages/home/widgets/snake/snake_bloc.dart';
import 'package:snake/app/pages/home/widgets/board/board_bloc.dart';
import 'package:snake/app/pages/home/home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:snake/app/pages/home/home_page.dart';
import 'package:snake/app/shared/models/snake_model.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SnakeBloc(SnakeModel())),
        Bloc((i) => BoardBloc()),
        Bloc((i) => HomeBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
