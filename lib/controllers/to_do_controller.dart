import 'package:to_do_app/constants/db_helper.dart';
import 'package:to_do_app/constants/extensions.dart';
import 'package:to_do_app/models/to_do_model.dart';

class ToDoController {
  bool isDataEmpty = false;
  List<ToDoModel> toDos = [];
  DBHelper dbHelper = DBHelper();

  /// Fetches all to-dos from the database and updates the 'toDos' list.
  /// The data is retrieved from the database, and each entry is converted into a ToDoModel using the 'fromMap' method.
  Future<void> getToDos() async {
    List<Map<String, dynamic>> toDosData = await dbHelper.getData("SELECT * FROM 'To_Do'");
    toDos = toDosData.map((toDo) => ToDoModel.fromMap(toDo)).toList();
  }

  /// Adds a new to-do to the database and updates the 'toDos' list with the newly added item.
  /// [title] is the title of the task, [subtitle] provides additional details, and [isDone] represents if the task is completed.
  Future<void> addToDo(String title, {required String subtitle, required int isDone}) async {
    await dbHelper.insertData("INSERT INTO 'To_Do' ('title', 'subtitle', 'isDone') VALUES ('$title', '$subtitle', $isDone)").then(
      (id) {
        if (id > 0) {
          toDos.add(
            ToDoModel(
              id,
              title: title,
              isDone: isDone,
              subtitle: subtitle,
            ),
          );
          "Added Successfully".showToast;
        }
      },
    );
  }

  /// Updates an existing to-do in the database by its [id] and modifies the corresponding entry in the 'toDos' list.
  /// It updates the title, subtitle, and completion status.
  Future<void> updateToDo(int id, {required String title, required String subtitle, required int isDone}) async {
    await dbHelper.updateData("UPDATE 'To_Do' SET 'title' = '$title', 'subtitle' = '$subtitle', 'isDone' = $isDone WHERE id = $id").then(
      (isSuccess) {
        ToDoModel currentToDo = toDos.firstWhere((toDo) => toDo.id == id);
        if (isSuccess) {
          currentToDo.updateToDoData(
            title,
            subtitle: subtitle,
            isDone: isDone,
          );
          "Updated Successfully".showToast;
        }
      },
    );
  }

  /// Deletes a to-do from the database by its [id] and removes it from the 'toDos' list.
  Future<void> deleteToDo(int id) async {
    await dbHelper.deleteData("DELETE FROM 'To_Do' WHERE id = $id").then(
      (isSuccess) {
        if (isSuccess) {
          toDos.removeWhere(
            (toDo) => toDo.id == id,
          );
          "Deleted Successfully".showToast;
        }
      },
    );
  }
}
