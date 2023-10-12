part of 'hiking_bloc.dart';

@freezed
class HikingEvent with _$HikingEvent {
  const factory HikingEvent.initia(Hike hike) = _Initial;
  const factory HikingEvent.start() = _StartRouter;
  const factory HikingEvent.finish() = _FinishRouter;

}
