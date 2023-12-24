import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:projects/core/functions/functions.dart';
import 'package:projects/core/storage/task_model.dart';
import 'package:projects/core/utils/app_colors.dart';
import 'package:projects/core/utils/styles.dart';
import 'package:projects/core/widgets/custom_button.dart';
import 'package:projects/features/create-task/widgets/custom_text_form.dart';
import 'package:projects/features/home/home_view.dart';

class Edit_TaskView extends StatefulWidget {
  const Edit_TaskView({super.key, required this.model});
  final Task model;
  @override
  State<Edit_TaskView> createState() => _Edit_TaskViewState();
}

class _Edit_TaskViewState extends State<Edit_TaskView> {
  var titleCon;
  var noteCon;
  var formKey = GlobalKey<FormState>();
  String date = DateFormat.yMd().format(DateTime.now());
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)));
  int colorIndex = 0;

  late Box<Task> box;
  @override
  void initState() {
    super.initState();
    titleCon = TextEditingController(text: widget.model.title);
    noteCon = TextEditingController(text: widget.model.note);
    box = Hive.box<Task>('task');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryColor,
            )),
        centerTitle: true,
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextForm(
                con: titleCon,
                name: 'Title',
                lines: 1,
              ),
              const Gap(10),
              CustomTextForm(
                con: noteCon,
                name: 'Note',
                lines: 4,
              ),
              const Gap(10),
              Text(
                'Date',
                style: getBodyStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Gap(5),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                    hintStyle:
                        getBodyStyle(color: Theme.of(context).primaryColor),
                    hintText: date,
                    suffixIcon: IconButton(
                        onPressed: () {
                          showDateDialog();
                        },
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.primaryColor,
                        ))),
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Start Time',
                      style: getBodyStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      'End Time',
                      style: getBodyStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(5),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                          hintStyle: getBodyStyle(
                              color: Theme.of(context).primaryColor),
                          hintText: startTime,
                          suffixIcon: IconButton(
                              onPressed: () {
                                shawStartTimeDialog();
                              },
                              icon: Icon(
                                Icons.watch_later_outlined,
                                color: AppColors.primaryColor,
                              ))),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                          hintStyle: getBodyStyle(
                              color: Theme.of(context).primaryColor),
                          hintText: endTime,
                          suffixIcon: IconButton(
                              onPressed: () {
                                shawEndTimeDialog();
                              },
                              icon: Icon(
                                Icons.watch_later_outlined,
                                color: AppColors.primaryColor,
                              ))),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        colorIndex = 0;
                      });
                    },
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primaryColor,
                        child: ColorItem(
                            isChecked: ((colorIndex == 0) ? true : false),
                            color: AppColors.primaryColor)),
                  ),
                  const Gap(5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        colorIndex = 1;
                      });
                    },
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.orangeColor,
                        child: ColorItem(
                            isChecked: ((colorIndex == 1) ? true : false),
                            color: AppColors.orangeColor)),
                  ),
                  const Gap(5),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          colorIndex = 2;
                        });
                      },
                      child: ColorItem(
                          isChecked: ((colorIndex == 2) ? true : false),
                          color: AppColors.redColor)),
                  const Spacer(),
                  CustomButton(
                      style: getSmallStyle(color: AppColors.whiteColor),
                      width: 120,
                      text: 'Edit Task',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await box
                              .put(
                                  widget.model.id,
                                  Task(
                                      id: widget.model.id,
                                      title: titleCon.text,
                                      note: noteCon.text,
                                      date: date,
                                      startTime: startTime,
                                      endTime: endTime,
                                      color: colorIndex,
                                      isComplete: false))
                              .then((value) {
                            pushWithReplacment(context, const HomeView());
                          });
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDateDialog() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      initialDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (datePicked != null) {
      setState(() {
        date = DateFormat.yMd().format(datePicked);
      });
    }
  }

  shawStartTimeDialog() async {
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedStartTime != null) {
      setState(() {
        startTime = pickedStartTime.format(context);
        endTime = pickedStartTime
            .replacing(minute: pickedStartTime.minute + 15)
            .format(context);
      });
    }
  }

  shawEndTimeDialog() async {
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedStartTime != null) {
      setState(() {
        endTime = pickedStartTime.format(context);
      });
    }
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({
    super.key,
    required this.isChecked,
    required this.color,
  });
  final bool isChecked;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: color,
      child: (isChecked)
          ? Icon(Icons.check, color: AppColors.whiteColor)
          : const SizedBox(),
    );
  }
}
