import 'package:clean_architecture_project/core/utils/calculate_reading_time.dart';
import 'package:clean_architecture_project/features/blog/domain/entities/blog.dart';
import 'package:clean_architecture_project/features/blog/presentation/widgets/blog_topic_filter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 170),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16).copyWith(bottom: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              BlogTopicFilter(selectedTopics: blog.topics, isReadOnly: true),
              Gap(6),
              Text(
                blog.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text('${clculateReadingTime(blog.content)} min'),
        ],
      ),
    );
  }
}
