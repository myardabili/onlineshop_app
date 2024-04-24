part of 'get_address_bloc.dart';

sealed class GetAddressState extends Equatable {
  const GetAddressState();

  @override
  List<Object> get props => [];
}

final class GetAddressInitial extends GetAddressState {}

final class GetAddressLoading extends GetAddressState {}

final class GetAddressFailure extends GetAddressState {
  final String message;

  const GetAddressFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class GetAddressLoaded extends GetAddressState {
  final List<Address> address;

  const GetAddressLoaded({required this.address});

  @override
  List<Object> get props => [address];
}
