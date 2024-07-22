import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/services/notification_service.dart';
import 'package:todo_list_app/views/task_list_screen.dart';
import 'package:todo_list_app/viewsmodels/task_viewmodel.dart';
import 'package:timezone/data/latest.dart' as tz;
//import 'package:your_app_name/viewmodels/task_viewmodel.dart';
//import 'package:your_app_name/views/task_list_screen.dart';
//import 'package:your_app_name/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  final notificationService = NotificationService();
  await notificationService.init();

  runApp(MyApp(notificationService: notificationService));
}

class MyApp extends StatelessWidget {
  final NotificationService notificationService;

  MyApp({required this.notificationService});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: MaterialApp(
        title: 'ToDo List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TaskListScreen(notificationService: notificationService),
      ),
    );
  }
}
