import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolistapp/feature/splash/presenatation/bloc/splashcubit.dart';
import 'package:todolistapp/feature/splash/presenatation/pages/splash_page.dart';
import 'package:todolistapp/service_locator.dart';

import 'feature/home/data/model/notemodel.dart';

void main() async{
 setuplocator();
 await Hive.initFlutter();
 Hive.registerAdapter(NoteModelAdapter());
 Hive.registerAdapter(TodosAdapter());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create: (context) => SplashCubit()..appStarted(),
      child: SplashPage(),
    ),
  ));
}