part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

final class BlogUpload extends BlogEvent {
  final String userId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  BlogUpload({
    required this.userId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}

final class FetchAllBlogs extends BlogEvent {}
