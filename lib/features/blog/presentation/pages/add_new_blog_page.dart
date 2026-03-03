import 'package:clean_architecture_project/features/blog/presentation/widgets/blog_editor.dart';
import 'package:clean_architecture_project/features/blog/presentation/widgets/blog_topic_filter.dart';
import 'package:clean_architecture_project/features/blog/presentation/widgets/select_image_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleTEController = TextEditingController();
  final contentTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SelectImageContainer(),
              const Gap(20),
              BlogTopicFilter(),
              const Gap(20),
              BlogEditor(controller: titleTEController, hintText: 'Blog title'),
              const Gap(10),
              BlogEditor(
                controller: contentTEController,
                hintText: 'Blog Content',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleTEController.dispose();
    contentTEController.dispose();
  }
}
