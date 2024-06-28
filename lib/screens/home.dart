import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/widgets/todo_item.dart';
import 'package:todoapp/model/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.getDefaultTodos();
  final todoController = TextEditingController();
  List<Todo> foundTodo = [];

  @override
  void initState() {
    foundTodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = buildAppBar();

    void handleTodoChange(Todo todo) {
      setState(() {
        todo.isDone = !(todo.isDone ?? false);
      });
    }

    void deleteTodoItem(String id) {
      setState(() {
        todoList.removeWhere((item) => item.id == id);
      });
    }

    void addTodoItem(String todoText) {
      setState(() {
        todoList.add(Todo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: todoText));
      });
      todoController.clear();
    }

    void runFilter(String enteredKeyword) {
      List<Todo> results = [];
      if (enteredKeyword.isEmpty) {
        results = todoList;
      } else {
        results = todoList
            .where((item) => item.todoText!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      }

      setState(() {
        foundTodo = results;
      });
    }

    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: appBar,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                SearchBox(runFilter: runFilter),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          'All Todos',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Todo todo in foundTodo.reversed)
                        TodoItem(
                          todo: todo,
                          onTodoChange: handleTodoChange,
                          onDeleteItem: () {
                            deleteTodoItem(todo.id);
                          },
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: todoController,
                      decoration: const InputDecoration(
                          hintText: 'Add a new todo item',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(right: 20, bottom: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(60, 60),
                        elevation: 10,
                      ),
                      onPressed: () {
                        addTodoItem(todoController.text);
                      },
                      child: const Text('+', style: TextStyle(fontSize: 40)),
                    ))
              ],
            ),
          )
        ]));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: tdBlack, size: 30),
          SizedBox(
            height: 30,
            width: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.asset(
                'assets/images/account_circle.svg',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final Function(String) runFilter;

  const SearchBox({
    super.key,
    required this.runFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }
}
