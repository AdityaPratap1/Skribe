import 'dart:async';

import 'package:app/configuration/constraints.dart';
import 'package:flutter/cupertino.dart';

/// This is the model class for the PomodoroTimer class.
/// This class extends the ChangeNotifier class the mnotifies state change to all of
/// it listeners. This is part of the Provider design paradigm.
///
/// This model class holds the variables whose state is being changed during execution.
///
/// @author [Aditya Pratap]
/// @version 1.0
class PomodoroViewModel extends ChangeNotifier {
  int _timeForTimer = 0;
  int _currentCycle = 0;
  int _numberOfPomodoroCycles = 0;
  int _time = 0;
  bool _isStartButtonVisible = true;
  bool _isStopButtonVisible = false;
  Timer _timer;
  Color _progressColor = primaryColor;
  Color _backgroundColor = backGroundColor;
  String _timerText = "25:00";

  /// This setter method assigns the instance variable with the specified variable.
  /// Once the variable is assigned, notify all listeners.
  ///
  /// @param [text] The timer text to be intialized.
  ///
  /// @preconditon The text cannot be null or empty.
  /// @postconditon The [_timerText] is assigned to the specified text.
  set timerText(String text) {
    if (text == null || text.isEmpty) {
      throw new ArgumentError("The text cannot be null or empty");
    }
    this._timerText = text;
    notifyListeners();
  }

  /// This getter method gets the timer text.
  ///
  /// @preconditon none.
  /// @preturn [this._timerText] The text to be displayed on the timer.
  get timerText {
    return this._timerText;
  }

  /// This setter method assigns the instance variable [_timeForTimer] with the specified variable.
  /// Once the variable is assigned, notify all listeners.
  ///
  /// @param [time] The time to be initialized by.
  ///
  /// @preconditon The [time] must be greater than 0.
  /// @postconditon The [_timeForTimer] is assigned to the specified time.
  ///
  set timeForTimer(int time) {
    if (time <= 0) {
      throw new ArgumentError("The time must be greater than 0");
    }
    this._timeForTimer = time;
    notifyListeners();
  }

  /// This getter method gets the time for the timer.
  ///
  /// @precondition none.
  /// @return [this._timeForTimer] The time for the timer.
  get timeForTimer {
    return this._timeForTimer;
  }

  /// This setter method assigns the instance variable [_isStartButtonVisible] with the specified variable.
  /// Once the variable is assigned, notify all listeners.
  ///
  /// @param [visible] The boolean to be initialized by.
  ///
  /// @preconditon none.
  /// @postconditon The [_isStartButtonVisible] is assigned to the specified boolean.
  ///
  set isStartButtonVisible(bool visble) {
    this._isStartButtonVisible = visble;
    notifyListeners();
  }

  /// This getter method gets the boolean that determines if the start button should be visisble or not.
  ///
  /// @precondition none.
  /// @return The boolean that determines if the start button should be visible or not.
  get isStartButtonVisible {
    return this._isStartButtonVisible;
  }

  /// This setter method assigns the instance variable [_isStartButtonVisible] with the specified variable.
  /// Once the variable is assigned, notify all listeners.
  ///
  /// @param [visible] The boolean to be initialized by.
  ///
  /// @preconditon none.
  /// @postconditon The [_isStartButtonVisible] is assigned to the specified boolean.
  ///
  set isStopButtonVisible(bool visble) {
    this._isStopButtonVisible = visble;
    notifyListeners();
  }

  /// This getter method gets the boolean that determines if the stop button should be visisble or not.
  ///
  /// @precondition none.
  /// @return The boolean that determines if the stop button should be visible or not.
  get isStopButtonVisible {
    return this._isStopButtonVisible;
  }

