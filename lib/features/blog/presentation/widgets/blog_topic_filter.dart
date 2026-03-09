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

class BlogTopicFilter extends StatelessWidget {
  final List<String> selectedTopics;
  final ValueChanged<List<String>> onChanged;

  const BlogTopicFilter({
    super.key,
    required this.selectedTopics,
    required this.onChanged,
  });

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
                    final updatedTopics = List<String>.from(selectedTopics);

                    if (updatedTopics.contains(topic.label)) {
                      updatedTopics.remove(topic.label);
                    } else {
                      updatedTopics.add(topic.label);
                    }

                    onChanged(updatedTopics);
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
