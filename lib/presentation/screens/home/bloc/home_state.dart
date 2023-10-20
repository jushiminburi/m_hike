part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({List<Hike>? hikes,Weather? weather,String? time}) = _HomeState;
}
