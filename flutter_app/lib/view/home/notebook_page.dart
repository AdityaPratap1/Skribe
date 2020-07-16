import 'package:app/configuration/constraints.dart';
import 'package:app/configuration/size_config.dart';
import 'package:app/models/notebook_model.dart';
import 'package:app/view_models/notebook_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This class builds the notebook page when the notebook page is built.
/// This class is part of the provider design pattern, that is
/// the state management for this page is done in the viewmodel class.
///
/// @author [Aditya Pratap]
/// @version 1.0
class NotebookPage extends StatelessWidget {
  String _notebookDocId;
  List<NotebookModel> _notebooks;
  double _height;
  double _width;
  TextEditingController _notebookNameTextEditingController;
  TextEditingController _notebookDescriptionTextEditingController;
  NoteBookViewModel _taskProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    this._taskProvider = Provider.of<NoteBookViewModel>(context);
    SizeConfig().init(context);
    this._height = SizeConfig.screenHeight;
    this._width = SizeConfig.screenWidth;
    this._notebookNameTextEditingController = new TextEditingController();
    this._notebookDescriptionTextEditingController =
        new TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: this._width * .25, top: this._height * .08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notebooks",
                  style: TextStyle(
                      color: Colors.white, fontSize: this._width * .10),
                )
              ],
            ),
          ),
          StreamBuilder(
              stream: this._taskProvider.fetchProductsAsStream(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  this._notebooks = snapshot.data.documents
                      .map((doc) =>
                          NotebookModel.fromMap(doc.data, doc.documentID))
                      .toList();

                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: this._notebooks.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              this._notebookDocId = this
                                  ._notebooks[index]
                                  .toJson()['documentId']
                                  .toString();
                              Navigator.of(context).pushNamed('/tasks',
                                  arguments: {
                                    'notebookDocId': this._notebookDocId
                                  });
                            },
                            onDoubleTap: () {
                              this._notebookDocId = this
                                  ._notebooks[index]
                                  .toJson()['documentId']
                                  .toString();
                              this
                                  ._taskProvider
                                  .removeNotebook(this._notebookDocId);
                            },
                            child: this._buildCard(this._notebooks, index));
                      },
                    ),
                  );
                } else {
                  return Text("no data", style: TextStyle(color: Colors.white));
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this._createInputDialog(context);
        },
        heroTag: "notebookTag",
        child: Icon(
          Icons.add,
          color: backGroundColor,
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  /// This method builds a card that displays the notebook and icons on the page.
  /// The card contains individual notebooks.
  ///
  /// @param [notebookModel]  A list containing the NotebookModel objects.
  /// @param [index]          The index of the NotebookModel object in the list.
  ///
  /// @precondition The [notebookModel] cannot be null or empty.
  /// @return A padding containing the card which contains the notebook.
  Widget _buildCard(List<NotebookModel> notebookModel, int index) {
    if (notebookModel == null || notebookModel.isEmpty) {
      throw new ArgumentError("The NotebookModel List cannot be null or empty");
    }
    return Padding(
      padding: EdgeInsets.all(this._width * .01),
      child: Card(
        color: Colors.grey[850],
        child: Padding(
          padding: EdgeInsets.all(this._width * .09),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    notebookModel[index].toJson()['name'].toString(),
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  Container(
                    width: this._width * .70,
                    child: Text(
                      notebookModel[index].toJson()['description'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// This method builds the dialog box for th user to enter notebook details when they create
  /// a new notebook.
  /// This method is called when the floating action button on the scaffold is pressed.
  ///
  /// @param [context] The position of the widget in the widget tree.
  ///
  /// @precondition none.
  /// @postcondition A new dialog is created.
  _createInputDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AlertDialog(
                  backgroundColor: backGroundColor,
                  title: Text(
                    "Create Notebook",
                    style: TextStyle(color: primaryColor),
                  ),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: this._notebookNameTextEditingController,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              labelText: "Enter notebook name",
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please eneter a valid name";
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          controller:
                              this._notebookDescriptionTextEditingController,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              labelText: "Enter notebook description",
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid description";
                            }

                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                        elevation: 5.0,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            NotebookModel theNotebookModel = new NotebookModel(
                                name: this
                                    ._notebookNameTextEditingController
                                    .text,
                                description: this
                                    ._notebookDescriptionTextEditingController
                                    .text);

                            this
                                ._taskProvider
                                .addNotebook(theNotebookModel)
                                .then((value) => Navigator.pop(
                                    context)); // Add notebook in firestore and then pop the dialog.

                          }
                        })
                  ],
                ),
              ],
            ),
          );
        });
  }
}
