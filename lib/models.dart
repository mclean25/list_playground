import 'package:flutter/material.dart';

class ListObject extends ChangeNotifier {
  List<EditableListItem> items;

  ListObject({@required this.items});

  void addEditItem() {
    this.items.add(
          new EditableListItem(
              isEditable: true,
              isNewCreateItem: true,
              listItem: new ListItem(text: "Hey", createdAt: DateTime.now())),
        );

    notifyListeners();
  }

  void editListItem(EditableListItem item) {
    item.isEditable = true;
    notifyListeners();
  }

  void finishEditItem(EditableListItem item) {
    item.isEditable = false;
    notifyListeners();
  }

  void cancelEditItems() {
    print("cancelling edit items");
    items.forEach((item) {
      item.isEditable = false;
    });
    notifyListeners();
  }
}

class EditableListItem {
  // True if the text of the item is currently editable
  bool isEditable;

  // True if the item is being currently added to the lsit
  bool isNewCreateItem;

  ListItem listItem;
  TextEditingController textController;

  EditableListItem({
    @required this.isEditable,
    @required this.isNewCreateItem,
    @required this.listItem,
  }) {
    this.textController = new TextEditingController(text: this.listItem.text);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is EditableListItem &&
        o.listItem.createdAt == this.listItem.createdAt &&
        o.listItem.text == this.listItem.text;
  }

  @override
  int get hashCode => listItem.text.hashCode ^ listItem.createdAt.hashCode;
}

class ListItem {
  String text;
  DateTime createdAt;

  ListItem({@required this.text, @required this.createdAt});
}
