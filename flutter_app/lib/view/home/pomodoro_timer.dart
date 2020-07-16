import 'dart:async';

import 'package:app/configuration/constraints.dart';
import 'package:app/configuration/size_config.dart';
import 'package:app/view_models/pomodoro_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

/// This class builds the pomodoro timer page/aspect of the app.
/// The pomodoro method is a study method where a study session takes place
/// for 25 minutes followed by a 5 minute break. The study session and the break
/// session combined make up 1 cycle. People can choose  the number of cycles
/// they wish to syudy for.
///
/// @author [Aditya Pratap]
/// @version 1.0
class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

/// This is a child class of the pomodoro timer.
/// This class maintins widgets and their states.
class _PomodoroTimerState extends State<PomodoroTimer> {
  double _height;
  double _width;
  SnackBar _snackBar;
  TextEditingController _cyclesTextFieldController;
  PomodoroViewModel _pomodoroViewModel;

  /// This method is invoked the class is instantiated.
  /// This 0-pramater constructor initializes the instance variables
  ///
  /// @precondition none.
  /// @postcondiotn Initialized instance variables.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this._cyclesTextFieldController = new TextEditingController();
      this._snackBar = new SnackBar(content: null);
      this._pomodoroViewModel = new PomodoroViewModel();
    });
  }

  /// This method builds the pomodore timer page and is the parent  of the widget tree.
  /// All the widgets are contained within the build method.
  ///
  /// This page implements a observer design pattern implemeted with Provider.
  /// The observer listens to change in state of all the vraibles in the widget tree.
  /// The whole widget tree is wrapped in ChangeNotifierProvider, which acts as a
  /// medium to the model class where the notifications are sent from.
  /// The Consumer listens to the changes and changes the state of the variables in the widget
  /// tree.
  ///
  /// @param [context] The the location of the widget in the widget tree.
  /// @precondition The build context cannot be null or void.
  ///
  /// @postcondtion The pomodoro timer page is built.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    this._height = SizeConfig.screenHeight;
    this._width = SizeConfig.screenWidth;
    // Provider listens to changes in state from the model class.
    return ChangeNotifierProvider<PomodoroViewModel>(
      create: (context) => PomodoroViewModel(),
      child: Consumer<PomodoroViewModel>(
        builder: (context, PomodoroViewModel, _) => Scaffold(
          body: SingleChildScrollView(
              child: Center(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: this._height * .10),
                child: Text(
                  "Pomodoro",
                  style: TextStyle(
                      fontSize: this._width * .13, color: Colors.white),
                ),
              ),
              // set the pomodoreModel object to the global pomodoroModle object
              this._setPomodoroViewModelObject(PomodoroViewModel),

              SizedBox(height: this._height * .05),
              CircularPercentIndicator(
                  percent: this._pomodoroViewModel.timeForTimer /
                      (this._pomodoroViewModel.getTime),
                  center: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: this._height * .10),
                          child: Text(
                            this._pomodoroViewModel.currentCycle.toString() +
                                " of " +
                                this._pomodoroViewModel.numberCycles.toString(),
                            style: TextStyle(
                                fontSize: this._width * .08,
                                color: Colors.white),
                          ),
                        ),
                        Text(this._pomodoroViewModel.timerText,
                            style: TextStyle(
                                color: Colors.white, fontSize: _width * .18)),
                      ],
                    ),
                  ),
                  radius: this._width * .75,
                  lineWidth: this._width * .03  ,
                  backgroundColor: this._pomodoroViewModel.backgroundColor,
                  progressColor: this._pomodoroViewModel.progressColor),
              SizedBox(height: this._height * .05),
              Stack(children: [
                this._showStartTimerButton(),
                this._showStopButton(),
              ]),
              SizedBox(height: this._height * .03),
 
              Row(
                children: [
                  SizedBox(
                    width: _width * .10,
                  ),
                  Text(
                    "Enter the number of cycles",
                    style: TextStyle(
                        color: Colors.white, fontSize: this._width * .04),
                  ),
                  this._showCyclesTextField()
                ],
              ),
            ]),
          )),
        ),
      ),
    );
  }

  /// This method sets the passed in PomodoroViewModel object to the global PomodoroViewModel object.
  /// The global pomodoreModel object can be used throughout the class rather then just the widget tree.
  ///
  /// @param [PomodoroViewModel] The PomodoroViewModel that needs to be set to the global variable.
  ///
  /// @precondition The PomodoroViewModel object cannot be null
  /// @return A blank, shrunken sized box used as a filler.
  Widget _setPomodoroViewModelObject(PomodoroViewModel PomodoroViewModel) {
    if (PomodoroViewModel == null) {
      throw new ArgumentError("The PomodoroViewModel object cannot be null");
    }
    this._pomodoroViewModel = PomodoroViewModel;

    return SizedBox.shrink();
  }

  /// This method creates a timer object and starts a timer given the specified time in seconds.
  /// Inside, the timer, the state of timeForTimer of [this._pomodoroViewModel.timeForTimer] decreases every second.
  /// And when the timer reaches 0, the timer is cancelled.
  ///
  /// @param [timeForTimer] The amount of time the timer should run for in seconds.
  ///
  /// @precondition The timeForTimer parameter must be greater than 0.
  /// @postcondition A timer is started using the specified time.
  _startTimer(int timeForTimer) async {
    if (timeForTimer <= 0) {
      throw new ArgumentError("The specified time must be greater than 0");
    }
    this._pomodoroViewModel.timeForTimer =
        timeForTimer; //This time varibale will change every second.
    this._pomodoroViewModel.setTime =
        timeForTimer; // This time varibale will change and is used for setting the percentage of the percentIndicator.
    this._pomodoroViewModel.isStartButtonVisible = false;

    this._pomodoroViewModel.setTimer =
        Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (this._pomodoroViewModel.timeForTimer == 0) {
        this._pomodoroViewModel.getTimer.cancel();
      } else {
        this._pomodoroViewModel.timeForTimer--;
        this._pomodoroViewModel.timerText = _convertToStandardTime(this
            ._pomodoroViewModel
            .timeForTimer); // converts seconds to minutes and seconds.
      }
    });
  }

  /// This method converts a time in seconds to a standard, readable time format (mm:ss).
  ///
  /// @param [timeForTimer] The time to convert to standard time in seconds.
  ///
  /// @precondtion The timeForTimer must be greater than 0.
  /// @return A string displaying the timer time in standard form.
  String _convertToStandardTime(int timeForTimer) {
    String timeToDisplay;
    if (timeForTimer < 60) {
      timeToDisplay = timeForTimer
          .toString(); // If the timer is less than 60 seconds, show text as it is since there is no need to convert to minutes and seconds.
      timeForTimer = timeForTimer - 1; // deduct a second from the time.
    } else if (timeForTimer < 3600) {
      int m = timeForTimer ~/
          60; // If the timer is les than an hour, divide by sixty to obtain minutes.
      int s = timeForTimer -
          (60 * m); // subtract 60 multiplied by the minutes to obtain seconds.
      timeToDisplay = m.toString() +
          ":" +
          s.toString(); // Return this string to be displayed as the timer.
      timeForTimer = timeForTimer - 1;
    }
    return timeToDisplay;
  }

  /// This method builds the start button for the timer.
  /// The visibility/usablity of this button depends on whether the timer
  /// has been started or not.
  ///
  /// @onPressed Start the timer by calling [this._startCycles()].
  ///
  /// @precondtion none.
  /// @return  If the timer has been started [isStartButtonVisible = false], return an empty container.
  /// @return If the timer has not been started, return a floating action button.
  ///
  Widget _showStartTimerButton() {
    if (!this._pomodoroViewModel.isStartButtonVisible) {
      return Container(
        width: this._width * .13,
      );
    } else {
      return FloatingActionButton(
        onPressed: () async => {
          if (this._cyclesTextFieldController.text.isEmpty)
            {
              this._snackBar = SnackBar(
                content: Text('Please enter number of cycles',
                    style: TextStyle(color: Colors.red)),
              ),
              Scaffold.of(context).showSnackBar(this._snackBar)
            },
          this._pomodoroViewModel.numberCycles =
              int.parse(this._cyclesTextFieldController.text),
          this._startCycles(),
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.play_arrow,
          color: backGroundColor,
        ),
      );
    }
  }

  /// This method builds the textfield that prompts for the number of pomodoro cycles.
  ///
  /// @onChanged On value changed, set the [this._cyclesTextFieldController.text] to the value currently enetered in
  /// the textfield.
  ///
  /// @precndition none.
  /// @return A container containing the textField.
  Widget _showCyclesTextField() {
    return Container(
      width: this._width * .20,
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
        style: TextStyle(color: Colors.white, fontSize: this._width * .08),
        textAlign: TextAlign.center,
        cursorColor: primaryColor,
        controller: this._cyclesTextFieldController,
        onChanged: (value) => value = this._cyclesTextFieldController.text,
      ),
    );
  }

  /// This method builds the stop button for the timer.
  /// The visibility/usablity of this button depends on whether the timer
  /// has been started or not.
  ///
  /// @onPressed Stop the timer by cancelling [this._pomodoroViewModel.getTimer.cancel()] and reset all the variables
  /// relating to the timer.
  ///
  /// @precondtion none.
  /// @return  If the timer has not been started [arePauseandStopButtonsVisible = false], return an empty container.
  /// @return If the timer has been started, return a floating action button.
  ///
  Widget _showStopButton() {
    if (!this._pomodoroViewModel.isStopButtonVisible) {
      return Container(
        width: this._width * .13,
      );
    } else {
      return FloatingActionButton(
        onPressed: () {
          this._pomodoroViewModel.getTimer.cancel();
          this._pomodoroViewModel.setTime = 1500;
          this._pomodoroViewModel.timeForTimer = 1500;
          this._pomodoroViewModel.timerText = "25:00";
          this._pomodoroViewModel.isStopButtonVisible = false;
          this._pomodoroViewModel.isStartButtonVisible = true;
          this._pomodoroViewModel.numberCycles = 0;
          this._pomodoroViewModel.currentCycle = 0;
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.stop,
          color: backGroundColor,
        ),
      );
    }
  }

  /// This method calls the [this._startTimer()] method in a loop specified by the number of pomodoro cycles.
  ///
  /// Once the timer starts, the next method is called without waiting for the timer to end. To fix thid problem,
  /// a Future.delayed is called that runs as long as the timer. This method will prevent other methods below it form being executed
  /// for the duration.
  ///
  /// @precondition none.
  /// @postcondition A timer in a loop specified by the number of cycles.
  _startCycles() async {
    this._pomodoroViewModel.isStopButtonVisible = true;
    for (int i = 0; i < this._pomodoroViewModel.numberCycles; i++) {
      this._pomodoroViewModel.currentCycle = i + 1;

      //Start Study Timer
      this._pomodoroViewModel.progressColor = primaryColor;
      this._pomodoroViewModel.backgroundColor = backGroundColor;
      this._startTimer(20);
      await Future.delayed(Duration(
          seconds:
              21)); // Dlay execution to prevent the rest of the code from running.
      Vibration.vibrate(
          duration: 5000,
          amplitude:
              255); //Haptic feedback to let user knoe cycle has been completed.
      this
          ._pomodoroViewModel
          .getTimer
          .cancel(); //Cancel the timer to prevent overlaping of timers.

      //Start Break Timer
      this._pomodoroViewModel.progressColor = backGroundColor;
      this._pomodoroViewModel.backgroundColor = primaryColor;
      this._startTimer(10);
      await Future.delayed(Duration(seconds: 12));
      Vibration.vibrate(duration: 5000, amplitude: 255);

      this._pomodoroViewModel.getTimer.cancel();

      //this._startTimer(PomodoroViewModel, 5),
    }

    this._pomodoroViewModel.isStartButtonVisible = true;
    this._pomodoroViewModel.isStopButtonVisible = false;
  }
}
