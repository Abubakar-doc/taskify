import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String? description;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a Task to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Convert a map from Firestore to a Task
  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
      id: id,
      title: map['title'] ?? '',
      description: map['description'],
      createdAt: map['createdAt'] ?? Timestamp.now(), // Handle null case
      updatedAt: map['updatedAt'] ?? Timestamp.now(), // Handle null case
    );
  }
}
