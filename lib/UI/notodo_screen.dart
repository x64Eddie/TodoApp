import 'package:flutter/material.dart';

class NoTodoScreen extends StatefulWidget{

  @override
  _NoTodoScreen createState() => new _NoTodoScreen();
}

class _NoTodoScreen extends State<NoTodoScreen>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: Column(),
      floatingActionButton: new FloatingActionButton(
          tooltip: "Add Item",
          backgroundColor: Colors.redAccent,
          child: new ListTile(
            title: new Icon(Icons.add),
          ),
          onPressed: _showFormDialog
      ),
    );
  }

  void _showFormDialog(){

  }
}