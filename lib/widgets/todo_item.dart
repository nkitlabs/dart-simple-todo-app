import 'package:flutter/material.dart';

import 'package:todoapp/model/todo.dart';
import 'package:todoapp/constants/colors.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo todo) onTodoChange;
  final Function() onDeleteItem;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onTodoChange,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
          onTap: () {
            onTodoChange(todo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          leading: Icon(
            (todo.isDone ?? false)
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: tdBlue,
          ),
          title: Text(
            todo.todoText ?? '',
            style: TextStyle(
                fontSize: 16,
                color: tdBlack,
                decoration:
                    (todo.isDone ?? false) ? TextDecoration.lineThrough : null),
          ),
          trailing: Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: tdRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  onDeleteItem();
                },
              ))),
    );
  }
}
