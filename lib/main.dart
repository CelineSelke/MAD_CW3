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
  List<String> tasks = [];
  List<bool> checkedTasks = [];
  int taskIDCounter = 0;

  void addTask(String taskName) {
    setState(() {
      tasks.add(taskName);
      checkedTasks.add(false);

      taskIDCounter++;
      if(tasks.length > 7){
        deleteTask(0);
      }
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      checkedTasks.removeAt(index);
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

  Color getColor(int index){
      if(index == 0){
        return Colors.red;
      }
      if(index == 1){
        return Colors.orange;
      }
      if(index == 2){
        return Colors.yellow;
      }
      if(index == 3){
        return Colors.green;
      }
      if(index == 4){
        return Colors.blue;
      }
      if(index == 5){
        return Colors.indigo;
      }
      if(index == 6){
        
      }
      
      return Colors.deepPurple;
      
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
          children: List.generate(
            tasks.length,
            (index) => SizedBox(
              key: Key(index.toString()),
              width: 600,
              height: 100,
              child: Padding(padding: EdgeInsets.all(15),
                child:ColoredBox(color: getColor(index), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: checkedTasks[index],
                    onChanged: (bool? value) {
                      setState(() {
                        checkedTasks[index] = value!;
                      });
                    },
                  ),
                  Text(tasks[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  SizedBox(width: 50, height: 50, child: IconButton(
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    onPressed: () => deleteTask(index),
                    icon: Icon(Icons.restore_from_trash),
                    
                  ),)
                ],
              ),
              )
            )
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        child: const Text("Add\nTask"),
      ),
    );
  }
}
