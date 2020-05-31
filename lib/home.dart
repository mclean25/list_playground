import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';

import 'models.dart';

class Home extends StatelessWidget {
  final List<EditableListItem> list = [
    new EditableListItem(
        isEditable: false,
        isNewCreateItem: false,
        listItem:
            new ListItem(text: "Take out garbage", createdAt: DateTime.now())),
    new EditableListItem(
        isEditable: false,
        isNewCreateItem: false,
        listItem: new ListItem(text: "Workout", createdAt: DateTime.now())),
    new EditableListItem(
        isEditable: false,
        isNewCreateItem: false,
        listItem:
            new ListItem(text: "Do back flips", createdAt: DateTime.now())),
    new EditableListItem(
        isEditable: false,
        isNewCreateItem: false,
        listItem: new ListItem(text: "Do crunches", createdAt: DateTime.now())),
    new EditableListItem(
        isEditable: false,
        isNewCreateItem: false,
        listItem: new ListItem(text: "Cook food", createdAt: DateTime.now())),
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => new ListObject(items: this.list),
        child: Consumer<ListObject>(builder: (context, listObject, child) {
          return GestureDetector(
            onTap: () => listObject.cancelEditItems(),
            child: Scaffold(
                appBar: AppBar(
                  title: Text("Things TODO"),
                ),
                body: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.red[100],
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          ImplicitlyAnimatedList<EditableListItem>(
                            items: listObject.items,
                            shrinkWrap: true,
                            areItemsTheSame: (a, b) => a == b,
                            itemBuilder: (context, animation, item, index) {
                              return SizeFadeTransition(
                                  sizeFraction: 0.7,
                                  curve: Curves.easeInOut,
                                  animation: animation,
                                  child: MyListTile(
                                    listObject: listObject,
                                    listItem: item,
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => listObject.addEditItem(),
                  child: Text("add"),
                )),
          );
        }));
  }
}

class MyListTile extends StatefulWidget {
  final EditableListItem listItem;
  final ListObject listObject;

  MyListTile({@required this.listItem, @required this.listObject});

  @override
  _MyListTileState createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  TextEditingController _controller;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    this._controller =
        new TextEditingController(text: widget.listItem.listItem.text);
    super.initState();
  }

  void _makeItemEditable() {
    print("making item editable");
    widget.listObject.editListItem(widget.listItem);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => _makeItemEditable(),
        child: Form(
          key: _formKey,
          child: Container(
            color: Colors.grey[300],
            height: widget.listItem.isEditable ? 60 : 50,
            child: TextFormField(
              autofocus: true,
              controller: _controller,
              enabled: widget.listItem.isEditable,
              onFieldSubmitted: (val) =>
                  widget.listObject.finishEditItem(widget.listItem),
            ),
          ),
        ),
      ),
    );
  }
}
