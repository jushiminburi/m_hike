part of 'create_update_form_bloc.dart';

@freezed
class CreateUpdateHikeFormEvent with _$CreateUpdateHikeFormEvent {
  const factory CreateUpdateHikeFormEvent.init({
    String? nameHike,
    TextEditingController? locationHikeController,
    DateTime? startDate,
    @Default(false) bool? isParking,
    double? distanceHike,
    int? levelDifficult,
    String? description,
    int? estimateCompleteTime,
    List<ImageLocal>? imagesPath,
    String? startLocation,
  }) = _Init;
  const factory CreateUpdateHikeFormEvent.nameChanged(String value) =
      _NameChanged;
       const factory CreateUpdateHikeFormEvent.listStartLocation(String value) =
      _ListStartLocation;
  const factory CreateUpdateHikeFormEvent.locationStartChanged(SearchPlaces value) =
      _LocationStartChanged;
     const factory CreateUpdateHikeFormEvent.listLocation(String value) =
      _ListLocation;
  const factory CreateUpdateHikeFormEvent.locationChanged(SearchPlaces value) =
      _LocationChanged;
  const factory CreateUpdateHikeFormEvent.startDateChanged(DateTime value) =
      _StartDateChanged;
  const factory CreateUpdateHikeFormEvent.isParkingChanged(int value) =
      _IsParkingChanged;
  const factory CreateUpdateHikeFormEvent.distanceHikeChanged(double value) =
      _DistanceHikeChanged;
  const factory CreateUpdateHikeFormEvent.levelDifficultChanged(int value) =
      _LevelDifficultChanged;
  const factory CreateUpdateHikeFormEvent.descriptionChanged(String value) =
      _DescriptionChanged;
  const factory CreateUpdateHikeFormEvent.estimateCompleteTimeChanged(
      double value) = _EstimateCompleteTimeChanged;
  const factory CreateUpdateHikeFormEvent.imagesPathChanged(bool isCamera) =
      _ImagesPathChanged;
  const factory CreateUpdateHikeFormEvent.startLocationChanged(String value) =
      _StartLocationChanged;
  const factory CreateUpdateHikeFormEvent.createOrUpdateHike({Id? id}) =
      _CreateOrUpdateHike;
  const factory CreateUpdateHikeFormEvent.removeImage(int index) = _RemoveImage;
}
