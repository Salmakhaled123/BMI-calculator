part of 'bmi_cubit.dart';

@immutable
abstract class BmiState {}

class BmiInitial extends BmiState {}

class SignInAnonymouslyLoading extends BmiState {}

class SignInAnonymouslySucceeded extends BmiState {}

class SignInAnonymouslyFailed extends BmiState {
  final String errorMessage;

  SignInAnonymouslyFailed({required this.errorMessage});
}

class CalculatedSuccessfully extends BmiState {}

class AddNewUserSuccessfully extends BmiState {}

class AddNewUserFailed extends BmiState {}

class GetAllEntriesSuccessfully extends BmiState {}

class GetAllEntriesLoading extends BmiState {}

class DeleteEntriesSuccessfully extends BmiState {}

class SignedOutSuccessfully extends BmiState {}

class EditEntrySuccessfully extends BmiState {}
