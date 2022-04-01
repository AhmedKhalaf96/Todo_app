import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Component/component.dart';
import 'package:to_do/cubit/cubit.dart';
import 'package:to_do/cubit/states.dart';

class archive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return Scaffold(
              body:BuildCondition(
                  condition: TodoCubit.get(context).archiveTasks.length > 0,
                  builder:(context)=> listTodo(tasks: TodoCubit.get(context).archiveTasks),
                  fallback: (context)=>Center(child: CircularProgressIndicator()),
              ),
          );
        });
  }
}
