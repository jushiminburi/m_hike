part of 'create_update_form_bloc.dart';

@freezed
class CreateUpdateHikeFormState with _$CreateUpdateHikeFormState {
  const CreateUpdateHikeFormState._();
  factory CreateUpdateHikeFormState({
    String? nameHike,
    String? locationHike,
    DateTime? startDate,
    @Default(false) bool isParking,
    double? distanceHike,
    @Default(1) int levelDifficult,
    String? description,
    int? estimateCompleteTime,
    List<String>? imagesPath,
    String? startLocation,
  }) = _CreateUpdateHikeFormState;

  bool get isEmptyName => nameHike.isEmptyStr;
  bool get isEmptyLocation => locationHike.isEmptyStr;
  bool get isEmptyStartDate => startDate.toString().isEmptyStr;
  bool get isEmptyDistanceHike => distanceHike.toString().isEmptyStr;
}
