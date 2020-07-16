import 'package:app/configuration/locator.dart';
import 'package:app/models/notebook_model.dart';
import 'package:app/services/notebook_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

/// This class is the view-model part of the MVVM software archtecture.
/// This class is also part of the provider state management design pattern.
/// The actions of the Notebook page are managed here, such as adding a notebook, deleting a notebook.
///
/// @author [Aditya Pratap]
/// @version 1.0.
class NoteBookViewModel extends ChangeNotifier {
  NotebookService _notebookService = locator<NotebookService>();
  List<NotebookModel> _notebooks;

  /// This method fetches all the notebooks in the collection using the NotebookService class.
  ///
  /// @precondition none
  /// @return The list of all notebooks in the collection.
  Future<List<NotebookModel>> fetchNotebooks() async {
    var result = await this._notebookService.getNotebookCollection();
    this._notebooks = result.documents
        .map((doc) => NotebookModel.fromMap(doc.data, doc.documentID))
        .toList();
    return this._notebooks;
  }

  /// This method streams all the notebooks in the collection using the NotebookService class.
  ///
  /// @precondition none
  /// @return The stream of all notebooks in the collection.
  Stream<QuerySnapshot> fetchProductsAsStream() {
    return this._notebookService.streamNotebookCollection();
  }

  /// This method gets a specific notebook using a notebook id and the NotebookService class.
  ///
  /// @param [notebookDocId] The document Id of the specified notebook.
  ///
  /// @precondition The [notebookDocId] cannot be null or empty  (enforced in NotebookService class).  ///
  /// @return A map of a specific notebook in the collection.
  Future<NotebookModel> getNotebookById(String notebookDocId) async {
    var doc = await this._notebookService.getNotebook(notebookDocId);
    return NotebookModel.fromMap(doc.data, doc.documentID);
  }

  /// This method removes a specific notebook from the list using a notebook id and the NotebookService class.
  ///
  /// @param [notebookDocId] The document Id of the specified notebook.
  ///
  /// @precondition The [notebookDocId] cannot be null or empty (enforced in NotebookService class).  ///
  /// @return A callback from firestore.
  Future<void> removeNotebook(String notebookId) async {
    await this._notebookService.deleteNotebook(notebookId);
    return;
  }

  /// This method updates a specific notebook from the list using a notebook id and the NotebookService class.
  ///
  /// @param [notebookDocId] The document Id of the specified notebook .
  /// @param [noteBookModel] A NotebookModel object of the specific notebook.
  ///
  /// @precondition The [notebookDocId] cannot be null or empty (enforced in NotebookService class).
  /// @precondition The [notebookModel] cannot be null (enforced in NotebookService class).
  /// @return A callback from firestore.
  Future updateNotebook(NotebookModel notebookModel, String notebookId) async {
    await this
        ._notebookService
        .updateNotebook(notebookModel.toJson(), notebookId);
    notifyListeners();
    return;
  }

  /// This method adds a  notebook to the list using the NotebookService class.
  ///
  /// @param [noteBookModel] A NotebookModel object of the specific notebook.
  ///
  /// @precondition The [notebookModel] cannot be null (enforced in NotebookService class).
  /// @return A callback from firestore.
  Future addNotebook(NotebookModel notebookModel) async {
    var result =
        await this._notebookService.addNotebook(notebookModel.toJson());
    return;
  }
}
