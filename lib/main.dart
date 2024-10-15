import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_database/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:hive_database/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:hive_database/core/constants/hive_constants.dart';
import 'package:hive_database/model/word_type_adapter.dart';
import 'package:hive_database/view/screens/home_screen.dart';
import 'package:hive_database/view/style/theme_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
 await Hive.openBox(HiveConstants.wordsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers:[
        BlocProvider(create: (context)=>  ReadDataCubit()..getWords()),
         BlocProvider(create: (context)=>  WriteDataCubit()),
      ] , child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getThemeData(),
      home: HomeScreen(),
    ));
  }
}

