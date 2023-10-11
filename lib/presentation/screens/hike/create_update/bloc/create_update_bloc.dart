import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:m_hike/data/local/hike/hike_repository.dart';
import 'package:m_hike/domain/models/hike.dart';

part 'create_update_bloc.freezed.dart';
part 'create_update_event.dart';
part 'create_update_state.dart';

@injectable
class CreateUpdateHikeBloc
    extends Bloc<CreateUpdateHikeEvent, CreateUpdateHikeState> {
  CreateUpdateHikeBloc(this._repository)
      : super(const CreateUpdateHikeState.init()) {
    on<_Create>(createHike);

    on<_Update>(updateHike);
  }

//* Create new hike to local storage
  Future<void> createHike(
      CreateUpdateHikeEvent event, Emitter<CreateUpdateHikeState> emit) async {
    emit(const CreateUpdateHikeState.loading());
    await _repository.cacheHikeToLocal(event.hike);
    emit(const CreateUpdateHikeState.saved());
  }

//* Update hike to local storage
  Future<void> updateHike(
      CreateUpdateHikeEvent event, Emitter<CreateUpdateHikeState> emit) async {
    emit(const CreateUpdateHikeState.loading());
    await _repository.cacheHikeToLocal(event.hike);
    emit(const CreateUpdateHikeState.saved());
  }

  final HikeRepository _repository;
}
