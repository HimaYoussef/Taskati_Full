import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:projects/core/storage/local_storage.dart';
import 'package:projects/core/utils/app_colors.dart';
import 'package:projects/core/utils/styles.dart';
import 'package:projects/features/home/home_view.dart';
import 'package:projects/features/upload/upload_view.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool? isUpload;
  @override
  void initState() {
    super.initState();

    AppLocalStorage.getData(AppLocalStorage.IS_UPLOAD).then((value) {
      isUpload = value ?? false;
    });
    // delay by 4 sec and navigate to upload
    Future.delayed(const Duration(seconds: 4), () {
      // navigation
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => isUpload! ? const HomeView() : const UploadView(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/logo.json', width: 250),
          const Gap(10),
          Text(
            'Taskati',
            style: getTitleStyle(color: Theme.of(context).primaryColor,),
          ),
          const Gap(10),
          Text('It\'s time to be organized',
              style: getSmallStyle(color: AppColors.greyColor)),
        ],
      )),
    );
  }
}
