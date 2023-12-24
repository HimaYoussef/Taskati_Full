import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projects/core/utils/styles.dart';

class CustomTextForm extends StatefulWidget {
  const CustomTextForm(
      {super.key,  required this.con, required this.name, required this.lines});
  final TextEditingController con;
  final String name;
  final int lines;
  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: getBodyStyle(color: Theme.of(context).primaryColor,),
        ),
        const Gap(5),
        TextFormField(
          style: getBodyStyle(color: Theme.of(context).primaryColor),
          controller: widget.con,
          maxLines: widget.lines,
          validator: (value) {
            if (value!.isEmpty) {
              return '${widget.name} is required*';
            }

            return null;
          },
          decoration: InputDecoration(hintText: 'Enter ${widget.name} Here'),
        ),
      ],
    );
  }
}
