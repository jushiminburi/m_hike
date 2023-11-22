// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_place.freezed.dart';
part 'search_place.g.dart';

@freezed
class SearchPlaces with _$SearchPlaces {
  factory SearchPlaces(
    @JsonKey(name: 'description') description,
    @JsonKey(name: 'place_id') String placeId,
  ) = _SearchPlaces;
  factory SearchPlaces.fromJson(Map<String, dynamic> json) =>
      _$SearchPlacesFromJson(json);
}
