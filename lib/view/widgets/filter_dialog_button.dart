import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_database/view/style/colors_manager.dart';
import 'package:hive_database/view/widgets/filter_dialog_widget.dart';

class FilterDialogButton extends StatelessWidget {
  const FilterDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       showDialog(context: context, builder: ((context) => const FilterDialogWidget()));
      },
      child: const CircleAvatar(
        radius: 20,
        backgroundColor: ColorManager.white,
        child: Icon(CupertinoIcons.line_horizontal_3_decrease),
      ),
    );
  }
}