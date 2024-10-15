import 'package:hive_database/model/word_model.dart';
import 'package:hive_flutter/adapters.dart';

class WordTypeAdapter extends TypeAdapter<WordModel> {
  @override
  WordModel read(BinaryReader reader) {
    return WordModel(
      indexDB: reader.readInt(),
      colorCode: reader.readInt(),
      text: reader.readString(),
      isArabic: reader.readBool(),
      englishSimilarWords: reader.readStringList(),
      arabicSimilarWords: reader.readStringList(),
      englishExamples: reader.readStringList(),
      arabicExamples: reader.readStringList(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer.writeInt(obj.indexDB);
    writer.writeInt(obj.colorCode);
    writer.writeString(obj.text);
    writer.writeBool(obj.isArabic);
    writer.writeStringList(obj.englishSimilarWords);
    writer.writeStringList(obj.arabicSimilarWords);
    writer.writeStringList(obj.englishExamples);
    writer.writeStringList(obj.arabicExamples);
  }

  
}


