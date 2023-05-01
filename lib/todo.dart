import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  Todo(DocumentSnapshot doc) {
    documentReference = doc.reference;
    title = doc['title'];
  }
  late String title;
  late bool isDone = false;
  late DocumentReference documentReference;
}
