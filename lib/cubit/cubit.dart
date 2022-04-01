
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/cubit/states.dart';
import 'package:to_do/modules/archive_screen.dart';
import 'package:to_do/modules/done_screen.dart';
import 'package:to_do/modules/task_screen.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(TodoInitialState());
  static TodoCubit get(context) => BlocProvider.of(context);
  int currentIndex=0;
  var scaffold=GlobalKey<ScaffoldState>();
  var formkey=GlobalKey<FormState>();
  var tasktittlecontroller=TextEditingController();
  var datecontroller=TextEditingController();
  var timecontroller=TextEditingController();
  Database database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archiveTasks=[];

  IconData firsticon=Icons.edit;
  bool isBottomOpen=false;
  List<Widget>screens=[
    task(),
    done(),
    archive(),
  ];
  List<String>Appbar=[
    "Task Screen",
    "Done Screen",
    "Archive Screen",
  ];
  void Scr(var ind){
    currentIndex=ind;
    emit(TodogoState());
  }
  void ChangeButtomIcon({@required bool isopen,@required IconData iconData}){
    isBottomOpen=isopen;
    firsticon = iconData;
    emit(appChangeIcon());
  }
  void createDatabase(){
    openDatabase(
      'todo.db',
      version: 1,
      onCreate:(database ,version){
        print('DataBase Created');
        database.execute(      'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, statue TEXT)').then((value) {
         print("table created");
        }).catchError((onError){
          print("error in creat table${onError.toString()}");
        });
      },
      onOpen: (database){
        getDataDromDataBase(database);
        print("database opened");
      }
    ).then((value) {
      database=value;
      emit(AppDataBaseCreatedState());
    });
  }

  Future insertToDataBase(){
   database.transaction((txn){
    txn.rawInsert('INSERT INTO Test(title, date, time, statue) VALUES("${tasktittlecontroller.text}", "${datecontroller.text}", "${timecontroller.text}", "new")',
    ).then((value) {
      print('$value insret complete');
    emit(AppDataBaseInsertState());
      getDataDromDataBase(database);
    }).catchError((onError) {
      emit(AppDataBaseInserterror(onError.toString()));
    });
    return null;
  });
  }

  void getDataDromDataBase(Database database){
    emit(GetDataLoadingState());
    newTasks.clear();
    doneTasks.clear();
    archiveTasks.clear();
    database.rawQuery('SELECT * FROM Test').then((value){
      value.forEach((element) {
        if(element['statue']=="new"){
          newTasks.add(element);
        }
        else if(element['statue']=="done") {
          doneTasks.add(element);
        }
        else if(element['statue']=="archive"){
          archiveTasks.add(element);
        }
      });
      emit(GetDataState());
    }).catchError((error){
      emit(GetDataerror(error));
    });
  }

  void updateData({@required String statue,@required int id}){
    database.rawUpdate('UPDATE Test SET statue = ? WHERE id = ?',[statue,id],).then((value){
      getDataDromDataBase(database);
      emit(updateDataState());
    });
  }

  void deleteData({@required int id}){
    database.rawUpdate('DELETE FROM Test WHERE id = ?',[id],).then((value){
      getDataDromDataBase(database);
      emit(deleteDataState());
    });
  }


}
