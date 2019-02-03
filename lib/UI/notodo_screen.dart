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
  final List<NoDoItem> _itemList = <NoDoItem>[];

  @override
  void initState() {
    super.initState();
    _readNoDoList();
  }
  //Handling the message that the user inserted into the app
  void _handleSubmitted(String text) async{
    _textEditingController.clear();

    NoDoItem noDoItem = new NoDoItem(text, DateTime.now().toIso8601String());
    int savedItemId = await db.saveItem(noDoItem);

    NoDoItem addedItem = await db.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });

    print("Item Saved id: $savedItemId");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: new Column(
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
                  padding: new EdgeInsets.all(8.0),
                  reverse: false,
                  itemCount: _itemList.length,
                  itemBuilder: (_, int index){
                    return new Card(
                      color: Colors.white10,
                      child: new ListTile(
                        title: _itemList[index],
                        onLongPress: () => debugPrint(""),
                        trailing: new Listener(
                          key: new Key(_itemList[index].itemName),
                          child: new Icon(Icons.remove_circle),
                          onPointerDown: (pointerEvent) => debugPrint(""),
                        ),
                      ),
                    );
                  })
          ),
          new Divider(
            height: 1.0,
          )
        ],
      ),
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
              Navigator.pop(context);
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
  _readNoDoList() async{
    List items = await db.getItems();
    items.forEach((item){
      //NoDoItem noDoItem = NoDoItem.map(item);
      setState(() {
          _itemList.add(NoDoItem.map(item));
      });
      //print("Db Items: ${noDoItem.itemName}");
    });
  }
}