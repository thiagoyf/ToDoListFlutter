import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/screens/AddToDo/AddToDo.dart';
import 'package:to_do_list/screens/ToDoList/ToDoItem/ToDoItem.dart';

class ToDoList extends StatefulWidget {
  ToDoList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  bool isEditing = false;
  List<String> _todos = [];
  List<String> _completed = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadToDoList();
  }

  _loadToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _todos = (prefs.getStringList('todos') ?? []);
      _completed = (prefs.getStringList('completed') ?? []);
    });
  }

  _saveToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList('todos', _todos);
    prefs.setStringList('completed', _completed);
  }

  _handleChangeEditState() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  _handleChangeState(String text, bool done) {
    setState(() {
      done ? _completed.remove(text) : _completed.add(text);
      _saveToDoList();
    });
  }

  _handleDeleteToDo(String text) {
    setState(() {
      _todos.remove(text);
      if (_completed.contains(text)) {
        _completed.remove(text);
      }
      _saveToDoList();
    });
  }

  _navigateToAddToDo(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddToDo(title: 'Add To-do')),
    );

    if (result == null) {
      return;
    }

    if (_todos.contains(result)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Already added'),
      ));
      return;
    }

    setState(() {
      _todos.add(result);
      _saveToDoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _handleChangeEditState,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (BuildContext context, int index) {
          return ToDoItem(
              text: _todos[index],
              done: _completed.contains(_todos[index]),
              isEditing: isEditing,
              handleChangeState: _handleChangeState,
              handleDeleteToDo: _handleDeleteToDo);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          _navigateToAddToDo(context);
        },
      ),
    );
  }
}
