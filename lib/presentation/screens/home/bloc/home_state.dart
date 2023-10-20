part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({HomeHikes? hikes}) = _HomeState;
}

class HomeHikes {
  List<Hike> latest;
  List<Hike> comingSoon;
  List<Hike> completed;
  HomeHikes(
      {this.latest = const [],
      this.comingSoon = const [],
      this.completed = const []});
  bool get isNoDataLatest => latest.isEmpty;
  bool get isNoDataComingSoon => comingSoon.isEmpty;
  bool get isNoDataCompleted => completed.isEmpty;
}
