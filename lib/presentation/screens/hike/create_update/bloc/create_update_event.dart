
part of 'create_update_bloc.dart';

@freezed
class CreateUpdateHikeEvent with _$CreateUpdateHikeEvent {
  const factory CreateUpdateHikeEvent.create(Hike hike) = _Create;
  const factory CreateUpdateHikeEvent.update(Hike hike, Id id) = _Update;
}
