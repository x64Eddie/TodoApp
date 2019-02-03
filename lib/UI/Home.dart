import 'package:flutter/material.dart';
import 'package:no_todo_app/UI/notodo_screen.dart';

class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("TODO", textAlign: TextAlign.center,),
        backgroundColor: Colors.black54,
      ),
      body: new NoTodoScreen(),
    );
  }
}