part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutFailure extends LogoutState {
  final String message;

  const LogoutFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class LogoutLoaded extends LogoutState {}
