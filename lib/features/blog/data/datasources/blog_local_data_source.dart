import 'package:clean_architecture_project/features/blog/data/models/blog_model.dart';

abstract interface class BlogLocalDataSource {
  Future<void> cacheBlogs(List<BlogModel> blogs);

  Future<void> cacheBlog(BlogModel blog);

  Future<List<BlogModel>> getCachedBlogs();
}
