import 'package:injectable/injectable.dart';
import 'package:m_hike/domain/models/weather.dart';


import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
part 'weather_repository_impl.dart';
abstract class WeatherRepository {
  Future<Weather> getTempHomePage(String ip);
}
