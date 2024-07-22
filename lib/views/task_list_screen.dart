
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_list_app/models/task.dart';
// //import 'package:todo_list_app/viewmodels/task_viewmodel.dart';
// //import 'package:todo_list_app/views/task_detail_screen.dart';
// import 'package:todo_list_app/services/notification_service.dart';
// import 'package:todo_list_app/views/task_detail.dart';
// import 'package:todo_list_app/viewsmodels/task_viewmodel.dart';





// class TaskListScreen extends StatefulWidget {
//   final NotificationService notificationService;

//   TaskListScreen({required this.notificationService});

//   @override
//   _TaskListScreenState createState() => _TaskListScreenState();
// }

// class _TaskListScreenState extends State<TaskListScreen> {
//   TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text('ToDo-List',style: TextStyle(color: Colors.white),),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add_task,color: Colors.black,),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => TaskDetailScreen(
//                     notificationService: widget.notificationService,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.blue[50],
//                 labelText: 'Search',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _searchQuery = value;
//                 });
//               },
//             ),
//           ),
//           Expanded(
//             child: Consumer<TaskViewModel>(
//               builder: (context, taskViewModel, child) {
//                 List<Task> tasks = taskViewModel.searchTasks(_searchQuery);
//                 return 
//                 ListView.builder(
//                   itemCount: tasks.length,
//                   itemBuilder: (context, index) {
//                     Task task = tasks[index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Column(
//                         children:[ 
                          
//                           ListTile(
                         
//                           tileColor: Colors.blue[100],
//                           title: Text(task.title),
//                          subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Description: ${task.description}'),
//                                 Text('Priority: ${task.priority}'),
//                               ],
//                             ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () {
//                               taskViewModel.deleteTask(task.id);
//                             },
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => TaskDetailScreen(
//                                   task: task,
//                                   notificationService: widget.notificationService,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         SizedBox(height: 10,)
//                         ]
//                       ),
//                     );
                    
//                   },
//                 );
//               },
//             ),
//           ),
           
         
//         ],
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/views/task_detail.dart';
import 'package:todo_list_app/viewsmodels/task_viewmodel.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../services/notification_service.dart';

class TaskListScreen extends StatefulWidget {
  final NotificationService notificationService;

  TaskListScreen({required this.notificationService});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Provider.of<TaskViewModel>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('ToDo-List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_task, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(
                    notificationService: widget.notificationService,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: Consumer<TaskViewModel>(
              builder: (context, taskViewModel, child) {
                List<Task> tasks = taskViewModel.searchTasks(_searchQuery);
                tasks.sort((a, b) => a.priority.compareTo(b.priority)); 

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    Task task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ListTile(
                            tileColor: Colors.blue[100],
                            title: Text(task.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Description: ${task.description}'),
                                Text('Priority: ${task.priority}'),
                                Text('Due Date: ${task.dueDate.toIso8601String()}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                taskViewModel.deleteTask(task.id);
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskDetailScreen(
                                    task: task,
                                    notificationService: widget.notificationService,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10)
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
