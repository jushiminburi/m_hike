import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:m_hike/common/utils.dart';
import 'package:m_hike/data/local/hike/hike_repository.dart';
import 'package:m_hike/data/remote/weather/weather_repository.dart';
import 'package:m_hike/domain/models/hike.dart';
import 'package:m_hike/domain/models/weather.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._weatherRepository, this._hikeRepository)
      : super(const HomeState()) {
    on<_Initial>((event, emit) async {
      final Position pos = await _determinePosition();
      final temp = await _weatherRepository
          .getTempHomePage('${pos.latitude},${pos.longitude}');
      final latest = await _hikeRepository.fectchLisLatestHike();
      final soon = await _hikeRepository.fetchListComingSoonHike();
      final complete = await _hikeRepository.fetchListCompleteHike();
      emit(state.copyWith(
          hikes: HomeHikes(
              latest: latest, comingSoon: soon, completed: complete)));
      emit(state.copyWith(weather: temp, time: Util.getTimeOfDay()));
    });
    on<_Search>((event, emit) async {
      final latest =
          await _hikeRepository.fectchLisLatestHike(keywords: event.keyword);
      final soon = await _hikeRepository.fetchListComingSoonHike(
          keywords: event.keyword);
      final complete =
          await _hikeRepository.fetchListCompleteHike(keywords: event.keyword);
      emit(state.copyWith(
          hikes: HomeHikes(
              latest: latest, comingSoon: soon, completed: complete)));
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  final WeatherRepository _weatherRepository;
  final HikeRepository _hikeRepository;
}
