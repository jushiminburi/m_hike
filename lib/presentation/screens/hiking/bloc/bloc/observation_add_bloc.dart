import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:m_hike/domain/models/observation_hike.dart';
part 'observation_add_bloc.freezed.dart';
part 'observation_add_state.dart';
part 'observation_add_event.dart';

@injectable
class ObservationAddBLoc
    extends Bloc<ObservationAddEvent, ObservationAddState> {
  ObservationAddBLoc() : super(ObservationAddState()) {
    on<_Create>((event, emit) async {});
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
}
