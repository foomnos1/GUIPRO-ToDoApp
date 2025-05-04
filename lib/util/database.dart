import 'package:hive_flutter/hive_flutter.dart';

class DatabaseToDo {
  List toDoList = [];

  final _box = Hive.box("box");

  void createData(){
    toDoList = [
      ["Padula 2025", true],
      ["Enrollment Done", false],
      ["Distribution of Clearance", false],
      ["Finished AY 2024-2025", false],
    ];
  }

  void loadData() {
    toDoList = _box.get("TODOLIST");
  }

  void updateData() {
    _box.put("TODOLIST", toDoList);
  }
}