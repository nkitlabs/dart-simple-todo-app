class Todo {
  String id;
  String? todoText;
  bool? isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> getDefaultTodos() {
    return [
      Todo(id: '001', todoText: 'Morning exercise', isDone: true),
      Todo(id: '002', todoText: 'Buy groceries', isDone: true),
      Todo(id: '003', todoText: 'Check e-mails'),
      Todo(id: '004', todoText: 'Team meeting'),
      Todo(id: '005', todoText: 'Work on mobile app for 2 hours'),
      Todo(id: '006', todoText: 'Dinner'),
    ];
  }
}
