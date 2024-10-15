import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_database/view/style/colors_manager.dart';

class DoneButtonWidget extends StatelessWidget {
  const DoneButtonWidget({super.key , required this.onTap ,required this.colorCode});
  final int colorCode;
  final VoidCallback onTap ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 83,
          height: 50,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10),
        
          ),
         child: Center(child: Text("Done", style: TextStyle(color: Color(colorCode), fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }
}