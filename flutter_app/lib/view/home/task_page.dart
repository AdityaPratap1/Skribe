import 'package:app/configuration/constraints.dart';
import 'package:app/configuration/size_config.dart';
import 'package:app/models/task_model.dart';
import 'package:app/view_models/task_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This class builds the task page when a notebook is clicked.
/// This class is part of the provider design pattern, that is
/// the state management for this page is done in the viewmodel class.
///
/// @author [Aditya Pratap]
/// @version 1.0
class TaskPage extends StatelessWidget {
  String notebookDocId;
  TaskPage({@required this.notebookDocId});
  List<TaskModel> _tasks;
  double _height;
  double _width;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskViewModel>(context);
    SizeConfig().init(context);
    this._height = SizeConfig.screenHeight;
    this._width = SizeConfig.screenWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: this._width * .35, top: this._height * .08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tasks",
                  style: TextStyle(
                      color: Colors.white, fontSize: this._width * .10),
                )
              ],
            ),
          ),
          Container(
            child: StreamBuilder(
                stream: taskProvider.fetchProductsAsStream(this.notebookDocId),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    this._tasks = snapshot.data.documents
                        .map((doc) =>
                            TaskModel.fromMap(doc.data, doc.documentID))
                        .toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: this._tasks.length,
                      itemBuilder: (context, index) {
                        debugPrint("TASK TITILE" +
                            this._tasks[index].toJson()['title'].toString());

                        return this._buildCard(this._tasks, index);
                      },
                    );
                  } else {
                    return Text("no data",
                        style: TextStyle(color: Colors.white));
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        heroTag: "taskTag",
        child: Icon(
          Icons.add,
          color: backGroundColor,
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  /// This method builds a card that displays the task and icons on the page.
  /// The card contains individual tasks.
  ///
  /// @param [taskModel]  A list containing the TaskModel objects.
  /// @param [index]      The index of the task in the list.
  ///
  /// @precondition The [taskModel] cannot be null ior empty.
  /// @return A padding containing the card which contains the task.
  Widget _buildCard(List<TaskModel> taskModel, int index) {
    if (taskModel == null || taskModel.isEmpty) {
      throw new ArgumentError("The TaskModel List cannot be null or empty");
    }
    return Padding(
      padding: EdgeInsets.all(this._width * .01),
      child: Card(
        color: Colors.grey[850],
        child: Padding(
          padding: EdgeInsets.all(this._width * .02),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    taskModel[index].toJson()['title'].toString(),
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Container(
                    width: this._width * .70,
                    child: Text(
                      taskModel[index].toJson()['description'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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
}
