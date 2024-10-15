import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_database/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:hive_database/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:hive_database/view/style/colors_manager.dart';
import 'package:hive_database/view/widgets/arabic_or_english_widget.dart';
import 'package:hive_database/view/widgets/custom_form.dart';
import 'package:hive_database/view/widgets/done_button_widget.dart';

class UpdateWordDialogWidget extends StatefulWidget {
  const UpdateWordDialogWidget(
      {super.key,
      required this.isExample,
      required this.colorCode,
      required this.indexInDB});
  final bool isExample;
  final int colorCode;
  final int indexInDB;

  @override
  State<UpdateWordDialogWidget> createState() => _UpdateWordDialogWidgetState();
}

class _UpdateWordDialogWidgetState extends State<UpdateWordDialogWidget> {
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(widget.colorCode),
      child: BlocConsumer<WriteDataCubit, WriteDataState>(
        listener: (BuildContext context, WriteDataState state) {
          if (state is WriteDataSuccess) {
            Navigator.pop(context);
          } else if (state is WriteDataFailed) {
            _getSnackBar(context, state);
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ArabicOrEnglishWidget(
                    arabicIsSelected: WriteDataCubit.get(context).isArabic,
                    colorCode: widget.colorCode),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomFormWidget(
                    formKey: _formKey,
                    label:
                        widget.isExample ? "New Example" : "New Similar Word"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DoneButtonWidget(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.isExample) {
                          WriteDataCubit.get(context)
                              .addExample(widget.indexInDB);
                        } else {
                          WriteDataCubit.get(context)
                              .addSimilarWord(widget.indexInDB);
                        }
                      }
                      ReadDataCubit.get(context).getWords();
                    },
                    colorCode: widget.colorCode),
              )
            ],
          );
        },
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _getSnackBar(
          BuildContext context, WriteDataFailed state) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(state.message),
        backgroundColor: ColorManager.red,
      ));
}
