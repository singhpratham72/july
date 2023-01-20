import 'package:flutter/material.dart';
import 'package:july/constants/colors.dart';
import 'package:july/constants/textstyles.dart';

class NewTaskTextField extends StatelessWidget {
  const NewTaskTextField({
    required this.callback,
    Key? key,
  }) : super(key: key);

  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.0,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ApplicationColors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.1),
              spreadRadius: 0.0,
              blurRadius: 4.5,
              offset: const Offset(0, 2.5))
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 18.0,
            width: 18.0,
            decoration: BoxDecoration(
                color: ApplicationColors.darkGrey,
                borderRadius: BorderRadius.circular(4.0)),
          ),
          const SizedBox(width: 8.0),
          Expanded(
              child: TextField(
            onSubmitted: (value) {
              callback(value);
            },
            autofocus: true,
            decoration: InputDecoration.collapsed(
              hintText: 'Write a new task',
              hintStyle:
                  TextStyles.bodyText.copyWith(color: ApplicationColors.grey),
            ),
          )),
        ],
      ),
    );
  }
}
