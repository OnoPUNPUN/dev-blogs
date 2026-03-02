import 'package:clean_architecture_project/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({required super.email, required super.id, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    if (map['id'] == null || (map['id'] as String).isEmpty) {
      throw FormatException('User id is required');
    }
    return UserModel(
      email: map['email'] as String? ?? '',
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
    );
  }

  UserModel copyWith({String? email, String? id, String? name}) {
    return UserModel(
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
