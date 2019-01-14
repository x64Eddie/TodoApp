import 'package:flutter/material.dart';
import 'package:no_todo_app/Model/notodo_item.dart';
import 'package:no_todo_app/Utils/database_client.dart';

class NoTodoScreen extends StatefulWidget{

  @override
  _NoTodoScreen createState() => new _NoTodoScreen();
}

class _NoTodoScreen extends State<NoTodoScreen>{
  final TextEditingController _textEditingController = new TextEditingController();
  var db = new DatabaseHelper();

  //Handling the message that the user inserted into the app
  void _handleSubmitted(String text) async{
    _textEditingController.clear();

    NoDoItem noDoItem = new NoDoItem(text, DateTime.now().toIso8601String());
    int savedItemId = await db.saveItem(noDoItem);

    print("Item Saved id: $savedItemId");
  }

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
    var alert = new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(
              child: new TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: "Item",
                  hintText: "eg. Don't buy stuff",
                  icon: new Icon(Icons.note_add)
                ),
              )
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: (){
              _handleSubmitted(_textEditingController.text);
              _textEditingController.clear();
            },
            child: Text("Save")
        ),
        new FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel")
        )
      ],
    );
    showDialog(
        context: context,
        builder:(_) {
          return alert;
        });
  }
}