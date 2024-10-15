import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_database/core/constants/hive_constants.dart';
import 'package:hive_database/model/word_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'read_data_state.dart';

class ReadDataCubit extends Cubit<ReadDataState> {
  static ReadDataCubit get(context)=> BlocProvider.of(context);
  ReadDataCubit() : super(ReadDataInitial());


  final Box _box = Hive.box(HiveConstants.wordsBox);

  LanguageFilter languageFilter =LanguageFilter.allWords;
  SortedBy sortedBy =SortedBy.time;
  SortingType sortingType =SortingType.descending;

  //! updates of filter

  void updateLanguageFilter(LanguageFilter languageFilter){
    this.languageFilter =languageFilter;
    getWords();
    
  }
  void updateSortedBy( SortedBy sortedBy){
    this.sortedBy =sortedBy;
    getWords();

  }
  void updateSortingType(SortingType sortingType){
    this.sortingType= sortingType;
    getWords();
  }

  void getWords(){
  
  emit(ReadDataLoading());
  try{

    List<WordModel> wordsListToReturn = List.from(_box.get(HiveConstants.wordsList,defaultValue: [])).cast<WordModel>();
    _removeUnwantedWords(wordsListToReturn);
    _applySorting(wordsListToReturn);
    emit(ReadDataSuccess(words:wordsListToReturn));
  }catch(error){
    emit(ReadDataFailed(message: "We have a problem to get words , please try again!"));

  }
}

void _removeUnwantedWords( List<WordModel> wordsListToReturn){
  if(languageFilter ==LanguageFilter.allWords){
    return;
  }
  for( var i=0 ;i< wordsListToReturn.length ;i++){
       if((languageFilter == LanguageFilter.arabicOnly && wordsListToReturn[i].isArabic==false)||(languageFilter == LanguageFilter.englishOnly && wordsListToReturn[i].isArabic==true)){
          wordsListToReturn.removeAt(i);
          //!why i-- ?
          i--; //?assume that i=2
          //! to decrement the i --> 1 then when I come up to the for it will increase to be 2 again 
          //! and this what we want to do 
          //? 1 2 3-->X 4 5  --> if I removed 3 then i here is 2 after deleting 
          //? it ..in the next iteration I need to check the numbers from the i=2 again cuz num 4 will take the position of the removed number
        
       }
  }


}

void _reverseOrder(List<WordModel> wordsListToReturn){
  for(var i=0 ;i< wordsListToReturn.length/2 ;i++){
          WordModel temp = wordsListToReturn[i];
          wordsListToReturn[i] =wordsListToReturn[wordsListToReturn.length-1-i];
          wordsListToReturn[wordsListToReturn.length-1-i] =temp;
      }
}

void _applySorting(List<WordModel> wordsListToReturn){
  if(sortedBy ==SortedBy.time){
    if(sortingType == SortingType.ascending){
        return; // cuz it come from the list ordered ascending
    }else{
       _reverseOrder(wordsListToReturn);
    }

  }else{
    //? to sort according to the word length
    wordsListToReturn.sort((WordModel a, WordModel b)=> a.text.length.compareTo(b.text.length));
    if(sortingType== SortingType.ascending){
      return;
    }else{
      _reverseOrder(wordsListToReturn);
    }

  }

}

}





enum LanguageFilter{
  arabicOnly,
  englishOnly,
  allWords,
}
enum SortedBy{
  time,
  wordLength,
}
enum SortingType{
  ascending,
  descending
}