import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:m_hike/domain/models/coordinate.dart';
import 'package:m_hike/domain/models/observation_hike.dart';
part 'hike.g.dart';
part 'hike.freezed.dart';


@Freezed()
@Collection(ignore: {'copyWith'})
class Hike with _$Hike {
  const factory Hike({
    @Default(Isar.autoIncrement) int isarId,
    @Default('') String routerName,
    @Default('') String destinationName,
    Coordinate? coordinateDestination,
    @Default(0.0) double longtitudeDestination,
    @Default('') String placeOfOriginName,
    Coordinate? coordinatePlaceOfOrigin,
    @Default(false) bool isParkingRouter,
    DateTime? startTime,
    @Default(1) int levelDifficultRouter,
    @Default(0.0) double totalDuration, // unit: Miles
    @Default('') String description,
    @Default([]) List<String>? imagesPath,
    @Default([]) List<Observation> observationPoints,
    @Default(false) bool completed,
    DateTime? created,
    DateTime? updated,
  }) = _Hike;
  @override
  Id get isarId;
}
