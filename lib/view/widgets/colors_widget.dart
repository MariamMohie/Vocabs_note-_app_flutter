import 'package:flutter/material.dart';
import 'package:hive_database/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:hive_database/view/style/colors_manager.dart';

class ColorsWidget extends StatelessWidget {
  ColorsWidget({super.key, required this.activeColorCode});
  final int activeColorCode;
  final List<int> colorsCodes = [
    0XFF4A47A3,
    0XFF0C7B93,
    0XFF892CDC,
    0XFFBC6FF1,
    0XFFF4ABC4,
    0XFFC70039,
    0XFF8FBC8F,
    0XFFFA8072,
    0XFF4D4C7D  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index) =>_getItemDesign(index, context),
        separatorBuilder: (context,index)=> const SizedBox(width: 10,),
        itemCount: colorsCodes.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
  Widget _getItemDesign( int index , BuildContext context){
    return InkWell(
      onTap: () {
        WriteDataCubit.get(context).updateColorCode(colorsCodes[index]);
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(colorsCodes[index]),
          border: activeColorCode==colorsCodes[index]? Border.all(color: Colors.white , width: 2):null,
        ),
        child:  activeColorCode==colorsCodes[index]?const Icon(Icons.done,color: ColorManager.white,):null,
      ),
    );
  }
}