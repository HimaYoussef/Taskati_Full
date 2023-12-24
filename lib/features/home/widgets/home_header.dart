import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projects/core/storage/local_storage.dart';
import 'package:projects/core/utils/app_colors.dart';
import 'package:projects/core/utils/styles.dart';
import 'package:projects/features/Profile/Profile_view.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({super.key});

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: AppLocalStorage.getData(AppLocalStorage.Name_Key),
              builder: (context, snapshot) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfileView()));
                  },
                  child: Text('Hello ,${snapshot.data}',
                      style: getTitleStyle(
                          color: AppColors.primaryColor, fontSize: 18)),
                );
              },
            ),
            Text(
              'Have a nice day',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfileView()));
          },
          child: FutureBuilder(
              future: AppLocalStorage.getData(AppLocalStorage.Image_Key),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primaryColor,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: FileImage(File(snapshot.data!)),
                    ),
                  );
                } else {
                  return CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primaryColor,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/user.png'),
                    ),
                  );
                }
              }),
        )
      ],
    );
  }
}
