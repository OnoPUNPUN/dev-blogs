part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

final class BlogInitialState extends BlogState {}

final class BlogLoadingState extends BlogState {}

final class BlogFailureState extends BlogState {
  final String error;
  const BlogFailureState(this.error);
}

final class BlogUploadSuccessState extends BlogState {}

final class BlogDisplaySuccessState extends BlogState {
  final List<Blog> blogs;

  const BlogDisplaySuccessState(this.blogs);
}
