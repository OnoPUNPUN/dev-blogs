import 'dart:io';

import 'package:clean_architecture_project/core/helpers/exceptions.dart';
import 'package:clean_architecture_project/core/helpers/failures.dart';
import 'package:clean_architecture_project/core/network/connection_checker.dart';
import 'package:clean_architecture_project/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:clean_architecture_project/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:clean_architecture_project/features/blog/data/models/blog_model.dart';
import 'package:clean_architecture_project/features/blog/domain/entities/blog.dart';
import 'package:clean_architecture_project/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl({
    required this.blogRemoteDataSource,
    required this.blogLocalDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String userId,
    required List<String> topics,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure('No Internet Connection'));
      }

      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        userId: userId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final iamgeUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: iamgeUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      await _cacheBlogSafely(uploadedBlog);

      return right(uploadedBlog);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await connectionChecker.isConnected) {
        return _getBlogsFromCache(
          fallbackMessage: 'No Internet Connection and no cached blogs found',
        );
      }

      final blogs = await blogRemoteDataSource.getAllBlogs();
      await _cacheBlogsSafely(blogs);
      return right(blogs);
    } on ServerExceptions catch (e) {
      final cachedBlogs = await _getBlogsFromCache(fallbackMessage: e.message);

      return cachedBlogs;
    }
  }

  Future<Either<Failure, List<Blog>>> _getBlogsFromCache({
    required String fallbackMessage,
  }) async {
    try {
      final cachedBlogs = await blogLocalDataSource.getCachedBlogs();

      if (cachedBlogs.isEmpty) {
        return left(Failure(fallbackMessage));
      }

      return right(cachedBlogs);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<void> _cacheBlogSafely(BlogModel blog) async {
    try {
      await blogLocalDataSource.cacheBlog(blog);
    } on ServerExceptions {
      // Remote success is more important than cache refresh failure.
    }
  }

  Future<void> _cacheBlogsSafely(List<BlogModel> blogs) async {
    try {
      await blogLocalDataSource.cacheBlogs(blogs);
    } on ServerExceptions {
      // Showing fresh remote data is still better than failing the whole request.
    }
  }
}
