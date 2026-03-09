import 'dart:io';

import 'package:clean_architecture_project/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean_architecture_project/core/common/widgets/loader.dart';
import 'package:clean_architecture_project/core/utils/show_snackbar.dart';
import 'package:clean_architecture_project/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:clean_architecture_project/features/blog/presentation/pages/blog_page.dart';
import 'package:clean_architecture_project/features/blog/presentation/widgets/blog_editor.dart';
import 'package:clean_architecture_project/features/blog/presentation/widgets/blog_topic_filter.dart';
import 'package:clean_architecture_project/features/blog/presentation/widgets/select_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  File? selectedImage;
  List<String> selectedTopics = [];

  final _fromKey = GlobalKey<FormState>();

  void uploadBlog() {
    final isFormValid = _fromKey.currentState!.validate();
    if (!isFormValid) return;

    if (selectedImage == null) {
      showSnackbar(context, 'Please select an image');
      return;
    }

    if (selectedTopics.isEmpty) {
      showSnackbar(context, 'Please select at least one topic');
      return;
    }

    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedInState).user.id;
    context.read<BlogBloc>().add(
      BlogUpload(
        userId: userId,
        title: titleTEController.text.trim(),
        content: contentTEController.text.trim(),
        image: selectedImage!,
        topics: selectedTopics,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              uploadBlog();
            },
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailureState) {
              showSnackbar(context, state.error);
            } else if (state is BlogSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                BlogPage.route(),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is BlogLoadingState) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Form(
                key: _fromKey,
                child: Column(
                  children: [
                    SelectImageContainer(
                      selectedImage: selectedImage,
                      onImageSelected: (image) {
                        setState(() {
                          selectedImage = image;
                        });
                      },
                    ),
                    const Gap(20),
                    BlogTopicFilter(
                      selectedTopics: selectedTopics,
                      onChanged: (topics) {
                        setState(() {
                          selectedTopics = topics;
                        });
                      },
                    ),
                    const Gap(20),
                    BlogEditor(
                      controller: titleTEController,
                      hintText: 'Blog title',
                    ),
                    const Gap(10),
                    BlogEditor(
                      controller: contentTEController,
                      hintText: 'Blog Content',
                    ),
                  ],
                ),
              ),
            );
          },
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
