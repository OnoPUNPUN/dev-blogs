import 'package:clean_architecture_project/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

enum BlogTopic {
  tech('Technology'),
  business('Business'),
  programming('Programing'),
  entertainment('Entertainment');

  const BlogTopic(this.label);
  final String label;
}

class BlogTopicFilter extends StatefulWidget {
  const BlogTopicFilter({super.key});

  @override
  State<BlogTopicFilter> createState() => _BlogTopicFilterState();
}

class _BlogTopicFilterState extends State<BlogTopicFilter> {
  List<String> selectedTopics = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: BlogTopic.values
            .map(
              (topic) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    if (selectedTopics.contains(topic.label)) {
                      selectedTopics.remove(topic.label);
                    } else {
                      selectedTopics.add(topic.label);
                    }
                    setState(() {});
                  },
                  child: Chip(
                    label: Text(topic.label),
                    color: WidgetStateProperty.all(
                      selectedTopics.contains(topic.label)
                          ? AppPallete.gradient1
                          : null,
                    ),
                    side: selectedTopics.contains(topic.label)
                        ? null
                        : BorderSide(color: AppPallete.borderColor),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
