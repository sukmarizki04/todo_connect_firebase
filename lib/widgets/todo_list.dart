import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/functions.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/screens/todo_detail_screen.dart';
import 'package:todo_list/services/database_service.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().todos,
      builder: (ctx, AsyncSnapshot<List<Todo>> todoSnapshot) {
        if (todoSnapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (todoSnapshot.hasError)
          return Center(
            child: Text(todoSnapshot.error.toString()),
          );
        if (todoSnapshot.data != null) {
          final todoList = todoSnapshot.data as List<Todo>;
          return ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (ctx, index) {
              return Card(
                color: todoList[index].completed ? Colors.blueAccent : null,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (buider) => TodoDetailScreen(
                          todo: todoList[index],
                        ),
                      ),
                    );
                  },
                  leading: IconButton(
                    onPressed: () {},
                    icon: todoList[index].completed
                        ? Icon(Icons.check_outlined)
                        : Icon(Icons.circle_outlined),
                  ),
                  title: Text(todoList[index].title),
                  subtitle: todoList[index].dueDate == null
                      ? null
                      : Text(formatDateTime(todoList[index].dueDate)),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Text('TIdak Ada Data'),
          );
        }
      },
    );
  }
}
