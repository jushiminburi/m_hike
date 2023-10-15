import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:m_hike/common/utils.dart';
import 'package:m_hike/data/local/hike/hike_repository.dart';
import 'package:m_hike/di/di.dart';
import 'package:m_hike/domain/models/hike.dart';
import 'package:m_hike/presentation/routes/app_router.dart';

part 'detail_hike_event.dart';
part 'detail_hike_state.dart';
part 'detail_hike_bloc.freezed.dart';

@injectable
class DetailHikeBloc extends Bloc<DetailHikeEvent, DetailHikeState> {
  DetailHikeBloc(this._hikeRepository) : super(const DetailHikeState(Hike())) {
    on<_Initial>(((event, emit) {
      final initData = event.hike;
      emit(DetailHikeState(Hike(
          isarId: initData.isarId,
          routerName: initData.routerName,
          destinationName: initData.destinationName,
          isParkingRouter: initData.isParkingRouter,
          startTime: initData.startTime,
          levelDifficultRouter: initData.levelDifficultRouter,
          totalDuration: initData.totalDuration,
          description: initData.description,
          images: initData.images,
          observationPoints: initData.observationPoints,
          completed: initData.completed,
          created: initData.created,
          updated: initData.updated)));
    }));
    on<_Save>(((event, emit) async {
      await _hikeRepository.cacheHikeToLocal(event.hike);
      getIt<AppRouter>().navigate(const HomeRoutes());
      Util.showSuccess('Create and save hike to storage');
    }));
  }

  final HikeRepository _hikeRepository;
}
