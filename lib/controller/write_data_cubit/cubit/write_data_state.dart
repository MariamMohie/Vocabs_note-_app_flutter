part of 'write_data_cubit.dart';

@immutable
sealed class WriteDataState {}

final class WriteDataInitial extends WriteDataState {}
final class WriteDataLoading extends WriteDataState {}
final class WriteDataSuccess extends WriteDataState {}
final class WriteDataFailed extends WriteDataState {
 final String message;
  WriteDataFailed({ required this.message});
}
