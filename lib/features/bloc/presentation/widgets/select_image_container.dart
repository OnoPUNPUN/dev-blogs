import 'dart:io';
import 'package:clean_architecture_project/core/theme/app_pallete.dart';
import 'package:clean_architecture_project/core/utils/pick_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SelectImageContainer extends StatefulWidget {
  const SelectImageContainer({super.key});

  @override
  State<SelectImageContainer> createState() => _SelectImageContainerState();
}

class _SelectImageContainerState extends State<SelectImageContainer> {
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return image != null
        ? GestureDetector(
            onTap: () {
              selectImage();
            },
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Image.file(image!, fit: BoxFit.cover),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              selectImage();
            },
            child: DottedBorder(
              options: CustomPathDottedBorderOptions(
                padding: const EdgeInsets.all(0),
                color: AppPallete.borderColor,
                strokeWidth: 1,
                strokeCap: StrokeCap.round,
                dashPattern: const [10, 4],
                customPath: (size) => Path()
                  ..addRRect(
                    RRect.fromRectAndRadius(
                      Rect.fromLTWH(0, 0, size.width, size.height),
                      const Radius.circular(10),
                    ),
                  ),
              ),
              child: Container(
                height: 150,
                width: .infinity,
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.folder_open, size: 40),
                    Gap(15),
                    Text('Select Your Image', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
          );
  }
}
