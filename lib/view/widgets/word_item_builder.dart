import 'package:flutter/material.dart';
import 'package:hive_database/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:hive_database/model/word_model.dart';
import 'package:hive_database/view/screens/Words_details_screen.dart';
import 'package:hive_database/view/style/colors_manager.dart';

class WordItemWidget extends StatelessWidget {
  const WordItemWidget({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WordsDetailsScreen(wordModel: wordModel)))
              .then((value) async=>  Future.delayed(const Duration(seconds: 1))).then((value) => ReadDataCubit.get(context).getWords());
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(wordModel.colorCode),
          ),
          child: Center(
              child: Text(
            wordModel.text,
            style: const TextStyle(
                color: ColorManager.white,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          )),
        ),
      ),
    );
  }
}
