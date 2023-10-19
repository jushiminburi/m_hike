part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState(List<Hike>? hikes) = _HomeState;
}
