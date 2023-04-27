import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('todos').snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> todoSnapshot) {
        if (todoSnapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (todoSnapshot.hasError)
          return Center(
            child: Text(todoSnapshot.error.toString()),
          );

        final documents = todoSnapshot.data!.docs;

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (ctx, index) {
            return Text(documents[index]['title']);
          },
        );
      },
    );
  }
}
