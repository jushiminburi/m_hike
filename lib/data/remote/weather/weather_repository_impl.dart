part of 'weather_repository.dart';

@LazySingleton(as: WeatherRepository)
class WeatheRepositoryImpl implements WeatherRepository {
  @override
  Future<Weather> getTempHomePage(String ip) async {
    var url =
        'http://api.weatherapi.com/v1/current.json?q=$ip&key=904c47047aee452485a162134231910';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    return Weather.fromJson(json);
  }
}
