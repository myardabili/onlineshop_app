part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class OnRegister extends RegisterEvent {
  final RegisterRequestModel model;

  const OnRegister({required this.model});

  @override
  List<Object> get props => [model];
}
