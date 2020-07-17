import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

/// This model class models and keeps track of the attributes of a task.
/// This class mainly acts as an data encasulation class for a task.
///
/// @author [Aditya Pratap]
/// @version 1.0
class TaskModel {
  String documentId;
  String title;
  String description;
  bool status;
  Timestamp dueDate;
  Timestamp reminder;
  Map subTasks;

  /// This 3-parameter constructor initializes the instance variables.
  ///
  /// @param [documentId]   The document Id for the notebook in firestore.
  /// @param [title]        The name of the notebook.
  /// @param [description]  The description of the notebbok.
  /// @param [status]       A task's current status, that is active(true) or completed (false)
  /// @param [dueDate]      The date when the task is due.
  /// @param [reminder]     A reminder set by the user to remind them to complete the task.
  /// @param [subTasks]     A map containing sub tasks for a task.
  ///
  /// @precondition none.
  /// @postcondition A new NotebookModel class with initialized variables.
  TaskModel(
      {this.documentId,
      @required this.title,
      this.description,
      @required this.status,
      this.dueDate,
      this.reminder,
      this.subTasks});

  /// This method takes a map and serializes that data into the instance varibales.
  ///
  /// @param [snapshot] The map returned from firestore that contains notebook data.
  /// @param [documentId] The document id of the notebook in firestore.
  ///
  TaskModel.fromMap(Map snapshot, String documentId)
      : this.documentId = documentId ?? '',
        this.title = snapshot['title'] ?? '',
        this.description = snapshot['description'] ?? '',
        this.status = snapshot['status'] ?? null,
        this.dueDate = snapshot['duedate'] ?? null,
        this.reminder = snapshot['reminder'] ?? null,
        this.subTasks = snapshot['subtasks'] ?? null;

  /// This method takes a map and serializes that data into the instance varibales.
  ///
  /// @param [snapshot] The map returned from firestore that contains notebook data.
  /// @param [documentId] The document id of the notebook in firestore.
  ///
  toJson() {
    return {
      "documentId": this.documentId,
      "title": this.title,
      "description": this.description,
      "status": this.status,
      "duedate": this.dueDate,
      "reminder": this.reminder,
      "subtasks": this.subTasks
    };
  }
}
