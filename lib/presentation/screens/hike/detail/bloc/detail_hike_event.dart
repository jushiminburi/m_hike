part of 'detail_hike_bloc.dart';

@freezed
class DetailHikeEvent with _$DetailHikeEvent {
  const factory DetailHikeEvent.initial(Hike hike) = _Initial;
  const factory DetailHikeEvent.save(Hike hike) = _Save;
   const factory DetailHikeEvent.start(Hike hike) = _Start;
}
