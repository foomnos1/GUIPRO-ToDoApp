import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/util/database.dart';
import 'package:todoapp/util/dialog.dart';
import 'package:todoapp/util/todo.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  final _box = Hive.box("box");
  DatabaseToDo db = DatabaseToDo();

  @override
  void initState() {
    if (_box.get("TODOLIST") == null) {
      db.createData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void saveTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogContainer(
          controller: _controller,
          onSave: saveTask,
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      }
    );
  }

  void removeTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 67, 161, 224),
        appBar: AppBar(
          title: Text("To Do App"),
          backgroundColor: const Color.fromARGB(255, 231, 70, 59),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNewTask();
          },
          tooltip: "Add Task",
          backgroundColor: const Color.fromARGB(255, 231, 70, 59),
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDo(
              taskName: db.toDoList[index][0], 
              taskCompleted: db.toDoList[index][1], 
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction:(context) => removeTask(index),
            );
          },
        ),
      ),
    );
  }
}