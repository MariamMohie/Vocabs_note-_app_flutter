part of 'read_data_cubit.dart';

@immutable
sealed class ReadDataState {}

final class ReadDataInitial extends ReadDataState {}

final class ReadDataLoading extends ReadDataState {}
final class ReadDataSuccess extends ReadDataState {
  final List<WordModel> words;
  ReadDataSuccess ({required this.words});
}
final class ReadDataFailed extends ReadDataState {
  final String message;
  ReadDataFailed ({required this.message});

}
