import 'package:flutter/material.dart';
import 'package:hive_database/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:hive_database/view/style/colors_manager.dart';

class ArabicOrEnglishWidget extends StatelessWidget {
  const ArabicOrEnglishWidget({super.key , required this.arabicIsSelected, required this.colorCode});
  final int colorCode;
  final bool arabicIsSelected;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        _getContainerDesign(true, context),
        SizedBox(width: 10,),
         _getContainerDesign(false, context)
      ],
     );
  }

  InkWell _getContainerDesign(bool buildIsArabic ,BuildContext context ) {
    return InkWell(
      onTap: () {
        WriteDataCubit.get(context).updateIsArabic(buildIsArabic);
      },
      child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:buildIsArabic == arabicIsSelected ?
             ColorManager.white: Color(colorCode),
             border: Border.all(color: ColorManager.white, width: 2
            )
          ),
          child: Center(child: 
          Text(
         buildIsArabic? "ar":"en",
           style:  TextStyle(
            color:!(buildIsArabic == arabicIsSelected) ?
             ColorManager.white: Color(colorCode),
           fontWeight: FontWeight.bold, fontSize: 17),)),
        ),
    );
  }
}