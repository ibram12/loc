part of 'delete_old_data_cubit.dart';

@immutable
sealed class DeleteOldDataState {}

final class DeleteOldDataInitial extends DeleteOldDataState {}
final class DeleteOldDataSuccess extends DeleteOldDataState {}
final class DeleteOldDataLoading extends DeleteOldDataState {}

final class DeleteOldDataerror extends DeleteOldDataState {}
