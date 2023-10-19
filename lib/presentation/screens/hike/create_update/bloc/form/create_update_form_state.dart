part of 'create_update_form_bloc.dart';

@freezed
class CreateUpdateHikeFormState with _$CreateUpdateHikeFormState {
  const CreateUpdateHikeFormState._();
  factory CreateUpdateHikeFormState({
    @Default('') String nameHike,
     TextEditingController? locationHikeController,
    List<SearchPlaces>? locationNameSuggest,
    Coordinate? coordinateDestination,
    DateTime? startDate,
    @Default(false) bool isParking,
    @Default(0) double distanceHike,
    @Default(1) int levelDifficult,
    @Default('') String description,
    @Default(0) int estimateCompleteTime,
    @Default([]) List<ImageLocal> imagesPath,
    @Default('') String startLocation,
  }) = _CreateUpdateHikeFormState;

  bool get isEmptyName => nameHike.isEmptyStr;
  bool get isEmptyLocation => locationHikeController!.text.isEmptyStr;
  bool get isEmptyStartDate => Util.formatDateTime(startDate).isEmptyStr;
  bool get isEmptyDistanceHike =>
      distanceHike.toString().isEmptyStr || distanceHike.toString() == '0.0';
}
