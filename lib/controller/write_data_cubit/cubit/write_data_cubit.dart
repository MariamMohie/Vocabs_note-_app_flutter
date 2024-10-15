import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_database/core/constants/hive_constants.dart';
import 'package:hive_database/model/word_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'write_data_state.dart';

class WriteDataCubit extends Cubit<WriteDataState> {
  WriteDataCubit() : super(WriteDataInitial());

  static WriteDataCubit get(context) => BlocProvider.of(context);

  final Box box = Hive.box(HiveConstants.wordsBox);
  String text = "";
  bool isArabic = true;
  int colorCode = 0XFF4A47A3;

  //! 1st fun to update Text

  void updateText(String text) {
    this.text = text;
  }

  void updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
    emit(WriteDataInitial());
  }

  void updateColorCode(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataInitial());
  }

//! fun to add new word
  void addWord() {
    _tryAndCatchBlock(() {
      // get the List exists in the DB to add the word in it
      List<WordModel> words = _getWordsListFromDB();
      // add the new word
      words.add(WordModel(
          indexDB: words.length,
          colorCode: colorCode,
          text: text,
          isArabic: isArabic));
      // add the List after adding new word into DB
      box.put(HiveConstants.wordsList, words);
    }, "We Had a problem when adding the word . Please, try again!");
  }

  //! fun to delete word

  void deleteWord(int indexInDB) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsListFromDB();
      words.removeAt(indexInDB);
      for (var i = indexInDB; i < words.length; i++) {
        words[i] = words[i].decrementIndexDB();
        box.put(HiveConstants.wordsList, words);
      }
    }, "We faced an error while deleting this word , please try again");
  }

  //////////////////////////////////////////////////////////////////////

  //! fun to add Similar words
  void addSimilarWord(int indexInDB) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsListFromDB();
      words[indexInDB] = words[indexInDB].addSimilarWords(text, isArabic);
      box.put(HiveConstants.wordsList, words);
    }, "We Had a problem when adding similar the word . Please, try again!");
  }

  //! fun to add Example
  void addExample(int indexInDB) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsListFromDB();
      words[indexInDB] = words[indexInDB].addExample(isArabic, text);
      box.put(HiveConstants.wordsList, words);
    }, "We Had a problem when adding Example the word . Please, try again!");
  }

  //! fun to delete Similar words
  void deleteSimilarWord(
      int indexInDB, int indexSimilarWord, bool isArabicSimilarWord) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsListFromDB();
      words[indexInDB] = words[indexInDB]
          .deleteSimilarWord(isArabicSimilarWord, indexSimilarWord);
      box.put(HiveConstants.wordsList, words);
    }, "We Had a problem when deleting similar the word . Please, try again!");
  }

  //! fun to delete example
  void deleteExample(int indexInDB, int indexExample, bool isArabicExample) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsListFromDB();
      words[indexInDB] =
          words[indexInDB].deleteExample(isArabicExample, indexExample);
      box.put(HiveConstants.wordsList, words);
    }, "We Had a problem when deleting Example . Please, try again!");
  }
  //////////////////////////////////////////////////////////////

  //! functions to ease my code

  List<WordModel> _getWordsListFromDB() =>
      List.from(box.get(HiveConstants.wordsList, defaultValue: []))
          .cast<WordModel>();

  void _tryAndCatchBlock(VoidCallback methodToExecute, String message) {
    emit(WriteDataLoading());
    try {
      methodToExecute.call();
      emit(WriteDataSuccess());
    } catch (error) {
      emit(WriteDataFailed(message: message));
    }
  }
}
