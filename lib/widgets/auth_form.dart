import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.submitAuthFormFn}) : super(key: key);
  final Function(
      {required String email,
      required String username,
      required String password,
      required bool isLogin}) submitAuthFormFn;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _username = '';
  String _password = '';

  void submitForm() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        widget.submitAuthFormFn(
            email: _email,
            username: _username,
            password: _password,
            isLogin: _isLogin);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              key: Key('email'),
              decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@'))
                  return 'Mohon Masukkan Format E-mail yang benar';
                return null;
              },
              onSaved: (value) {
                _email = value ?? '';
              },
            ),
            SizedBox(
              height: 15,
            ),
            if (!_isLogin)
              TextFormField(
                key: Key('username'),
                decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 4)
                    return 'Username Memiliki 4 Karakter';
                  return null;
                },
                onSaved: (value) {
                  _username = value ?? '';
                },
              ),
            if (!_isLogin)
              SizedBox(
                height: 15,
              ),
            TextFormField(
              key: Key('password'),
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6)
                  return 'Password  Minimal Memiliki 4 Karakter';
                return null;
              },
              onSaved: (value) {
                _password = value ?? '';
              },
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: submitForm,
              child: Text(_isLogin ? 'Masuk' : 'Daftar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin ? 'Daftar Akun Baru' : 'Sudah Punya Akun'),
            ),
          ],
        ));
  }
}
