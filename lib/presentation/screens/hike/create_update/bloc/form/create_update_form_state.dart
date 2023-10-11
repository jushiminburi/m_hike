part of 'create_update_form_bloc.dart';

@freezed
class CreateUpdateHikeFormState with _$CreateUpdateHikeFormState {
  const CreateUpdateHikeFormState._();
  factory CreateUpdateHikeFormState({
    String? routerName,
    String? destinationName,
    double? coordinateDestination,
    String? placeOfOriginName,
    double? coordinatePlaceOfOrigin,
    @Default(false) bool isParkingRouter,
    double? totalDuration,
    @Default(1) int levelDifficultRouter,
    String? description,
    String?startDate,
    List<String>? images,
  }) = _CreateUpdateHikeFormState;

  bool get isEmptyName => routerName.isEmptyStr;
  bool get isEmptyDestination => destinationName.isEmptyStr;
  bool get isEmptyStartDate => startDate.toString().isEmptyStr;
  bool get isEmptyTotalDuration => totalDuration.toString().isEmptyStr;
}
