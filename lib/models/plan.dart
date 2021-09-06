//holds all tasks
import './task.dart';

class Plan {
  String name = '';
  final List<Task> tasks = [];
  //show progress
  int get completeCount => tasks.where((task) => task.complete).length;
  String get completenessMessage =>
      '$completeCount ouf of ${tasks.length} tasks';


}
