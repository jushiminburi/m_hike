part of 'place_repository.dart';

const String key = 'AIzaSyBSrokuI10_er4Y5w8OK5VYWp-rK9e6drI';

@LazySingleton(as: PlacesRepository)
class PlacesRepositoryImpl implements PlacesRepository {
  @override
  Future<Places> getDataPlace(String id) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Places.fromJson(jsonResult);
  }

  @override
  Future<List<Places>> getDataPlaces(
      double lat, double lng, String placeType) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Places.fromJson(place)).toList();
  }

  @override
  Future<List<SearchPlaces>> getDataPlacesAutoComplete(String place) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$place&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    print(json['error_message']);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => SearchPlaces.fromJson(place)).toList();
  }

  @override
  Future<List<Places>> getDataNearBySearch(double lat, double lng) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=10&key=$key');
    var response = await http.post(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Places.fromJson(place)).toList();
  }
}
