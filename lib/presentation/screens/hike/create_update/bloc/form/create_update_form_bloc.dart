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
        routerName: event.routerName,
        destinationName: event.destinationName,
        coordinateDestination: event.coordinateDestination,
        placeOfOriginName: event.placeOfOriginName,
        coordinatePlaceOfOrigin: event.coordinatePlaceOfOrigin,
        startDate: event.startDate,
        isParkingRouter: event.isParkingRouter ?? false,
        totalDuration: event.totalDuration,
        levelDifficultRouter: event.levelDifficultRouter ?? 1,
        description: event.description,
        images: event.images,
      ));
    });

    //* Update fields data with current data
    on<CreateUpdateHikeFormEvent>((event, emit) {
      if (event is _NameChanged) {
        emit(state.copyWith(routerName: event.value));
      }
      if (event is _DestinationChanged) {
        emit(state.copyWith(destinationName: event.value));
      }
      if (event is _StartDateChanged) {
        emit(state.copyWith(startDate: event.value));
      }
      if (event is _CoordinateDestinationChanged) {
        emit(state.copyWith(coordinateDestination: event.value));
      }
      if (event is _PlaceOfOriginNameChanged) {
        emit(state.copyWith(placeOfOriginName: event.value));
      }
      if (event is _CoordinatePlaceOfOriginChanged) {
        emit(state.copyWith(coordinatePlaceOfOrigin: event.value));
      }
      if (event is _IsParkingRouterChanged) {
        emit(state.copyWith(isParkingRouter: event.value));
      }
      if (event is _TotalDurationChanged) {
        emit(state.copyWith(totalDuration: event.value));
      }
      if (event is _LevelDifficultRouterChanged) {
        emit(state.copyWith(levelDifficultRouter: event.value));
      }
      if (event is _DescriptionChanged) {
        emit(state.copyWith(description: event.value));
      }
      if (event is _ImagesChanged) {
        emit(state.copyWith(images: event.value));
      }
    });

    //* Create new or update hike to local storage

    on<_CreateOrUpdateHike>((event, emit) {
      if (event.id == null) {
      } else {}
    });
  }
}
