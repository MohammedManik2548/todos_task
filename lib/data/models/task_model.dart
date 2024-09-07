class Task {
  final int? id;
  final String title;
  final String dueTime;
  final String? imagePath;
  bool isDone;

  Task(
      {this.id,
      required this.title,
      required this.dueTime,
      this.imagePath,
      this.isDone = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dueTime': dueTime,
      'imagePath': imagePath,
      'isDone': isDone ? 1 : 0,
    };
  }
}
