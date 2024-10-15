import 'package:flutter/material.dart';
import 'package:hive_database/view/style/colors_manager.dart';
import 'package:hive_database/view/widgets/Words_widget.dart';
import 'package:hive_database/view/widgets/add_word_dialog.dart';
import 'package:hive_database/view/widgets/filter_dialog_button.dart';
import 'package:hive_database/view/widgets/language_filter_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _getFloatingActionButton(context),
      appBar: AppBar(title: const Text("Home" ,style: TextStyle(color: Colors.white),),),
      body: const Column(
        children: [
          Row(children: [

                LanguageFilterWidget(),
                // SizedBox(width: 200,),
                Spacer(),
                FilterDialogButton()

          ],),
          SizedBox(height: 15,),
          Expanded(child: WordsWidget()),
       
      ],)
    );
  }

  FloatingActionButton _getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorManager.white,
      child: const Icon(Icons.add ,color: ColorManager.black,),
      onPressed: (){
      showDialog(context: context, builder: (context)=>const AddWordDialog());
    });
  }
}