part of 'add_address_bloc.dart';

sealed class AddAddressEvent extends Equatable {
  const AddAddressEvent();

  @override
  List<Object> get props => [];
}

class OnAddAddress extends AddAddressEvent {
  final AddressRequestModel model;

  const OnAddAddress({required this.model});

  @override
  List<Object> get props => [model];
}
