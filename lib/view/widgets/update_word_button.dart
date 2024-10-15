import 'package:flutter/material.dart';
import 'package:hive_database/view/style/colors_manager.dart';

class UpdateWordButton extends StatelessWidget {
 UpdateWordButton({super.key , required this.color ,required this.onTap});
  Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 60,
          height: 40,
          decoration: _getButtonDecoration(color),
          child: const Icon(Icons.add , color: ColorManager.black, size: 30,),
        ),
      ),
    );
  }

  BoxDecoration _getButtonDecoration(Color color) => 
  BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: color
  );

}