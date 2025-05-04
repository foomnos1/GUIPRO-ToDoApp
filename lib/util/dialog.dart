import 'package:flutter/material.dart';
import 'package:todoapp/util/button.dart';

class DialogContainer extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogContainer({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      content: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Enter a new task",
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(text: "Save", onPressed: onSave),

                  const SizedBox(width: 15),

                  CustomButton(text: "Cancel", onPressed: onCancel),
                ],
              ),
            ],
          ),
      ),
    );
  }
}