  /// This setter method asigns [this._numberOfPomodoroCycles] with the specified value.
  /// Once the value is assigned, notify all listeners.
  ///
  ///@param [cycles] The number of pomodoro cycles to assign the instance variable with.
  ///
  ///@precondition The [cycles] must be greater than 0.
  ///@postcondition The [this._numberOfPomodoroCycles] is assigned.
  set numberCycles(int cycles) {
    this._numberOfPomodoroCycles = cycles;
    notifyListeners();
  }

  /// This getter method gets the number of pomodoro cycles.
  ///
  /// @precondition none.
  /// @return [this._numberOfPomodoroCycles] The number of pomodoro cycles.wsws
  get numberCycles {
    return this._numberOfPomodoroCycles;
  }

  /// This setter method assigns the timer with the specified timer object.
  /// Once the value is assigned, notify all listeners.
  ///
  /// @param [timer] The timer object to be assigned by.
  ///
  /// @preconditon The timer object cannot be null.
  /// @precondition The [this._timer] object is assigned.
  set setTimer(Timer timer) {
    if (timer == null) {
      throw new ArgumentError("The timer object cannot be null");
    }
    this._timer = timer;
    notifyListeners();
  }

  /// This getter method gets the timer object.
  ///
  /// @precondition none.
  /// @return [this._timer] The timer object.
  get getTimer {
    return this._timer;
  }

  /// This setter method assigns the current pomodoro cycle the user is on.
  /// Once the value is assigned, notify all the listeners.
  ///
  /// @param [cycle] The current pomodoro cycle the user is on.
  ///
  /// @precondition The cycle must be greater than 0.
  /// @postcondiion The [this._currentCycle] is assigned.
  set currentCycle(int cycle) {
    this._currentCycle = cycle;
    notifyListeners();
  }

  /// This getter method gets the current pomodoro cycle the user is on.
  ///
  /// @precondition none.
  /// @return [this._currentCycle] The current pomodoro cycle the user is on.
  get currentCycle {
    return this._currentCycle;
  }

  /// This setter method assigns the [this._time] to the specified time.
  /// Once the value is assigned, notify all listeners.
  ///
  /// @param [time] The time to assign the instance variable with.
  ///
  /// @precondition The time must be greater than 0.
  /// @postcondition The[this._time] is assigned.
  set setTime(int time) {
    this._time = time;
    notifyListeners();
  }

  /// This getter method gets the total time of the current phase.
  /// If the cycle is in the study pahse, this method returns 1500 seconds.
  /// If on the break phase, this method returns 300 seconds.
  ///
  /// @precondition none.
  /// @return [this._time] The total time of the phase.
  get getTime {
    return this._time;
  }

  /// This setter method assigns the [this._progressColor] to the specifies Color object.
  /// The progress color is the progress color of the precent indicator on the pomodoro timer
  /// page.
  ///
  /// Once the value is assigned, notify all listeners.
  ///
  /// @param [color] The colr to assign the instance variable with.
  ///
  /// @precondition The color object cannot be null.
  /// @postcondition The [this._progressColor] is assigned.
  set progressColor(Color color) {
    this._progressColor = color;
    notifyListeners();
  }

  /// This getter method gets the progress color of the percent indicator.
  ///
  /// @precondition none.
  /// @return [this._progressColor] The progress color of the percent indicator.
  get progressColor {
    return this._progressColor;
  }

  /// This setter method assigns the [this._backgroundColor] to the specifies Color object.
  /// The background color is the background color of the precent indicator on the pomodoro timer
  /// page.
  ///
  /// Once the value is assigned, notify all listeners.
  ///
  /// @param [color] The colr to assign the instance variable with.
  ///
  /// @precondition The color object cannot be null.
  /// @postcondition The [this._backgroundColor] is assigned.
  set backgroundColor(Color color) {
    this._backgroundColor = color;
    notifyListeners();
  }

  /// This getter method gets the background color of the percent indicator.
  ///
  /// @precondition none.
  /// @return [this._backgroundColor] The background color of the percent indicator.
  get backgroundColor {
    return this._backgroundColor;
  }
}
