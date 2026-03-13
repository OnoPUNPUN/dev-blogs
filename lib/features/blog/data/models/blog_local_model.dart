import 'dart:convert';

import 'package:clean_architecture_project/features/blog/data/models/blog_model.dart';

class BlogLocalModel extends BlogModel {
  BlogLocalModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
    super.userName,
  });

  factory BlogLocalModel.fromBlogModel(BlogModel blog) {
    return BlogLocalModel(
      id: blog.id,
      userId: blog.userId,
      title: blog.title,
      content: blog.content,
      imageUrl: blog.imageUrl,
      topics: blog.topics,
      updatedAt: blog.updatedAt,
      userName: blog.userName,
    );
  }

  factory BlogLocalModel.fromMap(Map<String, dynamic> map) {
    return BlogLocalModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      topics: List<String>.from(jsonDecode(map['topics'] as String) as List),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      userName: map['user_name'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': jsonEncode(topics),
      'updated_at': updatedAt.toIso8601String(),
      'user_name': userName,
    };
  }
}
