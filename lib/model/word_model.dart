class WordModel {
  final int indexDB;
  final String text;
  final int colorCode;
  final bool isArabic;
  final List<String> arabicSimilarWords;
  final List<String> englishSimilarWords;
  final List<String> arabicExamples;
  final List<String> englishExamples;

  const WordModel({
    required this.indexDB,
    required this.colorCode,
    required this.text,
    required this.isArabic,
    this.arabicSimilarWords = const [],
    this.englishSimilarWords = const [],
    this.arabicExamples = const [],
    this.englishExamples = const [],
  });
  ////////////////////////////////////////////////////

  //! We will implement some functions that can handel  the updates on objects

  //! 1st part is to add & delete Similar words //

  WordModel addSimilarWords(String similarWord, bool isArabicSimilarWord) {
    //? We created it to make a list as a copy of the final list but with new modifications
    List<String> newSimilarWords =
        _intializeNewSimilarWords(isArabicSimilarWord);

    newSimilarWords.add(similarWord);

    return _getWordAfterCheckSimilarWords(newSimilarWords, isArabicSimilarWord);
  }
  //////////////////////////////////////////////////////////////

  WordModel deleteSimilarWord(bool isArabicSimilarWord, int indexDB) {
    List<String> newSimilarWords =
        _intializeNewSimilarWords(isArabicSimilarWord);
    newSimilarWords.removeAt(indexDB);
    return _getWordAfterCheckSimilarWords(newSimilarWords, isArabicSimilarWord);
  }
  //////////////////////////////////////////////////////////////

  //!  2nd part is to Add & delete Examples//

  WordModel addExample(bool isArabicExample, String example) {
    List<String> newExample = _intializeNewExample(isArabicExample);
    newExample.add(example);
    return _getWordAfterCheckExample(newExample, isArabicExample);
  }

  WordModel deleteExample(bool isArabicExample, int indexDB) {
    List<String> newExample = _intializeNewExample(isArabicExample);
    newExample.removeAt(indexDB);
    return _getWordAfterCheckExample(newExample, isArabicExample);
  }

  //! Private Functions to ease implementation//

/////////////////////////////////////////////////////////////////
  ///
  List<String> _intializeNewSimilarWords(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      // we didn't do that cuz  = is like a ref ,So newSimilarWords is the same like  arabicSimilarWords
      // so ,both of them now are final So, it can't be modified
      //*  newSimilarWords= arabicSimilarWords;
      // to solve this

      //! we use from to just take the value in the list as a value not a ref
      return List.from(arabicSimilarWords);
    } else {
      return List.from(englishSimilarWords);
    }
  }

  //////////////////////////////////////////////////////////
  List<String> _intializeNewExample(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      //! we use from to just take the value in the list as a value not a ref
      return List.from(arabicExamples);
    }
    return List.from(englishExamples);
  }
  ////////////////////////////////////////////////////////

  WordModel _getWordAfterCheckSimilarWords(
      List<String> newSimilarWords, bool isArabicSimilarWord) {
    return WordModel(
      indexDB: indexDB,
      colorCode: colorCode,
      text: text,
      isArabic: isArabic,
      arabicExamples: arabicExamples,
      englishExamples: englishExamples,
      arabicSimilarWords:
          isArabicSimilarWord ? newSimilarWords : arabicSimilarWords,
      englishSimilarWords:
          !isArabicSimilarWord ? newSimilarWords : englishSimilarWords,
    );
  }

  WordModel _getWordAfterCheckExample(
      List<String> newExample, bool isArabicExample) {
    return WordModel(
        indexDB: indexDB,
        colorCode: colorCode,
        text: text,
        isArabic: isArabic,
        arabicExamples: isArabicExample ? newExample : arabicExamples,
        englishExamples: !isArabicExample ? newExample : englishExamples,
        arabicSimilarWords: arabicSimilarWords,
        englishSimilarWords: englishSimilarWords);
  }

  WordModel decrementIndexDB() {
    return WordModel(
        indexDB: indexDB - 1,
        colorCode: colorCode,
        text: text,
        isArabic: isArabic,
        arabicSimilarWords: arabicSimilarWords,
        englishSimilarWords: englishSimilarWords,
        englishExamples: englishExamples,
        arabicExamples: arabicExamples);
  }
}
