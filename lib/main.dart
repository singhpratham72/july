import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:july/constants/colors.dart';
import 'package:july/constants/textstyles.dart';
import 'package:july/cubit/todo_cubit.dart';
import 'package:july/screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'July',
        theme: ThemeData(
            textTheme: const TextTheme(bodyText2: TextStyles.bodyText),
            colorScheme:
                const ColorScheme.light(primary: ApplicationColors.grey),
            scaffoldBackgroundColor: ApplicationColors.scaffoldGrey,
            fontFamily: GoogleFonts.lato().fontFamily),
        home: const LandingScreen(),
      ),
    );
  }
}
