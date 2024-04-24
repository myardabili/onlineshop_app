part of 'get_address_bloc.dart';

sealed class GetAddressEvent extends Equatable {
  const GetAddressEvent();

  @override
  List<Object> get props => [];
}

class OnGetAddress extends GetAddressEvent {}
