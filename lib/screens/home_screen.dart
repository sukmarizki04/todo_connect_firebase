import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/widgets/todo_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //     .listen((data) {
          //   data.docs.forEach((data) {
          //     print(data['title']);
          //   });
          // });
          FirebaseFirestore.instance
              .collection('todos')
              .doc('yRXTXSA45vclxVvFkNTV')
              .get()
              .then((value) => print(value['title']));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
