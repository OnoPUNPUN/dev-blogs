import 'dart:io';

import 'package:clean_architecture_project/core/helpers/exceptions.dart';
import 'package:clean_architecture_project/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:clean_architecture_project/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blog.toJson())
          .select();

      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);

      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
