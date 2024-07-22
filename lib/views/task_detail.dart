
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/viewsmodels/task_viewmodel.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../services/notification_service.dart';
import 'package:intl/intl.dart'; 

class TaskDetailScreen extends StatefulWidget {
  final Task? task;
  final NotificationService notificationService;

  TaskDetailScreen({this.task, required this.notificationService});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  int _priority = 0;
  DateTime _dueDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _priority = widget.task!.priority;
      _dueDate = widget.task!.dueDate;
    }
    _dateController.text = DateFormat('yyyy-MM-dd').format(_dueDate);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var newTask = Task(
        id: widget.task?.id ?? Uuid().v4(),
        title: _title,
        description: _description,
        priority: _priority,
        dueDate: _dueDate,
      );

      if (widget.task == null) {
        Provider.of<TaskViewModel>(context, listen: false).addTask(newTask);
      } else {
        Provider.of<TaskViewModel>(context, listen: false).editTask(newTask);
      }

      widget.notificationService.scheduleNotification(
        newTask.id,
        newTask.title,
        newTask.description,
        _dueDate.subtract(Duration(minutes: 5)), // Schedule 5 minutes before due date
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                value: _priority,
                decoration: InputDecoration(labelText: 'Priority'),
                onChanged: (value) => setState(() => _priority = value!),
                items: [0, 1, 2, 3]
                    .map((priority) => DropdownMenuItem(
                          value: priority,
                          child: Text('Priority $priority'),
                        ))
                    .toList(),
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Due Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != _dueDate) {
                    setState(() {
                      _dueDate = picked;
                      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                
                onPressed: _saveTask,
                child: Text(widget.task == null ? 'Add Task' : 'Save Task'),
                style: ElevatedButton.styleFrom(
    primary: Colors.blue, 
    onPrimary: Colors.white, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), 
    ),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), 
  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
