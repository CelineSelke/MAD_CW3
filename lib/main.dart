import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Task Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> items = [];
  List<String> tasks = [];
  List<bool> checkedTasks = [];
  List<int> taskIds = [];
  int taskIdCounter = 0;

  void addTask(String taskName) {
    setState(() {
      tasks.add(taskName);
      checkedTasks.add(false); 

      int taskId = taskIdCounter; 
      taskIdCounter++;
      taskIds.add(taskId);

      items.add(
        SizedBox(
          key: Key(taskId.toString()), 
          width: 200,
          height: 100,
          child: Row(
            children: [
              Checkbox(
                value: checkedTasks[taskIds.indexOf(taskId)], 
                onChanged: (bool? value) {
                  setState(() {
                    checkedTasks[taskIds.indexOf(taskId)] = value!; 
                  });
                },
              ),
              Text(taskName),
              IconButton(
                onPressed: () => deleteTask(taskId),
                icon: Icon(Icons.restore_from_trash),
              ),
            ],
          ),
        ),
      );
    });
  }

  void deleteTask(int taskId) {
    setState(() {
      int index = taskIds.indexOf(taskId); 
      if (index != -1) {
        tasks.removeAt(index);
        checkedTasks.removeAt(index);
        taskIds.removeAt(index);
        items.removeAt(index);
      }
    });
  }

  void showAddTaskDialog() {
    String newTaskName = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Task Name'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newTaskName = value;
              });
            },
            decoration: const InputDecoration(hintText: "Enter Task Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                if (newTaskName.isNotEmpty) {
                  addTask(newTaskName); 
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        child: const Text("Add Task"),
      ),
    );
  }
}