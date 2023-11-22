// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'places.freezed.dart';
part 'places.g.dart';


@freezed
class Places with _$Places {
  factory Places(
      @JsonKey(name: 'geometry') Geometry geometry,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'formatted_address') String? formatAddress,
      @JsonKey(name: 'vicinity') String? vicinity) = _Places;
       factory Places.fromJson(Map<String, dynamic> json) =>
      _$PlacesFromJson(json);
}

@freezed
class Geometry with _$Geometry {
  factory Geometry(@JsonKey(name: 'location') LocationMaps location) =
      _Geometry;
  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
}

@freezed
class LocationMaps with _$LocationMaps {
  factory LocationMaps(
          @JsonKey(name: 'lat') double lat, @JsonKey(name: 'lng') double lng) =
      _LocationMaps;
  factory LocationMaps.fromJson(Map<String, dynamic> json) =>
      _$LocationMapsFromJson(json);
}
