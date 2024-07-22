// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// import 'package:todo_list_app/models/task.dart';
// //import '../models/task.dart';

// class TaskViewModel extends ChangeNotifier {
//   List<Task> _tasks = [];

//   List<Task> get tasks => _tasks;

//   TaskViewModel() {
//     loadTasks();
//   }

//   void addTask(Task task) {
//     _tasks.add(task);
//     saveTasks();
//     sortTasksByPriority();

//     notifyListeners();
//   }

//   void editTask(Task task) {
//     int index = _tasks.indexWhere((t) => t.id == task.id);
//     if (index != -1) {
//       _tasks[index] = task;
//       saveTasks();
//       sortTasksByPriority();
//       notifyListeners();
//     }
//   }

//   void deleteTask(String id) {
//     _tasks.removeWhere((task) => task.id == id);
//     saveTasks();
//     notifyListeners();
//   }

//   void sortTasksByPriority() {
//     _tasks.sort((a, b) => a.priority.compareTo(b.priority));
//   }
  

//   List<Task> searchTasks(String query) {
//     if (query.isEmpty) {
//       return _tasks;
//     } else {
//       return _tasks.where((task) {
//         return task.title.toLowerCase().contains(query.toLowerCase()) ||
//             task.description.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     }
//   }

  
//   void loadTasks() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? tasksJson = prefs.getString('tasks');
//     if (tasksJson != null) {
//       List<dynamic> tasksList = jsonDecode(tasksJson);
//       _tasks = tasksList.map((json) => Task.fromJson(json)).toList();
//       notifyListeners();
//     }
//   }

//   void saveTasks() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String tasksJson = jsonEncode(_tasks.map((task) => task.toJson()).toList());
//     prefs.setString('tasks', tasksJson);
//   }
// }










import 'package:flutter/material.dart';
import 'package:todo_list_app/viewsmodels/database_helper.dart';
import '../models/task.dart';


class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskViewModel() {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    _tasks = await DatabaseHelper.instance.fetchTasks(orderBy: 'priority');
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await DatabaseHelper.instance.insertTask(task);
    await fetchTasks(); 
  }

  Future<void> editTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    await fetchTasks(); 
  }

  Future<void> deleteTask(String id) async {
    await DatabaseHelper.instance.deleteTask(id);
    await fetchTasks(); 
  }

  List<Task> searchTasks(String query) {
    if (query.isEmpty) {
      return _tasks;
    }
    return _tasks.where((task) {
      return task.title.toLowerCase().contains(query.toLowerCase()) ||
             task.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
