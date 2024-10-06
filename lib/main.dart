import 'package:flutter/material.dart';

void main() {
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskListScreen(),
    );
  }
}

// Task class to represent a task with name and completion status
class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

// Main StatefulWidget for Task List Screen
class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // List to hold the tasks
  List<Task> tasks = [];

  // Controller for the task input field
  TextEditingController taskController = TextEditingController();

  // Method to add a new task
  void _addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(name: taskController.text)); // Add task
        taskController.clear(); // Clear the input field after adding
      });
    }
  }

  // Method to toggle task completion status
  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted =
          !tasks[index].isCompleted; // Toggle task completion
    });
  }

  // Method to remove a task
  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index); // Remove task
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: [
          // Task input field and "Add" button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Input field to enter the task
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter a new task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // "Add" button
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask, // Add task on button press
                ),
              ],
            ),
          ),
          // Task list display
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
                    task.name,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration
                              .lineThrough // Strike-through for completed tasks
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Checkbox to mark task complete
                      Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          _toggleTaskCompletion(
                              index); // Toggle completion state
                        },
                      ),
                      // Button to delete task
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeTask(index); // Remove task
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
