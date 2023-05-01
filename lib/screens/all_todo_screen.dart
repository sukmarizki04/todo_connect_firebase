import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/widgets/new_todo.dart';
import 'package:todo_list/widgets/todo_list.dart';

class AllTodoScreen extends StatelessWidget {
  const AllTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todo list'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: TodoList(),
            ),
            NewTodo(),
          ],
        ),
      ),
    );
  }
}
