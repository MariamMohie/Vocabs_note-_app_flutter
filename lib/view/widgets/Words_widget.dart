import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_database/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:hive_database/model/word_model.dart';
import 'package:hive_database/view/style/colors_manager.dart';
import 'package:hive_database/view/widgets/Exception_widget.dart';
import 'package:hive_database/view/widgets/word_item_builder.dart';

class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
        builder: ((context, state) {
      // in success state it has 2 options --> 1-success,but, no words  2-success with words returned
      if (state is ReadDataSuccess) {
        if (state.words.isEmpty) {
          return _getEmptyWordsWidget();
        }
        return _getWordsWidget(state.words);
        // failed state
      } else if (state is ReadDataFailed) {
        return _getFailedWidget(state.message);
      }
      // Loading state
      else {
        return _getLoadingWidget();
      }
    }));
  }

  Widget _getWordsWidget(List<WordModel> word) {
    return GridView.builder(
        itemCount: word.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 2 / 1.5,
            crossAxisCount: 2),
        itemBuilder: ((context, index) {
          return WordItemWidget(wordModel: word[index]);
        }));
  }

  Widget _getEmptyWordsWidget() {
    return const ExceptionWidget(
        icon: Icons.list_rounded, message: "Empty Words List");
  }

  Widget _getFailedWidget(String message) {
    return ExceptionWidget(icon: Icons.error, message: message);
  }

  Widget _getLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorManager.white,
      ),
    );
  }
}
