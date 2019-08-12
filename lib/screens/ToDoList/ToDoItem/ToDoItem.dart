import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
  ToDoItem(
      {Key key,
      this.text,
      this.done,
      this.isEditing,
      this.handleChangeState,
      this.handleDeleteToDo})
      : super(key: key);

  final String text;
  final bool done;
  final bool isEditing;

  final Function(String, bool) handleChangeState;
  final Function(String) handleDeleteToDo;

  _handleChangeState() {
    this.handleChangeState(this.text, this.done);
  }

  _handleDeleteToDo() {
    this.handleDeleteToDo(this.text);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: _handleChangeState,
        enabled: !isEditing,
        title: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              text,
              style: TextStyle(
                  decoration: this.done
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: this.done
                      ? Color.fromRGBO(180, 180, 180, 1)
                      : Color.fromRGBO(0, 0, 0, 1)),
            )),
            Visibility(
                visible: isEditing,
                child: IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  onPressed: isEditing ? _handleDeleteToDo : null,
                ))
          ],
        ));
  }
}
