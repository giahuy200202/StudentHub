class Task {
  Task({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.isCompleted,
  });

  final String id;
  final String title;
  final String content;
  final DateTime date;
  bool isCompleted;
}
