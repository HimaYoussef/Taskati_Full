import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/core/functions/functions.dart';
import 'package:projects/core/storage/local_storage.dart';
import 'package:projects/core/utils/app_colors.dart';
import 'package:projects/core/widgets/custom_button.dart';
import 'package:projects/features/home/home_view.dart';

String? imagePath;
String name = '';

class UploadView extends StatefulWidget {
  const UploadView({super.key});

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (imagePath != null && name.isNotEmpty) {
                  AppLocalStorage.cacheData(AppLocalStorage.IS_UPLOAD, true);
                  AppLocalStorage.cacheData(
                      AppLocalStorage.Image_Key, imagePath!);
                  AppLocalStorage.cacheData(AppLocalStorage.Name_Key, name);
                  pushWithReplacment(context, const HomeView());
                } else if (imagePath != null && name.isEmpty) {
                  showErrorWidget(context, 'Please Enter Your Name');
                } else if (imagePath == null && name.isNotEmpty) {
                  showErrorWidget(context, 'Please Enter Your Image');
                } else {
                  showErrorWidget(
                      context, 'Please Enter Your Name and Your Image');
                }
              },
              child: const Text('Done'))
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primaryColor,
              backgroundImage: (imagePath != null)
                  ? FileImage(File(imagePath!)) as ImageProvider
                  : const AssetImage('assets/user.png'),
            ),
            const Gap(20),
            CustomButton(
              text: 'Upload from Camera',
              width: 260,
              onTap: () {
                getImageFromCamera();
              },
            ),
            const Gap(10),
            CustomButton(
              text: 'Upload from Gallery',
              width: 260,
              onTap: () {
                getImageFromGallery();
              },
            ),
            const Gap(10),
            const Divider(),
            const Gap(10),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Your Name',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.primaryColor)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.redColor)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.redColor)),
              ),
            ),
          ],
        ),
      )),
    );
  }

  getImageFromCamera() async {
    final PickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (PickedImage != null) {
      AppLocalStorage.cacheData(AppLocalStorage.Image_Key, PickedImage.path);
      setState(() {
        imagePath = PickedImage.path;
      });
    }
  }

  getImageFromGallery() async {
    final PickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedImage != null) {
      AppLocalStorage.cacheData(AppLocalStorage.Image_Key, PickedImage.path);
      setState(() {
        imagePath = PickedImage.path;
      });
    }
  }
}
