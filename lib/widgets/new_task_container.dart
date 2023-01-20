import 'package:flutter/material.dart';
import 'package:july/constants/colors.dart';
import 'package:july/constants/textstyles.dart';

class NewTaskContainer extends StatelessWidget {
  const NewTaskContainer({Key? key, required this.callback}) : super(key: key);

  final Function callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback(true);
      },
      child: Container(
        height: 42.0,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ApplicationColors.darkGrey,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          'Write a new task',
          style: TextStyles.bodyText.copyWith(color: ApplicationColors.grey),
        ),
      ),
    );
  }
}
