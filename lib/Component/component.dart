import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/cubit/cubit.dart';

Widget TextFormFieldCustom({
    @required TextEditingController controller,
    var validator,
    @required String lable,
    var prifixicon,
    var suffixicon,
    var suffixpress,
    var priffixpress,
    var ontap,
})=>TextFormField(
  controller:controller,
  validator: validator,
  keyboardType: TextInputType.text,
  onTap: ontap,
  decoration: InputDecoration(
      labelText: lable,
      prefix: prifixicon !=null ?IconButton(onPressed:priffixpress, icon: Icon(prifixicon)):null,
      suffix: suffixicon !=null ?IconButton(onPressed:suffixpress, icon: Icon(suffixicon)):null,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1,color: Colors.indigo)
      )
  ),
);

Widget builditem({context,@required List<Map> tasks,@required int index,@required ontap}) =>
    Dismissible(
      key: Key(tasks[index]['id'].toString()),
      background:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Colors.blueGrey,
            padding: EdgeInsets.only(left: 20),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.delete,color: Colors.white,size: 40,)
            ],
          )
        ),
      ) ,
      secondaryBackground: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.only(left: 20),
            color: Colors.blueGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.delete,color: Colors.white,size: 40,)
              ],
            )
        ),
      ) ,
      onDismissed:(direction){
        TodoCubit.get(context).deleteData(id: tasks[index]["id"]);
      } ,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal:0),
  child: Container(
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(10),
      ),
      //height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Text(tasks[index]["time"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)
            ),
            SizedBox(width: 20,),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(  tasks[index]["title"],style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                SizedBox(height: 15,),
                Text(tasks[index]["date"],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w800,color: Colors.white60),),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap:(){
                TodoCubit.get(context).updateData(statue: "done", id: tasks[index]["id"]);
              },
              child: CircleAvatar(
                child: Icon(Icons.done,size: 25,),
                radius: 18,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(width: 20,),
            GestureDetector(
              onTap: (){
                TodoCubit.get(context).updateData(statue: "archive", id: tasks[index]["id"]);
              },
              child: CircleAvatar(
                child: Icon(Icons.archive,size: 25,),
                radius: 18,
                backgroundColor: Colors.white,
              ),
            ),

          ],
        ),
      ),
  ),
),
    );

Widget listTodo({@required List<Map> tasks})=>ListView.separated(
    itemBuilder: (context,index)=>builditem(context: context,index: index,tasks: tasks),
    separatorBuilder: (context,index) => Divider(color: Colors.indigo,),
    itemCount: tasks.length,);