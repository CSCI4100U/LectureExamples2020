class Person {
  int id;
  String name;

  Person({this.id, this.name});

  Person.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  @override
  String toString() {
    return 'Person(id: $id, name: $name)';
  }
}
