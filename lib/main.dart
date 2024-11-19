import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistapp/feature/splash/presenatation/bloc/splashcubit.dart';
import 'package:todolistapp/feature/splash/presenatation/pages/splash_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create: (context) => SplashCubit()..appStarted(),
      child: SplashPage(),
    ),
  ));
}