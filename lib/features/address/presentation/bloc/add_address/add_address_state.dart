part of 'add_address_bloc.dart';

sealed class AddAddressState extends Equatable {
  const AddAddressState();

  @override
  List<Object> get props => [];
}

final class AddAddressInitial extends AddAddressState {}

final class AddAddressLoading extends AddAddressState {}

final class AddAddressFailure extends AddAddressState {
  final String message;

  const AddAddressFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class AddAddressLoaded extends AddAddressState {}
