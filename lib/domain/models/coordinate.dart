import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'coordinate.freezed.dart';
part 'coordinate.g.dart';

@freezed
@Embedded(ignore: {'copyWith'})
class Coordinate with _$Coordinate {
  const factory Coordinate(
      {@Default(0) double lat,
      @Default(0) double lng,
      }) = _Coordinate;
}
