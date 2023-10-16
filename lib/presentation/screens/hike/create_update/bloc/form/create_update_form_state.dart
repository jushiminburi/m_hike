part of 'create_update_form_bloc.dart';

@freezed
class CreateUpdateHikeFormState with _$CreateUpdateHikeFormState {
  const CreateUpdateHikeFormState._();
  factory CreateUpdateHikeFormState({
  @Default('')  String nameHike,
  @Default('')  String locationHike,
   DateTime? startDate,
    @Default(false) bool isParking,
  @Default(0)  double distanceHike,
    @Default(1) int levelDifficult,
  @Default('')  String description,
  @Default(0)  int estimateCompleteTime,
   @Default([]) List<List<int>> imagesPath,
   @Default('') String startLocation,
  }) = _CreateUpdateHikeFormState;

  bool get isEmptyName => nameHike.isEmptyStr;
  bool get isEmptyLocation => locationHike.isEmptyStr;
  bool get isEmptyStartDate => startDate.toString().isEmptyStr;
  bool get isEmptyDistanceHike => distanceHike.toString().isEmptyStr;
}
