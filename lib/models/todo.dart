import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.isChecked,
  });

  int? id;
  String? title;
  @JsonKey(name: 'is_checked')
  int? isChecked;

  int get getId => id ?? 0;
  String get getTitle => title ?? '';
  bool get getIsChecked => isChecked == 1;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
