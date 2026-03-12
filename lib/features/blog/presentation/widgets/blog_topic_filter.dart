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
  final ValueChanged<List<String>>? onChanged;
  final bool isReadOnly;

  const BlogTopicFilter({
    super.key,
    required this.selectedTopics,
    this.onChanged,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final topicsToShow = isReadOnly
        ? selectedTopics
        : BlogTopic.values.map((topic) => topic.label).toList();

    if (topicsToShow.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: topicsToShow
            .map(
              (topicLabel) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: isReadOnly || onChanged == null
                      ? null
                      : () {
                          final updatedTopics = List<String>.from(
                            selectedTopics,
                          );

                          if (updatedTopics.contains(topicLabel)) {
                            updatedTopics.remove(topicLabel);
                          } else {
                            updatedTopics.add(topicLabel);
                          }

                          onChanged!(updatedTopics);
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isReadOnly
                          ? AppPallete.backgroundColor
                          : selectedTopics.contains(topicLabel)
                          ? AppPallete.gradient1
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: selectedTopics.contains(topicLabel)
                          ? null
                          : Border.all(color: AppPallete.borderColor),
                    ),
                    child: Text(
                      topicLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
