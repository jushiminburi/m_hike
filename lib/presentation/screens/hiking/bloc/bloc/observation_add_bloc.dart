import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:m_hike/common/utils.dart';
import 'package:m_hike/data/local/hike/hike_repository.dart';
import 'package:m_hike/domain/models/hike.dart';
import 'package:m_hike/domain/models/observation_hike.dart';
part 'observation_add_bloc.freezed.dart';
part 'observation_add_state.dart';
part 'observation_add_event.dart';

@injectable
class ObservationAddBLoc
    extends Bloc<ObservationAddEvent, ObservationAddState> {
  ObservationAddBLoc(this._hikeRepository) : super(ObservationAddState()) {
    on<_Create>((event, emit) async {
      List<Observation> obs = [event.obs];

      final hike = event.hike.copyWith(
          observationPoints: [...event.hike.observationPoints, ...obs]);
      await _hikeRepository.cacheHikeToLocal(hike);
      Util.showSuccess('Create and save hike to storage');
    });
    on<_NameChanged>((event, emit) async {
      emit(state.copyWith(nameObservation: event.value));
    });
    on<_TimeChanged>((event, emit) async {
      emit(state.copyWith(time: event.value));
    });
    on<_ReviewChanged>((event, emit) async {
      emit(state.copyWith(description: event.value));
    });
  }
  final HikeRepository _hikeRepository;
}
