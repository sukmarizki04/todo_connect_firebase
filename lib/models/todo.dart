class Todo {
  final String id;
  final String title;
  final String note;
  final DateTime? dueDate;
  final bool completed;
  final double latitude;
  final double longitude;

  Todo(
      {required this.id,
      required this.title,
      this.note = '',
      this.dueDate,
      this.completed = false,
      this.latitude = 0.0,
      this.longitude = 0.0});
}
