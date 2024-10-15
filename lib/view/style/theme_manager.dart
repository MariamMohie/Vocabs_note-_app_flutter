import 'package:flutter/material.dart';
import 'package:hive_database/view/style/colors_manager.dart';

abstract class ThemeManager{

  static ThemeData getThemeData(){
     return ThemeData(
      scaffoldBackgroundColor: ColorManager.black,
      appBarTheme: const AppBarTheme(
        color: ColorManager.black,
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold ,fontSize: 30)
      )


     );
  }
}