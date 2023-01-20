import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:july/constants/colors.dart';
import 'package:july/constants/fonts.dart';
import 'package:july/constants/textstyles.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    TimeOfDay now = TimeOfDay.now();
    String stringDate =
        DateFormat('EEEEEE, MMM dd', 'en_US').format(DateTime.now());
    String period = "evening";
    if (now.hour >= 4 && now.hour < 12) {
      period = "morning";
    } else if (now.hour >= 12 && now.hour < 16) {
      period = "afternoon";
    }
    return GestureDetector(
      onTap: () {
        scrollController.animateTo(0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn);
      },
      child: RichText(
        text: TextSpan(
          text: 'Good $period!\n',
          style: TextStyles.h1,
          children: [
            TextSpan(
                text: 'It\u2019s $stringDate',
                style: TextStyles.h1.copyWith(
                    color: ApplicationColors.lightGrey,
                    fontWeight: Weight.light)),
          ],
        ),
      ),
    );
  }
}
