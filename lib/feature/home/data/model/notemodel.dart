import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  List<Todos>? todos;

  @HiveField(1)
  int? total;

  @HiveField(2)
  int? skip;

  @HiveField(3)
  int? limit;

  NoteModel({this.todos, this.total, this.skip, this.limit});

  NoteModel.fromJson(Map<String, dynamic> json) {
    if (json['todos'] != null) {
      todos = <Todos>[];
      json['todos'].forEach((v) {
        todos!.add(Todos.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.todos != null) {
      data['todos'] = this.todos!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}

@HiveType(typeId: 1)
class Todos {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? todo;

  @HiveField(2)
  bool? completed;

  @HiveField(3)
  int? userId;

  Todos({this.id, this.todo, this.completed, this.userId});

  Todos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['todo'] = this.todo;
    data['completed'] = this.completed;
    data['userId'] = this.userId;
    return data;
  }
}

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    return NoteModel(
      todos: reader.readList().cast<Todos>(),  // Ensure proper deserialization of the list
      total: reader.read(),
      skip: reader.read(),
      limit: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer.writeList(obj.todos!);  // Ensure the list is properly written
    writer.write(obj.total);
    writer.write(obj.skip);
    writer.write(obj.limit);
  }
}

class TodosAdapter extends TypeAdapter<Todos> {
  @override
  final int typeId = 1;

  @override
  Todos read(BinaryReader reader) {
    return Todos(
      id: reader.read(),
      todo: reader.read(),
      completed: reader.read(),
      userId: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Todos obj) {
    writer.write(obj.id);
    writer.write(obj.todo);
    writer.write(obj.completed);
    writer.write(obj.userId);
  }
}



