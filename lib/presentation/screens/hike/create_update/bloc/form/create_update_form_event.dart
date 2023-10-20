part of 'create_update_form_bloc.dart';

@freezed
class CreateUpdateHikeFormEvent with _$CreateUpdateHikeFormEvent {
  const factory CreateUpdateHikeFormEvent.init(
      { String? routerName,
       String? destinationName,
       double? coordinateDestination,
       String? placeOfOriginName,
       double? coordinatePlaceOfOrigin,
       bool? isParkingRouter,
       double? totalDuration,
       int? levelDifficultRouter,
       String? description,
       String? startDate,
       List<String>? images}) = _Init;
  const factory CreateUpdateHikeFormEvent.routerNameChanged(String value) =
      _NameChanged;
  const factory CreateUpdateHikeFormEvent.destinationNameChanged(String value) =
      _DestinationChanged;
        const factory CreateUpdateHikeFormEvent.coordinateDestinationChanged(double value) =
      _CoordinateDestinationChanged;
        const factory CreateUpdateHikeFormEvent.placeOfOriginNameChanged(String value) =
      _PlaceOfOriginNameChanged;
        const factory CreateUpdateHikeFormEvent.coordinatePlaceOfOriginChanged(double value) =
      _CoordinatePlaceOfOriginChanged;
  const factory CreateUpdateHikeFormEvent.startDateChanged(String value) =
      _StartDateChanged;
  const factory CreateUpdateHikeFormEvent.isParkingRouterChanged(bool value) =
      _IsParkingRouterChanged;
  const factory CreateUpdateHikeFormEvent.distanceHikeChanged(double value) =
      _TotalDurationChanged;
  const factory CreateUpdateHikeFormEvent.levelDifficultRouterChanged(int value) =
      _LevelDifficultRouterChanged;
  const factory CreateUpdateHikeFormEvent.descriptionChanged(String value) =
      _DescriptionChanged;
  const factory CreateUpdateHikeFormEvent.imagesChanged(
      List<String> value) = _ImagesChanged;
  const factory CreateUpdateHikeFormEvent.createOrUpdateHike({Id? id}) =
      _CreateOrUpdateHike;
}
