part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  factory HomeEvent.initial() = _Initial;
  factory HomeEvent.search(String keyword) = _Search;
}
