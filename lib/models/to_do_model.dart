import 'package:to_do_app/constants/strings.dart';

class ToDoModel {
  int id;
  int isDone;
  String title;
  String subtitle;

  ToDoModel(
    this.id, {
    required this.title,
    required this.isDone,
    required this.subtitle,
  });

  void updateToDoData(String title, {required String subtitle, required int isDone}) {
    this.title = title;
    this.isDone = isDone;
    this.subtitle = subtitle;
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      map[AppStrings.idField],
      title: map[AppStrings.titleField],
      isDone: map[AppStrings.isDoneField],
      subtitle: map[AppStrings.subtitleField],
    );
  }
}
