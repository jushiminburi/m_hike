import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:m_hike/common/extension/string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_update_form_event.dart';
part 'create_update_form_state.dart';
part 'create_update_form_bloc.freezed.dart';

@injectable
class CreateUpdateFormBloc
    extends Bloc<CreateUpdateHikeFormEvent, CreateUpdateHikeFormState> {
  CreateUpdateFormBloc() : super(CreateUpdateHikeFormState()) {
    //* Initialize form data
    on<_Init>((event, emit) {
      emit(CreateUpdateHikeFormState(
          nameHike: event.nameHike,
          locationHike: event.locationHike,
          startDate: event.startDate,
          isParking: event.isParking ?? false,
          distanceHike: event.distanceHike,
          levelDifficult: event.levelDifficult ?? 1,
          description: event.description,
          estimateCompleteTime: event.estimateCompleteTime,
          imagesPath: event.imagesPath,
          startLocation: event.startLocation));
    });

    //* Update fields data with current data
    on<CreateUpdateHikeFormEvent>((event, emit) {
      if (event is _NameChanged) {
        emit(state.copyWith(nameHike: event.value));
      }
      if (event is _LocationChanged) {
        emit(state.copyWith(locationHike: event.value));

      }
      if (event is _StartDateChanged) {
        emit(state.copyWith(startDate: event.value));
      }
      if (event is _IsParkingChanged) {
        emit(state.copyWith(isParking: event.value));
      }
      if (event is _DistanceHikeChanged) {
        emit(state.copyWith(distanceHike: event.value));
      }
      if (event is _LevelDifficultChanged) {
        emit(state.copyWith(levelDifficult: event.value));
      }
      if (event is _ImagesPathChanged) {
        emit(state.copyWith(imagesPath: event.value));
      }
      if (event is _StartLocationChanged) {
        emit(state.copyWith(startLocation: event.value));
      }
    });

    //* Create new or update hike to local storage

    on<_CreateOrUpdateHike>((event, emit) {
      if(event.id == null){

      }else{
        
      }
    });
  }
}
