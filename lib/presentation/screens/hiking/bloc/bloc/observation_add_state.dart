part of 'observation_add_bloc.dart';

@freezed 
class ObservationAddState with _$ObservationAddState {
  factory ObservationAddState({
    @Default('') String? nameObservation,
    DateTime? time,
    @Default('') String description,
    @Default([]) List<String> imagesPath,
  }) = _ObservationAddState;
}