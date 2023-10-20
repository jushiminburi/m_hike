// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
class Weather with _$Weather {
  factory Weather(Current current) = _Weather;
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@freezed
class Current with _$Current {
  factory Current(@JsonKey(name: 'temp_c') double tempC, Condition condition) =
      _Current;
  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);
}

@freezed
class Condition with _$Condition {
  factory Condition(String text, String icon) = _Condition;

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);
}
