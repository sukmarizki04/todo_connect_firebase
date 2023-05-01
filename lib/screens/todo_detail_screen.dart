import 'package:flutter/material.dart';
import 'package:todo_list/functions.dart';
import 'package:todo_list/models/place_location.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/database_service.dart';
import 'package:todo_list/widgets/map_widget.dart';

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

  void _setLocation(PlaceLocation placeLocation) {
    setState(() {
      _todo = _todo.copyWith(
          latitude: placeLocation.latitude, longitude: placeLocation.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Detail'),
        actions: [
          IconButton(
            onPressed: () async {
              bool? isDelete = await showDialog(
                  context: context,
                  builder: (builder) {
                    return AlertDialog(
                      title: Text('Hapus Todo?'),
                      content: Text('Apkah Kamu yakin menghapusnya?'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('Ya')),
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('TIdak')),
                      ],
                    );
                  });
              if (isDelete != null && isDelete == true) {
                DatabaseService().deleteTodo(_todo.id);
                Navigator.of(context).pop();
              }
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
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
              if (_todo.dueDate == null)
                Card(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          formatDateTime(_todo.dueDate),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _todo = _todo.copyWith(dueDate: DateTime(0));
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ]),
                  ),
                ),
              Row(
                children: [
                  dueDateButton('Hari ini', value: _today),
                  dueDateButton('Besok', value: _today.add(Duration(days: 1))),
                ],
              ),
              if (_todo.dueDate == null)
                Row(
                  children: [
                    dueDateButton(
                      'Minggu depan',
                      value: _today.add(
                        Duration(
                          days: (_today.weekday - 7).abs() + 1,
                        ),
                      ),
                    ),
                    dueDateButton('Custom', onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _today,
                        firstDate: _today,
                        lastDate: DateTime(_today.year + 100),
                      );

                      if (pickedDate != null) {
                        _todo = _todo.copyWith(dueDate: pickedDate);
                      }
                    }),
                  ],
                ),
              SizedBox(
                height: 25,
              ),
              Text('Catatan'),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  String? note = await showDialog(
                      context: context,
                      builder: (builder) {
                        String tempNote = _todo.note;
                        return Dialog(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Catatan',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                TextFormField(
                                  initialValue: tempNote,
                                  maxLines: 6,
                                  onChanged: (value) {
                                    tempNote = value;
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(tempNote),
                                  child: Text('Selelsai'),
                                )
                              ],
                            ),
                          ),
                        );
                      });

                  if (note != null) {
                    setState(() {
                      _todo = _todo.copyWith(note: note);
                    });
                  }
                },
                child: _todo.note.isEmpty
                    ? Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Tap Untuk Menambah Untuk Catatan'),
                      )
                    : Container(
                        width: double.infinity,
                        child: Text(
                          _todo.note,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              ),
              Text('Lokasi'),
              MapWidget(
                placeLocation: PlaceLocation(
                    latitude: _todo.latitude, longitude: _todo.longitude),
                setLocationFn: _setLocation,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  DatabaseService().updateTodo(_todo);
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save),
                    Text('Simpan'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  DatabaseService().toggleComplete(_todo);
                  Navigator.of(context).pop();
                },
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
        onPressed: onPressed ??
            () {
              setState(() {
                _todo = _todo.copyWith(dueDate: value);
              });
            },
        icon: Icon(Icons.alarm_add),
        label: Text(text),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
      ),
    );
  }
}
