import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projects/core/Themes.dart';
import 'package:projects/core/storage/task_model.dart';
import 'package:projects/features/splash_view.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('task');
    await Hive.openBox<bool>('mode');
  await Hive.openBox('user');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<bool>('mode').listenable(),
      builder: (context, value, child) {
        bool darkMode = value.get("darkMode",defaultValue: false)!;
           return MaterialApp(
          themeMode: darkMode ? ThemeMode.dark:ThemeMode.light,
          darkTheme: darkTheme,
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashView());
      }
    );
      }
  }

