class Todo {
  Todo({this.item});

  int id;
  String item;

  Todo.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.item = map['item'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'item': this.item,
    };
  }

  String toString() {
    return 'Todo{id: $id, item: $item}';
  }
}
