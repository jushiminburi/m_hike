import 'package:injectable/injectable.dart';
import 'package:m_hike/domain/models/maps/places.dart';
import 'package:m_hike/domain/models/maps/search_place.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
part 'place_repository_impl.dart';

abstract class PlacesRepository {
  Future<List<SearchPlaces>> getDataPlacesAutoComplete(String place);
  Future<Places> getDataPlace(String id);
  Future<List<Places>> getDataPlaces(double lat, double lng, String placeType);
  Future<List<Places>> getDataNearBySearch(double lat, double lng);
}
