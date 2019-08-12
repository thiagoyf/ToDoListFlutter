import 'package:flutter/material.dart';
import 'package:to_do_list/screens/AddToDo/AddToDo.dart';
import 'package:to_do_list/screens/ToDoList.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ToDoList(title: 'To-do List'),
      },
    );
  }
}
