import 'package:cloud_firestore/cloud_firestore.dart';

/// This class connects to the backend service and retrievs data in the desired format.
/// This class contains the firestore database instance that connects to the notebook collection.
///
/// @author [Aditya Pratap]
/// @version 1.0
class TaskService {
  final Firestore _db = Firestore.instance;
  String _userId = "4vhDJiSsqhR4iST9MPO7BrnjwqE2";
  CollectionReference _ref;

  /// This constructor initializes the instance variables.
  ///
  /// @precondition none.
  /// @postcondition A new TaskService object with initialized variables.
  TaskService() {
    this._ref = this
        ._db
        .collection('users')
        .document(this._userId)
        .collection('notebooks');
  }

  /// This methods gets all the tasks in the collection from a specific notebook.
  ///
  /// @param [notebookDocId] The notebook from where the tasks should be obtained from.
  ///
  /// @precondition The [notebookDocId] cannot be null or empty.
  /// @return A collection of all the tasks.
  Future<QuerySnapshot> getTaskCollection(String notebookDocId) {
    if (notebookDocId == null || notebookDocId.isEmpty) {
      throw new ArgumentError(
          "The notebook document Id cannot be null or empty");
    }
    return this._ref.document(notebookDocId).collection('tasks').getDocuments();
  }

  /// This method streams all the tasks in a specific notebook's collection.
  /// This allows for real time changes.
  ///
  /// @param [notebookDocId] The notebook Id of the notebook from which the tasks are streamed from.
  ///
  /// @precondition The [notebookDocId] cannot be null or empty.
  /// @return A stream of the tasks.
  Stream<QuerySnapshot> streamTaskCollection(String notebookDocId) {
    if (notebookDocId == null || notebookDocId.isEmpty) {
      throw new ArgumentError(
          "The notebook document Id cannot be null or empty");
    }
    return this._ref.document(notebookDocId).collection('tasks').snapshots();
  }

  /// This method gets the a specific tas from the notebook collection.
  ///
  /// @param [notebookDocId]  The document id of the notebook in which the task is.
  /// @param [taskDocId]      The document Id of the task itself.
  ///
  /// @precondition The [notebookDocId] cannot be null or empty.
  /// @precondition The [taskDocId]  cannot be null or empty.
  ///
  /// @return A document reference to the task.
  Future<DocumentSnapshot> getTask(String notebookDocId, String taskDocId) {
    if (notebookDocId == null || notebookDocId.isEmpty) {
      throw new ArgumentError(
          "The notebook document Id cannot be null or empty");
    }

    if (taskDocId == null || taskDocId.isEmpty) {
      throw new ArgumentError("The task document Id cannot be null or empty");
    }
    return this
        ._ref
        .document(notebookDocId)
        .collection('tasks')
        .document(taskDocId)
        .get();
  }

  /// This method deletes a specific task in the collection.
  ///
  /// @param [notebookDocId]  The document id of the notebook in which the task is.
  /// @param [taskDocId]      The document Id of the task itself.
  ///
  /// @precondition The [notebookDocId] cannot be null or empty.
  /// @precondition The [taskDocId]  cannot be null or empty.
  ///
  /// @return A response from firestore letting the app know that the task has been deleted.
  Future<void> deleteTask(String notebookDocId, String taskDocId) {
    if (notebookDocId == null || notebookDocId.isEmpty) {
      throw new ArgumentError(
          "The notebook document Id cannot be null or empty");
    }

    if (taskDocId == null || taskDocId.isEmpty) {
      throw new ArgumentError("The task document Id cannot be null or empty");
    }
    return this
        ._ref
        .document(notebookDocId)
        .collection('tasks')
        .document(taskDocId)
        .delete();
  }

  /// This method adds a task to the collection.
  ///
  /// @param [task]           A map of task data that includes all the attributes
  /// @param [notebookDocId]  The document id of the notebook in which the task is.
  ///
  /// @precondition The [task] cannot be empty.
  /// @precondition The [notebookDocId] cannot be null or empty.
  ///
  /// @return A firestore response letting the app know the notebook has been deleted.
  Future<void> addTask(Map task, String notebookDocId) {
    if (task.isEmpty) {
      throw new ArgumentError("The task map cannot be empty");
    }

    if (notebookDocId == null || notebookDocId.isEmpty) {
      throw new ArgumentError(
          "The notebook document Id cannot be null or empty");
    }
    return this._ref.document(notebookDocId).collection('tasks').add(task);
  }

  /// This method updates a specific task in the collection.
  ///
  /// @param [task]           A map of task data that includes the updated data.
  /// @param [notebookDocId]  The document id of the notebook in the collection.
  /// @param [taskDocId]      The document Id of the task itself.
  ///
  /// @precondition The [task] cannot be empty.
  /// @precondition The [notebookDocId] cannot be null or empty.
  /// @precondition The [taskDocId]  cannot be null or empty.
  ///
  /// @return A firestore response letting the app know the notebook has been deleted.
  Future<void> updateTask(Map task, String notebookDocId, String taskDocId) {
    if (task.isEmpty) {
      throw new ArgumentError("The task map cannot be empty");
    }

    if (notebookDocId == null || notebookDocId.isEmpty) {
      throw new ArgumentError(
          "The notebook document Id cannot be null or empty");
    }

    if (taskDocId == null || taskDocId.isEmpty) {
      throw new ArgumentError("The task document Id cannot be null or empty");
    }
    return this
        ._ref
        .document(notebookDocId)
        .collection('tasks')
        .document(taskDocId)
        .updateData(task);
  }
}
