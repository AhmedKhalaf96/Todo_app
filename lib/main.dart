import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Shared/cubit/observer.dart';
import 'package:to_do/layout/splash.dart';
import 'layout/to do layout.dart';
import 'package:to_do/modules/archive_screen.dart';
import 'package:to_do/modules/done_screen.dart';
import 'package:to_do/modules/task_screen.dart';

void main() {
  BlocOverrides.runZoned(
        () {
          runApp( MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: todoSplash(),
    );
  }
}