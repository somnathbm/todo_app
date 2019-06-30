import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utils/dbHelper.dart';

class TodoDetail extends StatefulWidget {
  final Todo todo;
  TodoDetail(this.todo);

  @override
  _TodoDetailState createState() => _TodoDetailState(todo);
}

class _TodoDetailState extends State<TodoDetail> {
  Todo todo;
  _TodoDetailState(todo);

  final _priorities = ["High", "Medium", "Low"];
  String _priority = "Low";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = todo.getTitle;
    descriptionController.text = todo.getDescription;
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(todo.getTitle),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: titleController,
            style: textStyle,
            decoration: InputDecoration(
              labelText: "Title",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
              )
            ),
          ),
          TextField(
            controller: descriptionController,
            style: textStyle,
            decoration: InputDecoration(
                labelText: "Description",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                )
            ),
          ),
          DropdownButton<String>(
            items: _priorities.map((String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            )).toList(),
            style: textStyle,
            value: "Low",
            onChanged: null,
          )
        ],
      ),
    );
  }
}
