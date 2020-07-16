import 'package:flutter/cupertino.dart';

/// This model class models and keeps track of the attributes of a notebook.
/// This class mainly acts as an data encasulation class for a notebook.
///
/// @author [Aditya Pratap]
/// @version 1.0
class NotebookModel {
  String documentId;
  String name;
  String description;

  /// This 3-parameter constructor initializes the instance variables.
  ///
  /// @param [documentId]  The document Id for the notebook in firestore.
  /// @param [name]        The name of the notebook.
  /// @param [description] The description of the notebbok.
  ///
  /// @precondition none.
  /// @postcondition A new NotebookModel class with initialized variables.
  NotebookModel({this.documentId, @required this.name, @required this.description});

  /// This method takes a map and serializes that data into the instance varibales.
  ///
  /// @param [snapshot] The map returned from firestore that contains notebook data.
  /// @param [documentId] The document id of the notebook in firestore.
  ///
  NotebookModel.fromMap(Map snapshot, String documentId)
      : this.documentId = documentId ?? '',
        this.name = snapshot['name'] ?? '',
        this.description = snapshot['description'] ?? '';

  /// This method is used to convert a NotebookModel object to Json format to access the data.
  ///
  /// @precondition none.
  /// @return  A NotebookModel object is converted to Json format and returned.
  toJson() {
    return {
      "documentId": this.documentId,
      "name": this.name,
      "description": this.description
    };
  }
}
