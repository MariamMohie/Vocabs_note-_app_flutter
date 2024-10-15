import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_database/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:hive_database/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:hive_database/view/style/colors_manager.dart';
import 'package:hive_database/view/widgets/arabic_or_english_widget.dart';
import 'package:hive_database/view/widgets/colors_widget.dart';
import 'package:hive_database/view/widgets/custom_form.dart';
import 'package:hive_database/view/widgets/done_button_widget.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        child: BlocBuilder<WriteDataCubit, WriteDataState>(
          builder: (context, state) {
            return BlocConsumer<WriteDataCubit, WriteDataState>(
              listener: (context, state) {
               if(state is WriteDataSuccess){
                Navigator.pop(context);
               }if(state is WriteDataFailed){
                ScaffoldMessenger.of(context).showSnackBar(_getSnackBarError(state.message));
               }
              },
              builder: (context, state) {
                return AnimatedContainer(
                  padding: const EdgeInsets.all(10),
                  color: Color(WriteDataCubit.get(context).colorCode),
                  duration: const Duration(milliseconds: 820),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ArabicOrEnglishWidget(
                        arabicIsSelected: WriteDataCubit.get(context).isArabic,
                        colorCode: WriteDataCubit.get(context).colorCode,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ColorsWidget(
                          activeColorCode:
                              WriteDataCubit.get(context).colorCode),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormWidget(formKey: formKey, label: "New Word"),
                      const SizedBox(height: 15),
                      DoneButtonWidget(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              WriteDataCubit.get(context).addWord();
                              ReadDataCubit.get(context).getWords();
                            }
                          },
                          colorCode: WriteDataCubit.get(context).colorCode)
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  SnackBar _getSnackBarError(String message) => SnackBar(content:Text(message), backgroundColor: ColorManager.red,);
}
