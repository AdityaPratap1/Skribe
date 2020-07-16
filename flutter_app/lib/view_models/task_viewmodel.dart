import 'package:app/configuration/locator.dart';
import 'package:app/models/task_model.dart';
import 'package:app/services/tasks_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

/// This class is the view-model part of the MVVM software archtecture.
/// This class is also part of the provider state management design pattern.
/// The actions of the Task page are managed here, such as adding a task, deleting a task.
///
/// @author [Aditya Pratap]
/// @version 1.0.
class TaskViewModel extends ChangeNotifier {
  TaskService _taskService = locator<TaskService>();
  List<TaskModel> _tasks;

  /// This method fetches all the tasks in the collection using the TaskService class.
  ///
  /// @precondition none
  /// @return The list of all tasks in the collection.
  Future<List<TaskModel>> fetchTasks(String notebookDocId) async {
    var result = await this._taskService.getTaskCollection(notebookDocId);
    this._tasks = result.documents
        .map((doc) => TaskModel.fromMap(doc.data, doc.documentID))
        .toList();
    return this._tasks;
  }

  /// This method streams all the tasks in the collection using the TaskService class.
  ///
  /// @precondition none
  /// @return The stream of all tasks in the collection.
  Stream<QuerySnapshot> fetchProductsAsStream(String notebookDocId) {
    return this._taskService.streamTaskCollection(notebookDocId);
  }

  /// This method gets a specific task using a task id and the TaskService class.
  ///
  /// @param [notebookDocId]  The document Id of the specified notebook.
  /// @param [taskDocId]      The document Id of the specific task.
  ///
  /// @precondition The [notebookDocId] cannot be null or empty  (enforced in TaskService class).
  /// @precondition The [taskDocId]     cannot be null or empty  (enforced in TaskService class).
  ///
  /// @return A map of a specific task in the collection.
  Future<TaskModel> getTaskId(String notebookDocId, String taskDocId) async {
    var doc = await this._taskService.getTask(notebookDocId, taskDocId);
    return TaskModel.fromMap(doc.data, doc.documentID);
  }

  /// This method removes a specific task from the list using a task id and the TaskService class.
  ///
  /// @param [notebookDocId]  The document Id of the specified notebook.
  /// @param [taskDocId]      The document Id of the specific task.
  ///
  /// @precondition The [notebookDocId] cannot be null or empty  (enforced in TaskService class).
  /// @precondition The [taskDocId]     cannot be null or empty  (enforced in TaskService class).
  ///
  /// @return A callback from firestore.
  Future removeTask(String notebookDocId, String taskDocId) async {
    await this._taskService.deleteTask(notebookDocId, taskDocId);
    return;
  }

  /// This method updates a specific notebook from the list using a notebook id and the TaskService class.
  ///
  /// @param [notebookDocId] The document Id of the specified notebook .
  /// @param [noteBookModel] A NotebookModel object of the specific notebook.
  ///
  /// @precondition The [notebookDocId] cannot be null or empty (enforced in TaskService class).
  /// @precondition The [notebookModel] cannot be null (enforced in TaskService class).
  /// @return A callback from firestore.
  Future updateTask(TaskModel data, String notebookId, String docId) async {
    await this._taskService.updateTask(data.toJson(), notebookId, docId);
    notifyListeners();
    return;
  }

  /// This method adds a  task to the list using the TaskService class.
  ///
  /// @param [taskModel] A TaskModel object of the specific task.
  /// @param [notebookDocId] The document Id of the specified notebook
  ///
  /// @precondition The [taskModel]     cannot be null (enforced in TaskService class).
  /// @precondition The [notebookDocId] cannot be null or empty (enforced in TaskService class).
  /// @return A callback from firestore.
  Future addTask(TaskModel taskModel, String notebookDocId) async {
    var result =
        await this._taskService.addTask(taskModel.toJson(), notebookDocId);

    return;
  }
}
