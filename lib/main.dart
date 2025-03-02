import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  void addTask() {
    setState(() {
      String taskName = "New Task ${tasks.length + 1}";
      tasks.add(taskName);
      checkedTasks.add(false); 

      int taskId = taskIdCounter++;  
      taskIds.add(taskId);

      items.add(
        SizedBox(
          key: Key(taskId.toString()),  
          width: 200,
          height: 100,
          child: Row(
            children: [
              Checkbox(
                value: checkedTasks.last,
                onChanged: (bool? value) {
                  setState(() {
                    checkedTasks[checkedTasks.length - 1] = value!;
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
        onPressed: addTask,
        child: const Text("Add Task"),
      ),
    );
  }
}
