import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_database/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:hive_database/view/style/colors_manager.dart';

class LanguageFilterWidget extends StatelessWidget {
  const LanguageFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            _mapLanguageFilterToString(ReadDataCubit.get(context).languageFilter),
            style: const TextStyle(color: ColorManager.white ,
            fontWeight: FontWeight.bold ,
             fontSize: 27 ),
            
            ),
        );
      },
    );
  }


  String _mapLanguageFilterToString(LanguageFilter languageFilter){
    if(languageFilter == LanguageFilter.allWords){
      return "All Words";
    }else if(languageFilter == LanguageFilter.englishOnly){
      return "English Only";
    }
    return "Arabic Only";
  }
}
