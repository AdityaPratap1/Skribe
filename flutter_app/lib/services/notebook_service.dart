import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// This class connects to the backend service and retrievs data in the desired format.
/// This class contains the firestore database instance that connects to the notebook collection.
///
/// @author [Aditya Pratap]
/// @version 1.0
class NotebookService {
  final Firestore _db = Firestore.instance;
  String _userId = "4vhDJiSsqhR4iST9MPO7BrnjwqE2";
  CollectionReference _ref;

  /// This constructor initializes the instance variables.
  ///
  /// @precondition none.
  /// @postcondition A new NotebookService object with initialized variables.
  NotebookService() {
    this._ref = this
        ._db
        .collection('users')
        .document(this._userId)
        .collection('notebooks');
  }

  /// This method gets all the documents in the notebooks collection in firestore.
  ///
  /// @precondition none.
  /// @return All the notebooks (documents) of the current user.
  Future<QuerySnapshot> getNotebookCollection() {
    return this._ref.getDocuments();
  }

  /// This method gets all the documents in the notebooks collection in firestore as a straem.
  /// This allows for real time changes in the app.
  ///
  /// @precondition none.
  /// @return All the notebooks (documents) of the current user as a stream.
  Stream<QuerySnapshot> streamNotebookCollection() {
    return this._ref.snapshots();
  }

  /// This method gets a specific notebook in the collection.
  ///
  /// @param [notebookId] The document id of the notebook in the collection.
  ///
  /// @precondition The [notebookId] cannot be null or empty.
  /// @return The document reference of the specific note book.
  Future<DocumentSnapshot> getNotebook(String notebookId) {
    if (notebookId == null || notebookId.isEmpty) {
      throw new ArgumentError("The notebook Id cannot be null or empty");
    }
    return this._ref.document(notebookId).get();
  }

  /// This method deletes a specific notebook in the collection.
  ///
  /// @param [notebookId] The document id of the notebook in the collection.
  ///
  /// @precondition The [notebookId] cannot be null or empty.
  /// @return A firestore response letting the app know the notebook has been deleted.
  Future<void> deleteNotebook(String notebookId) {
    if (notebookId == null || notebookId.isEmpty) {
      throw new ArgumentError("The notebook Id cannot be null or empty");
    }
    return this._ref.document(notebookId).delete();
  }

  /// This method adds a notebook to the collection.
  ///
  /// @param [notebook] A map of notebook data that includes name and description.
  ///
  /// @precondition The [notebook] cannot be empty.
  /// @return A firestore response letting the app know the notebook has been deleted.
  Future<void> addNotebook(Map notebook) {
    if (notebook.isEmpty) {
      throw new ArgumentError("The notebook map cannot be empty");
    }
    return this._ref.add(notebook);
  }

  /// This method updates a specific notebook in the collection.
  ///
  /// @param [notebook]   A map of notebook data that includes the updated data.
  /// @param [notebookId] The document id of the notebook in the collection.
  ///
  /// @precondition The [notebook] cannot be empty.
  /// @precondition The [notebookId] cannot be null or empty.
  ///
  /// @return A firestore response letting the app know the notebook has been deleted.
  Future<void> updateNotebook(Map notebook, String notebookId) {
    if (notebook.isEmpty) {
      throw new ArgumentError("The notebook map cannot be empty");
    }

    if (notebookId == null || notebookId.isEmpty) {
      throw new ArgumentError("The notebook Id cannot be null or empty");
    }

    return this._ref.document(notebookId).updateData(notebook);
  }
}
