import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'observation_hike.freezed.dart';
part 'observation_hike.g.dart';

@freezed
@Embedded(ignore: {'copyWith'})
class Observation with _$Observation {
  const factory Observation(
      {@Default(0) int id,
      @Default('') String name,
      @Default('') String originalName,
      @Default([]) List<String> imagesPath}) = _Observation;
}
