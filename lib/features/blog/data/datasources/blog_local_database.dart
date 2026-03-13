import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class BlogLocalDatabase {
  static const databaseName = 'blog_cache.db';
  static const databaseVersion = 1;
  static const blogTable = 'blogs';

  static Future<Database> initialize() async {
    final databasesPath = await getDatabasesPath();
    final databasePath = path.join(databasesPath, databaseName);

    return openDatabase(
      databasePath,
      version: databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $blogTable (
            id TEXT PRIMARY KEY,
            user_id TEXT NOT NULL,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            image_url TEXT NOT NULL,
            topics TEXT NOT NULL,
            updated_at TEXT NOT NULL,
            user_name TEXT
          )
        ''');
      },
    );
  }
}
