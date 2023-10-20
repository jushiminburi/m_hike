import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:m_hike/data/local/hike/hike_repository.dart';
import 'package:m_hike/domain/models/hike.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._hikeRepository) : super(HomeState(hikes: HomeHikes())) {
    on<_Initial>((event, emit) async {
      final latest = await _hikeRepository.fectchLisLatestHike();
      final soon = await _hikeRepository.fetchListComingSoonHike();
      final complete = await _hikeRepository.fetchListCompleteHike();
      emit(state.copyWith(
          hikes: HomeHikes(
              latest: latest, comingSoon: soon, completed: complete)));
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
  final HikeRepository _hikeRepository;
}
