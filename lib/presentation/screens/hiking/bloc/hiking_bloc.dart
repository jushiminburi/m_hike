import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:m_hike/domain/models/hike.dart';
part 'hiking_bloc.freezed.dart';
part 'hiking_event.dart';
part 'hiking_state.dart';

@injectable
class HikingBloc extends Bloc<HikingEvent, HikingState> {
  HikingBloc(super.initialState) {
    on<_Initial>((event, emit) => _initialRouter);
    on<_StartRouter>((event, emit) => _startRouter);
    on<_FinishRouter>((event, emit) => null);
  }
  void _startRouter(HikingEvent event, Emitter<HikingState> emit) {}
  void _initialRouter(_Initial event, Emitter<HikingState> emit) {
    final Hike hike = event.hike;
    emit(HikingState(
      destinationLocation: LatLng(hike.lattitudeDestination, hike.longtitudeDestination),
    ));
  }
}
