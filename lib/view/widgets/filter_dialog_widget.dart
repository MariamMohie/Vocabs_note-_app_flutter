import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_database/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:hive_database/view/style/colors_manager.dart';

class FilterDialogWidget extends StatefulWidget {
  const FilterDialogWidget({super.key});

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: ColorManager.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLabelText("Language"),
              _getLanguageFilter(context),
              _getLabelText("Sorted By"),
              _getSortedByFilter(context),
              _getLabelText("Sorting Type"),
              _getSortingTypeFilter(context)
            ],
          ),
        );
      },
    );
  }

  Widget _getSortedByFilter(BuildContext context) {
    return _getFilterField(labels: [
      "Time",
      "Word length"
    ], onTaps: [
      () => ReadDataCubit.get(context).updateSortedBy(SortedBy.time),
      () => ReadDataCubit.get(context).updateSortedBy(SortedBy.wordLength),
    ], conditionOfActivation: [
      ReadDataCubit.get(context).sortedBy == SortedBy.time,
      ReadDataCubit.get(context).sortedBy == SortedBy.wordLength
    ]);
  }

  Widget _getSortingTypeFilter(BuildContext context) {
    return _getFilterField(labels: [
      "Ascending",
      "Descending"
    ], onTaps: [
      () => ReadDataCubit.get(context).updateSortingType(SortingType.ascending),
      () =>
          ReadDataCubit.get(context).updateSortingType(SortingType.descending),
    ], conditionOfActivation: [
      ReadDataCubit.get(context).sortingType == SortingType.ascending,
      ReadDataCubit.get(context).sortingType == SortingType.descending
    ]);
  }

  Widget _getLanguageFilter(BuildContext context) {
    return _getFilterField(labels: [
      "Arabic",
      "English",
      "All"
    ], onTaps: [
      () => ReadDataCubit.get(context)
          .updateLanguageFilter(LanguageFilter.arabicOnly),
      () => ReadDataCubit.get(context)
          .updateLanguageFilter(LanguageFilter.englishOnly),
      () => ReadDataCubit.get(context)
          .updateLanguageFilter(LanguageFilter.allWords),
    ], conditionOfActivation: [
      ReadDataCubit.get(context).languageFilter == LanguageFilter.arabicOnly,
      ReadDataCubit.get(context).languageFilter == LanguageFilter.englishOnly,
      ReadDataCubit.get(context).languageFilter == LanguageFilter.allWords,
    ]);
  }

//! functions to ease my code

  Widget _getFilterField({
    required List<String> labels,
    required List<VoidCallback> onTaps,
    required List<bool> conditionOfActivation,
  }) {
    return Row(
      children: [
        for (var i = 0; i < labels.length; i++)
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                onTaps[i]();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: conditionOfActivation[i]
                        ? ColorManager.white
                        : ColorManager.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ColorManager.white, width: 2)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      labels[i],
                      style: TextStyle(
                          color: conditionOfActivation[i]
                              ? ColorManager.black
                              : ColorManager.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

/////////////////////////////////////////////////////////////////////

  Widget _getLabelText(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          text,
          style: const TextStyle(
              color: ColorManager.white,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
