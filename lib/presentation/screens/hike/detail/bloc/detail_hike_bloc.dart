import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:m_hike/common/utils.dart';
import 'package:m_hike/data/local/hike/hike_repository.dart';
import 'package:m_hike/domain/models/hike.dart';

part 'detail_hike_event.dart';
part 'detail_hike_state.dart';
part 'detail_hike_bloc.freezed.dart';

@injectable
class DetailHikeBloc extends Bloc<DetailHikeEvent, DetailHikeState> {
  DetailHikeBloc(this._hikeRepository) : super(const DetailHikeState(Hike())) {
    on<_Initial>(((event, emit) {
      final initData = event.hike;
      emit(DetailHikeState(
          Hike(
              isarId: initData.isarId,
              routerName: initData.routerName,
              destinationName: initData.destinationName,
              isParkingRouter: initData.isParkingRouter,
              startTime: initData.startTime,
              levelDifficultRouter: initData.levelDifficultRouter,
              totalDuration: initData.totalDuration,
              description: initData.description,
              imagesPath: initData.imagesPath,
              coordinateDestination: initData.coordinateDestination,
              coordinatePlaceOfOrigin: initData.coordinatePlaceOfOrigin,
              observationPoints: initData.observationPoints,
              completed: initData.completed,
              created: initData.created,
              updated: initData.updated), onCreateMap: (controller) {
        LatLng latLng_1 = LatLng(initData.coordinatePlaceOfOrigin?.lat ?? 0,
            initData.coordinatePlaceOfOrigin?.lng ?? 0);
        LatLng latLng_2 = LatLng(initData.coordinateDestination?.lat ?? 0,
            initData.coordinateDestination?.lng ?? 0);
        LatLngBounds bound = LatLngBounds(
            southwest:
                (latLng_1.latitude <= latLng_2.latitude) ? latLng_1 : latLng_2,
            northeast:
                (latLng_1.latitude <= latLng_2.latitude) ? latLng_2 : latLng_1);
        CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
        controller.animateCamera(u2).then((void v) {
          check(u2, controller);
        });
      }));
    }));
    on<_Save>(((event, emit) async {
      await _hikeRepository.cacheHikeToLocal(event.hike);
      Util.showSuccess('Create and save hike to storage');
    }));
  }
  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);

    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      check(u, c);
    }
  }

  final HikeRepository _hikeRepository;
}
