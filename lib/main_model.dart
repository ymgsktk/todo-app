import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example5/todo.dart';
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  List<Todo> todoList = [];
  String newtodoText = '';

  Future getTodoList() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('todoList').get();
    final docs = snapshot.docs;
    final todoList = docs.map((doc) => Todo(doc)).toList();
    this.todoList = todoList;
    notifyListeners();
  }

  void getTodoListRealtime() {
    final snapshots =
        FirebaseFirestore.instance.collection('todoList').snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final todoList = docs.map((doc) => Todo(doc)).toList();
      todoList.sort((a, b) => a.title.compareTo(b.title));
      this.todoList = todoList;
      notifyListeners();
    });
  }

  Future add() async {
    final collection = FirebaseFirestore.instance.collection('todoList');
    await collection.add({
      'title': newtodoText,
    });
  }

  Future deleteCheckItems() async {
    final checkItems =
        todoList.where((todo) => todo.isDone).toList(); //チェックがついてるやつを絞り込む
    final references = checkItems
        .map((todo) => todo.documentReference)
        .toList(); // ドキュメントリファレンスに変換

    final batch = FirebaseFirestore.instance.batch();

    references.forEach((reference) {
      batch.delete(reference);
    });
    return batch.commit();
  }

  bool checkShouldActiveCompleteButton() {
    final checkItems = todoList.where((todo) => todo.isDone).toList();
    return checkItems.length > 0;
  }
}
