import 'package:flutter/material.dart';
import 'package:hive_database/view/style/colors_manager.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({super.key ,required this.icon , required this.message});
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(

      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 200,),
      Icon(icon , color: ColorManager.white , size: 60,),
      SizedBox(height: 15,),
      Text(
        
        message ,
        textAlign: TextAlign.center,
        style: TextStyle(color: ColorManager.white ,fontSize: 22 ,),)
    ],);
  }
}