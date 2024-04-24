part of 'subdistrict_bloc.dart';

sealed class SubdistrictEvent extends Equatable {
  const SubdistrictEvent();

  @override
  List<Object> get props => [];
}

class OnGetSubdistrict extends SubdistrictEvent {
  final String cityId;

  const OnGetSubdistrict({required this.cityId});

  @override
  List<Object> get props => [cityId];
}
