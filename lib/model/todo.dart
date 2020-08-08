class Todo {
  final String guid;
  final String name;
  final DateTime created;
  final DateTime target;
  bool done;

  Todo(this.guid, this.name, this.created, this.target, this.done);
}
