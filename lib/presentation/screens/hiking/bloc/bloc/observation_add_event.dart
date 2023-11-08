part of 'observation_add_bloc.dart';

@freezed
class ObservationAddEvent with _$ObservationAddEvent {
  const factory ObservationAddEvent.create(Observation obs, Id isarId) = _Create;
  const factory ObservationAddEvent.nameChanged(String value) = _NameChanged;
  const factory ObservationAddEvent.timeChanged(DateTime value) = _TimeChanged;
   const factory ObservationAddEvent.reviewChanged(String value) = _ReviewChanged;
  const factory ObservationAddEvent.imageChanged() = _ImageChanged;
}