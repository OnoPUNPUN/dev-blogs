import 'package:clean_architecture_project/core/theme/app_pallete.dart';
import 'package:clean_architecture_project/core/utils/calculate_reading_time.dart';
import 'package:clean_architecture_project/core/utils/formate_date.dart';
import 'package:clean_architecture_project/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));
  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Gap(20),
                Text(
                  'By ${blog.userName}',
                  style: TextStyle(fontWeight: .w500, fontSize: 14),
                ),
                Gap(5),
                Text(
                  '${formateDate(blog.updatedAt)}. ${clculateReadingTime(blog.content)} min',
                  style: TextStyle(
                    color: AppPallete.greyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Gap(20),
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16),
                  child: Image.network(blog.imageUrl),
                ),
                Gap(20),
                Text(blog.content, style: TextStyle(fontSize: 14, height: 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
