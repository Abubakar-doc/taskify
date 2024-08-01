class UserModel {
  final String uid;
  final String name;
  final String email;
  final String departmentId;
  String status;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.departmentId = '',
    this.status = 'pending',
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'departmentId': departmentId,
      'status': status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      departmentId: map['departmentId'] ?? '',
      status: map['status'] ?? 'pending',
    );
  }
}
