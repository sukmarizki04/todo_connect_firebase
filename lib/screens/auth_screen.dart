import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  void submitAuthForm(
      {required String email,
      required String username,
      required String password,
      required bool isLogin}) async {
    try {
      UserCredential userCredential;

      if (isLogin) {
        //melakukan Fungsi login
        userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        //melakukan register
        userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (userCredential.user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'username': username,
            'email': email,
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      var message = e.message ?? 'Mohon Periksa Kembali Data Anda';
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(25),
            child: Column(children: [
              Text(
                'todo',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 30,
              ),
              AuthForm(
                submitAuthFormFn: submitAuthForm,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
