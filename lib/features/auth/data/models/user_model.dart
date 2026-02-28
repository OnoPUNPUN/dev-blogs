import 'package:clean_architecture_project/features/auth/domain/entities/user.dart';

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
}
