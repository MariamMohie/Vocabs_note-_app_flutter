import 'package:flutter/material.dart';
import 'package:hive_database/view/style/colors_manager.dart';

class WordInfoWidget extends StatelessWidget {
  const WordInfoWidget(
      {super.key,
      required this.color,
      required this.isArabic,
      required this.text,  
       this.onPressed       
      });
  final Color color;
  final String text;
  final bool isArabic;
  final  VoidCallback?  onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getBoxDecoration(),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: ColorManager.black,
            radius: 25,
            child: Text(
              isArabic ? "ar" : "en",
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            
          ),
        ),
        const SizedBox(width: 15,),
        Expanded(child: Text(
          text ,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
        if(onPressed != null)  
        IconButton(onPressed: onPressed, icon: const Icon(Icons.delete , color: ColorManager.black, size: 30,))
      ]),
    );
  }

  BoxDecoration _getBoxDecoration() =>
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(10));
}
