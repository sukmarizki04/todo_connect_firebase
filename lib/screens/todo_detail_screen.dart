import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';

class TodoDetailScreen extends StatefulWidget {
  const TodoDetailScreen({Key? key, required this.todo}) : super(key: key);
  final Todo todo;
  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  Todo _todo = Todo(id: '', title: '');
  final _todoTitleController = TextEditingController();
  final _today = DateTime.now();
  @override
  void initState() {
    _todo = widget.todo;
    _todoTitleController.text = _todo.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Detail'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Apa yang mau kamu lakukan ?'),
              SizedBox(height: 10),
              TextField(
                controller: _todoTitleController,
                decoration: InputDecoration(hintText: 'Saya mau ....'),
                onChanged: (value) {
                  _todo = _todo.copyWith(title: value);
                },
              ),
              SizedBox(
                height: 25,
              ),
              Text('Tanggal waktu penyelesaian'),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  dueDateButton('Hari ini', value: _today),
                  dueDateButton('Besok', value: _today.add(Duration(days: 1))),
                ],
              ),
              Row(
                children: [
                  dueDateButton(
                    'Minggu ',
                    value: _today.add(
                      Duration(
                        days: (_today.weekday - 7),
                      ),
                    ),
                  ),
                  dueDateButton('Custom'),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Text('Catatan'),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Tap Untuk Menambah Untuk Catatan'),
              ),
              Text('Lokasi'),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Tap Untuk Menambah Lokasi'),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save),
                    Text('Simpan'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Text('Selesai'),
                  ],
                ),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dueDateButton(String text,
      {DateTime? value, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.alarm_add),
        label: Text('Hari ini'),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
      ),
    );
  }
}
