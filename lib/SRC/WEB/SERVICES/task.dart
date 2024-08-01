import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskify/SRC/WEB/MODEL/task.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'Task';

  Future<void> createTask(Task task) async {
    await _firestore.collection(_collectionName).add({
      ...task.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Task>> getTasksStream() {
    return _firestore
        .collection(_collectionName)
        .orderBy('title', descending: false) // Add ordering here
        .snapshots()
        .map(
          (snapshot) {
        return snapshot.docs
            .map((doc) => Task.fromMap(doc.data(), doc.id))
            .toList();
      },
    );
  }


  Future<void> updateTask(Task task) async {
    await _firestore.collection(_collectionName).doc(task.id).update({
      ...task.toMap(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteTask(String id) async {
    await _firestore.collection(_collectionName).doc(id).delete();
  }
}
