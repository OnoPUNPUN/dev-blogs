import 'package:clean_architecture_project/core/helpers/exceptions.dart';
import 'package:clean_architecture_project/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:clean_architecture_project/features/blog/data/datasources/blog_local_database.dart';
import 'package:clean_architecture_project/features/blog/data/models/blog_local_model.dart';
import 'package:clean_architecture_project/features/blog/data/models/blog_model.dart';
import 'package:sqflite/sqflite.dart';

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Database database;

  BlogLocalDataSourceImpl({required this.database});

  @override
  Future<void> cacheBlog(BlogModel blog) async {
    try {
      await database.insert(
        BlogLocalDatabase.blogTable,
        BlogLocalModel.fromBlogModel(blog).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ServerExceptions('Failed to cache blog locally');
    }
  }

  @override
  Future<void> cacheBlogs(List<BlogModel> blogs) async {
    try {
      await database.transaction((txn) async {
        await txn.delete(BlogLocalDatabase.blogTable);

        final batch = txn.batch();
        for (final blog in blogs) {
          batch.insert(
            BlogLocalDatabase.blogTable,
            BlogLocalModel.fromBlogModel(blog).toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        await batch.commit(noResult: true);
      });
    } catch (e) {
      throw ServerExceptions('Failed to cache blogs locally');
    }
  }

  @override
  Future<List<BlogModel>> getCachedBlogs() async {
    try {
      final blogMaps = await database.query(
        BlogLocalDatabase.blogTable,
        orderBy: 'updated_at DESC',
      );

      return blogMaps.map(BlogLocalModel.fromMap).toList();
    } catch (e) {
      throw ServerExceptions('Failed to load cached blogs');
    }
  }
}
