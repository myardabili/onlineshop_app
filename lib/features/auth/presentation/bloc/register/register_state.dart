part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterFailure extends RegisterState {
  final String message;

  const RegisterFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class RegisterLoaded extends RegisterState {
  final RegisterModel user;

  const RegisterLoaded({required this.user});
  @override
  List<Object> get props => [user];
}
