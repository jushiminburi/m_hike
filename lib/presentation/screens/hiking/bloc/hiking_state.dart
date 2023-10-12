part of'hiking_bloc.dart';


@freezed
class HikingState with _$HikingState{
  factory HikingState({
    LatLng? currentLocation,
   @Default({}) Map<PolylineId, Polyline> polylines,
    LatLng? destinationLocation,
    LatLng? originaLocation,
    @Default('0') footStep,
  })= _HikingState;
}