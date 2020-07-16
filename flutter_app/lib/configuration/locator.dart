import 'package:app/services/notebook_service.dart';
import 'package:app/services/tasks_service.dart';
import 'package:app/view_models/notebook_viewmodel.dart';
import 'package:app/view_models/task_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => TaskService());
  locator.registerLazySingleton(() => TaskViewModel());
  locator.registerLazySingleton(() => NotebookService());
  locator.registerLazySingleton(() => NoteBookViewModel());
}
