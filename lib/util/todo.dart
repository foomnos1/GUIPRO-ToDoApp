import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDo extends StatelessWidget{
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDo({
    super.key, 
    required this.taskName, 
    required this.taskCompleted, 
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) => deleteFunction?.call(context),
              backgroundColor: const Color.fromARGB(255, 231, 70, 59),
              icon: Icons.delete,
              label: "Delete",
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: const Color.fromARGB(255, 231, 70, 59),
                ),
              Text(
                taskName,
                style: TextStyle(
                  decoration: taskCompleted ? 
                  TextDecoration.lineThrough : 
                  TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}