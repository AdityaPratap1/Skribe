import 'package:app/configuration/constraints.dart';
import 'package:app/configuration/input_validator.dart';
import 'package:app/configuration/size_config.dart';
import 'package:app/models/task_model.dart';
import 'package:app/view_models/task_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// This class builds the task page when a notebook is clicked.
/// This class is part of the provider design pattern, that is
/// the state management for this page is done in the viewmodel class.
///
/// @author [Aditya Pratap]
/// @version 1.0
class TaskPage extends StatefulWidget {
  String notebookDocId;
  TaskPage({@required this.notebookDocId});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<TaskModel> _tasks;
  double _height;
  double _width;
  TaskViewModel _taskProvider;
  var _focusNode;
  final _formKey = new GlobalKey<FormState>();

  TextEditingController _taskNameTextEditingController;

  @override
  void initState() {
    super.initState();
    this._focusNode = new FocusNode();
    this._taskNameTextEditingController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    this._height = SizeConfig.screenHeight;
    this._width = SizeConfig.screenWidth;
    this._taskProvider = Provider.of<TaskViewModel>(context);

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
          Expanded(
            child: Container(
              child: StreamBuilder(
                  stream: this
                      ._taskProvider
                      .fetchProductsAsStream(this.widget.notebookDocId),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      // Serialize data from firestore into TaskModel objects
                      // and populate the tasks list with the objects.   
                      this._tasks = snapshot.data.documents
                          .map((doc) =>
                              TaskModel.fromMap(doc.data, doc.documentID))
                          .toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: this._tasks.length,
                        itemBuilder: (context, index) {
                          return this._buildCard(this._tasks, index);
                        },
                      );
                    } else {
                      return Text("no data",
                          style: TextStyle(color: Colors.white));
                    }
                  }),
            ),
          ),
          this._showTaskBox(context)
        ],
      ),
      floatingActionButton: Visibility(
        visible: this._taskProvider.floatingButtonVisibility,
        child: FloatingActionButton(
          onPressed: () {
            this._taskProvider.taskBoxVisibility = true;
            this._taskProvider.floatingButtonVisibility = false;
            this._focusNode.requestFocus();
          },
          heroTag: "taskTag",
          child: Icon(
            Icons.add,
            color: backGroundColor,
          ),
          backgroundColor: primaryColor,
        ),
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
    return Dismissible(
      onDismissed: (value) {
        this._taskProvider.removeTask(widget.notebookDocId,
            this._tasks[index].toJson()['documentId'].toString());
      },
      direction: DismissDirection.endToStart,
      key: ValueKey(this._tasks[index]),
      child: Padding(
        padding: EdgeInsets.all(this._width * .001),
        child: Card(
          color: Colors.grey[850],
          child: Padding(
            padding: EdgeInsets.all(this._width * .04),
            child: Row(
              children: <Widget>[
                Theme(
                    data: ThemeData(unselectedWidgetColor: primaryColor),
                    child: Checkbox(
                      value: false,
                      onChanged: (state) => {state = true},
                      checkColor: backGroundColor,
                      activeColor: primaryColor,
                    )),
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
                        "Due: " +

                            // Convert Timestamp object to a formatted readable String.
                            DateFormat.yMMMd().format(DateTime.parse(
                                taskModel[index]
                                    .toJson()['duedate']
                                    .toDate()
                                    .toString())),
                        style: TextStyle(
                          color: primaryColor,
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
      ),
    );
  }

  /// This method shows the task box where the user can eneter the task and set a due date.
  /// This box is only visible when the user taps on the floating action button.
  /// The box is invisible onece the task has been created or the page is disposed.
  ///
  /// @param [context] The position of the widget on the widget tree.
  ///
  /// @prcondition none.
  /// @preturn A visibility widget that contains the task box.
  Widget _showTaskBox(BuildContext context) {
    return Visibility(
      visible: this._taskProvider.taskBoxVisibility,
      child: Form(
        key: this._formKey,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(this._width * .03),
                color: backGroundColor,
                child: new TextFormField(
                    controller: this._taskNameTextEditingController,
                    style: TextStyle(color: Colors.white),
                    focusNode: this._focusNode,
                    decoration: new InputDecoration(
                        labelText: 'Enter Task',
                        labelStyle: TextStyle(color: Colors.white)),
                    validator: (value) => InputValidator.todoAspects(value),
                    onFieldSubmitted: (value) {
                      // On submit, validate the form and set timestamp from due date.
                      if (this._formKey.currentState.validate()) {
                        Timestamp timestamp;
                        if (this._taskProvider.dueDate != null) {
                          timestamp =
                              Timestamp.fromDate(this._taskProvider.dueDate);
                        }

                        // Populate the taskModel object and use it to make a new task in firestore.
                        TaskModel taskModel = new TaskModel(
                            title: this._taskNameTextEditingController.text,
                            status: true,
                            dueDate: timestamp);
                        this._formKey.currentState.reset();

                        //Pass the object into the addTask method to create a task in forestore.
                        // Then, change the visibility of the button and taskBox.
                        this
                            ._taskProvider
                            .addTask(taskModel, widget.notebookDocId)
                            .then((value) => {
                                  this._taskProvider.taskBoxVisibility = false,
                                  this._taskProvider.floatingButtonVisibility =
                                      true,
                                });
                      }
                    })),
            GestureDetector(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100))
                    .then((date) {
                  this._taskProvider.dueDate = date;
                });
              },
              child: Container(
                padding: EdgeInsets.all(this._width * .03),
                color: backGroundColor,
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: this._width * .05,
                    ),
                    Text(
                      "Set due date",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this._taskProvider.floatingButtonVisibility = true;
    this._taskProvider.taskBoxVisibility = false;
  }
}
