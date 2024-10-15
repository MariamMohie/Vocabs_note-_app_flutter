import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_database/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:hive_database/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:hive_database/model/word_model.dart';
import 'package:hive_database/view/style/colors_manager.dart';
import 'package:hive_database/view/widgets/Exception_widget.dart';
import 'package:hive_database/view/widgets/update_word_dialog.dart';
import 'package:hive_database/view/widgets/update_word_button.dart';
import 'package:hive_database/view/widgets/word_info_widget.dart';

class WordsDetailsScreen extends StatefulWidget {
  const WordsDetailsScreen({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  State<WordsDetailsScreen> createState() => _WordsDetailsScreenState();
}

class _WordsDetailsScreenState extends State<WordsDetailsScreen> {
   late WordModel _wordModel;

   @override
  void initState() {
    super.initState();
    _wordModel =widget.wordModel;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: BlocBuilder<ReadDataCubit, ReadDataState>(
        builder: (context, state) {
          if(state is ReadDataSuccess){
           int index= state.words.indexWhere((element) => element.indexDB == _wordModel.indexDB);
          _wordModel = state.words[index];
          return _getSuccessBody(context);
          }
          if(state is ReadDataFailed){
            return ExceptionWidget(icon: Icons.error, message: state.message);
          }
           return const Center(child: CircularProgressIndicator(color: ColorManager.white,));
        },
      ),
    );
  }

  ListView _getSuccessBody(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _getLabelText("Word"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: WordInfoWidget(
            color: Color(_wordModel.colorCode),
            text: _wordModel.text,
            isArabic: _wordModel.isArabic,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _getLabelText("Similar Words"),
            ),
            const Spacer(),
            UpdateWordButton(
              color: Color(_wordModel.colorCode),
              onTap: () {
                showDialog(
                    context: context,
                    builder: ((context) => UpdateWordDialogWidget(
                          isExample: false,
                          colorCode: _wordModel.colorCode,
                          indexInDB: _wordModel.indexDB,
                        )));
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        for (int i = 0; i < _wordModel.arabicSimilarWords.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WordInfoWidget(
                onPressed:()=> _deleteArabicSimilarWord(i),
                color: Color(_wordModel.colorCode),
                isArabic: true,
                text: _wordModel.arabicSimilarWords[i]),
          ),
        for (int i = 0; i < _wordModel.englishSimilarWords.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WordInfoWidget(
              onPressed:()=> _deleteEnglishSimilarWord(i),
                color: Color(_wordModel.colorCode),
                isArabic: false,
                text: _wordModel.englishSimilarWords[i]),
          ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _getLabelText("Examples Words"),
            ),
            const Spacer(),
            UpdateWordButton(
              color: Color(_wordModel.colorCode),
              onTap: () {
                showDialog(
                    context: context,
                    builder: ((context) => UpdateWordDialogWidget(
                          isExample: true,
                          colorCode: _wordModel.colorCode,
                          indexInDB: _wordModel.indexDB,
                        )));
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        for (int i = 0; i < _wordModel.arabicExamples.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WordInfoWidget(
              onPressed:()=> _deleteArabicExample(i),
                color: Color(_wordModel.colorCode),
                isArabic: true,
                text: _wordModel.arabicExamples[i]),
          ),
        for (int i = 0; i < _wordModel.englishExamples.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WordInfoWidget(
              onPressed:()=> _deleteEnglishExample(i),
                color: Color(_wordModel.colorCode),
                isArabic: false,
                text: _wordModel.englishExamples[i]),
          ),
      ],
    );
  }

  void _deleteEnglishExample(int index) {
 WriteDataCubit.get(context).deleteExample(
      _wordModel.indexDB,
       index,
      false);
      ReadDataCubit.get(context).getWords();  }

  void _deleteArabicExample(int index) {
    WriteDataCubit.get(context).deleteExample(
      _wordModel.indexDB,
       index,
      true);
        ReadDataCubit.get(context).getWords(); 
  }

  void _deleteEnglishSimilarWord(int index){
    WriteDataCubit.get(context).deleteSimilarWord(
      _wordModel.indexDB,
       index,
      false);
        ReadDataCubit.get(context).getWords(); 
  }

  void _deleteArabicSimilarWord(int index) {
    WriteDataCubit.get(context).deleteSimilarWord(
      _wordModel.indexDB,
       index,
      true);
        ReadDataCubit.get(context).getWords(); 
  }

  Text _getLabelText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Color(_wordModel.colorCode),
          fontWeight: FontWeight.bold,
          fontSize: 22),
    );
  }

  AppBar _getAppBar(context) => AppBar(
        foregroundColor: Color(_wordModel.colorCode),
        title: Text(
          "Word Details",
          style: TextStyle(color: Color(_wordModel.colorCode), fontSize: 27),
        ),
        actions: [
          IconButton(
              onPressed: () => _deleteWord(context),
              icon: const Icon(
                Icons.delete,
                size: 36,
              ))
        ],
      );

  void _deleteWord(BuildContext context) {
    WriteDataCubit.get(context).deleteWord(_wordModel.indexDB);
    Navigator.pop(context);
  }
}
