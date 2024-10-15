import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_database/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:hive_database/view/style/colors_manager.dart';

class CustomFormWidget extends StatefulWidget {
  const CustomFormWidget(
      {super.key, required this.formKey, required this.label});
  final String label;
  final GlobalKey<FormState> formKey;

  @override
  State<CustomFormWidget> createState() => _CustomFormWidgetState();
}

class _CustomFormWidgetState extends State<CustomFormWidget> {
  final TextEditingController newWordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        autofocus: true,
        controller: newWordController,
        minLines: 1,
        maxLines: 2,
        maxLength: 50,
        style: const TextStyle(color: ColorManager.white),
        cursorColor: ColorManager.white,
        decoration: _getInputDecoration(),
        onChanged: (value) => WriteDataCubit.get(context).updateText(value),
        validator: (value) {
         return _validator(value, WriteDataCubit.get(context).isArabic); 
        },
      ),
    );
  }
  String ? _validator(String? value , bool isArabic ){
   if(value == null || value.isEmpty){
    return "This field can't be empty";
   }
   for(var i=0 ;i< value.length ;i++){
    CharType chartype =  _getCharType(value.codeUnitAt(i));
    if(chartype ==  CharType.space){
      return "Char number ${i+1} is not valid";
    }else if(chartype ==CharType.arabic && isArabic== false){
      return "Char number ${i+1} is not english";

    }
    else if(chartype ==CharType.english && isArabic== true){
      return "Char number ${i+1} is not arabic";

    }
   }

  }

  CharType _getCharType( int asciCode){
    if((asciCode >=65 && asciCode<=90 )|| (asciCode >=97 && asciCode<=122)){
      return CharType.english;
    }else if(asciCode <= 1369 && asciCode>=1610){
      CharType.arabic;
    }else if(asciCode ==32){
      return CharType.space;
    }
      return CharType.notValid;
    
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
        label: Text(widget.label, style: const TextStyle(color: ColorManager.white),),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                const BorderSide(color: ColorManager.white, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                const BorderSide(color: ColorManager.red, width: 2)),
         errorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                const BorderSide(color: ColorManager.red, width: 2)), 
         focusedErrorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                const BorderSide(color: ColorManager.white, width: 2)), 
      );
  }
}
enum CharType{
  arabic,
  english,
  space,
  notValid
}
