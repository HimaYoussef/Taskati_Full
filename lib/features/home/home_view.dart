import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:projects/core/functions/functions.dart';
import 'package:projects/core/storage/task_model.dart';
import 'package:projects/core/utils/app_colors.dart';
import 'package:projects/core/utils/styles.dart';
import 'package:projects/core/widgets/custom_button.dart';
import 'package:projects/features/create-task/add_task_view.dart';
import 'package:projects/features/create-task/edit_Task.dart';
import 'package:projects/features/home/widgets/home_header.dart';
import 'package:projects/features/home/widgets/task_card_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _selectedDate = DateFormat.yMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const HomeHeaderWidget(),
              const Gap(10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.MMMMEEEEd().format(DateTime.now()),
                        style: getBodyStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        'Today',
                        style: getBodyStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomButton(
                      style: getSmallStyle(color: AppColors.whiteColor),
                      width: 120,
                      text: '+ Add Task',
                      onTap: () {
                        push(context, AddTaskView());
                      }),
                ],
              ),
              const Gap(15),
              DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primaryColor,
                selectedTextColor: Colors.white,
                dateTextStyle: TextStyle().copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                monthTextStyle: TextStyle().copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                dayTextStyle: TextStyle().copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedDate = DateFormat.yMd().format(date);
                  });
                },
              ),
              const Gap(15),
              Expanded(
                  child: ValueListenableBuilder<Box<Task>>(
                valueListenable: Hive.box<Task>('task').listenable(),
                builder: (context, Box<Task> value, child) {
                  List<Task> tasks = [];

                  for (var element in value.values) {
                    if (_selectedDate == element.date) {
                      tasks.add(element);
                    }
                  }
                  if (tasks.isEmpty) {
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/empty.png'),
                            const Gap(20),
                            Text(
                              'No Tasks, Create your task now !!',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ]),
                    );
                  }
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        //
                        Task item = tasks[index];
                        //
                        return Dismissible(
                            key: UniqueKey(),
                            secondaryBackground: Container(
                              padding: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.redColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: AppColors.whiteColor,
                                  ),
                                  const Gap(10),
                                  Text(
                                    'Delete Task',
                                    style: getSmallStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor),
                                  ),
                                ],
                              ),
                            ),
                            background: Container(
                              padding: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.greenColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: AppColors.whiteColor,
                                  ),
                                  const Gap(10),
                                  Text(
                                    'Complete Task',
                                    style: getSmallStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor),
                                  ),
                                ],
                              ),
                            ),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                value.put(
                                    item.id,
                                    Task(
                                        id: item.id,
                                        title: item.title,
                                        note: item.note,
                                        date: item.date,
                                        startTime: item.startTime,
                                        endTime: item.endTime,
                                        color: item.color,
                                        isComplete: true));
                              } else {
                                value.delete(item.id);
                              }
                            },
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Edit_TaskView(model: item),
                                    ),
                                  );
                                },
                                child: TaskCardItem(model: item)));
                      },
                      separatorBuilder: (context, index) => const Gap(10),
                      itemCount: tasks.length);
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
