import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/Component/component.dart';
import 'package:to_do/cubit/cubit.dart';
import 'package:to_do/cubit/states.dart';

class todolayout extends StatelessWidget {
  const todolayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit,TodoStates>(
        listener: (context,states){},
        builder: (context,states){
          return Scaffold(
              key: TodoCubit.get(context).scaffold,
              appBar: AppBar(
                title: Text(TodoCubit.get(context).Appbar[TodoCubit.get(context).currentIndex],style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                elevation: 1.0,
              ),
              body: TodoCubit.get(context).screens[TodoCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.indigo,
                selectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: TodoCubit.get(context).currentIndex,
                onTap:(index){
                    TodoCubit.get(context).Scr(index);
                    },
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.menu),
                    label: "Tasks",
                  ),
                  BottomNavigationBarItem(icon: Icon(Icons.check_circle),
                    label: "Done",
                  ),
                  BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),
                    label: "Archive",
                  ),
                ],

              ),
              floatingActionButton: FloatingActionButton(
                onPressed: (){
                  if(TodoCubit.get(context).isBottomOpen){
                    if(TodoCubit.get(context).formkey.currentState.validate()){
                      if(TodoCubit.get(context).database!=null){
                        TodoCubit.get(context).insertToDataBase();
                      }
                    }
                  }else{
                    TodoCubit.get(context).scaffold.currentState.showBottomSheet((context) => Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: TodoCubit.get(context).formkey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormFieldCustom(
                                controller: TodoCubit.get(context).tasktittlecontroller,
                                lable: 'New Task',
                                prifixicon: Icons.title,
                                validator: (value){
                                  if(value.isEmpty){
                                     return 'please complete data';
                                  }
                                  return null;
                                }
                              ),
                              SizedBox(height: 10,),
                              TextFormFieldCustom(
                                  controller: TodoCubit.get(context).datecontroller,
                                  lable: 'Task Date',
                                  prifixicon: Icons.calendar_today,
                                  validator: (value){
                                    if(value.isEmpty){
                                      return 'please complete data';
                                    }
                                    return null;
                                  },
                                  ontap: (){
                                    showDatePicker(context: context, initialDate: DateTime.now(), firstDate:DateTime.utc(2021) , lastDate: DateTime.parse('2030-12-31')).then((value) {
                                      TodoCubit.get(context).datecontroller.text=DateFormat.yMMMd().format(value);
                                    });
                                  }
                              ),
                              SizedBox(height: 10,),
                              TextFormFieldCustom(
                                  controller: TodoCubit.get(context).timecontroller,
                                  lable: 'Task Time',
                                  prifixicon: Icons.watch_later_outlined,
                                  validator: (value){
                                    if(value.isEmpty){
                                      return 'please complete data';
                                    }
                                    return null;
                                  },
                                  ontap: (){
                                    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                                      TodoCubit.get(context).timecontroller.text=value.format(context).toString();
                                    });
                                  }
                              ),
                            ],
                          ),
                        ),
                      ),
                    )).closed.then((value){
                      TodoCubit.get(context).ChangeButtomIcon(isopen: false, iconData: Icons.edit);
                    });
                    TodoCubit.get(context).ChangeButtomIcon(isopen: true, iconData: Icons.add);
                  }
                },
                child: Icon(TodoCubit.get(context).firsticon,color: Colors.white,size: 25,),
              ),
          );
        },
      ),
    );

  }
}