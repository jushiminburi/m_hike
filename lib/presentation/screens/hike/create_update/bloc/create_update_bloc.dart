// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:injectable/injectable.dart';
// import 'package:isar/isar.dart';
// import 'package:m_hike/domain/models/hike.dart';

// part 'create_update_bloc.freezed.dart';
// part 'create_update_event.dart';
// part 'create_update_state.dart';

// @injectable
// class CreateUpdateHikeBloc
//     extends Bloc<CreateUpdateHikeEvent, CreateUpdateHikeState> {
//   CreateUpdateHikeBloc() : super(const CreateUpdateHikeState.init()) {
//     //* Create new hike to local storage

//     on<_Create>((event, emit) {
//       emit(const CreateUpdateHikeState.loading());
//     });

//     //* Update hike to local storage
//     on<_Update>((event, emit) {
//       emit(const CreateUpdateHikeState.loading());
//     });
//   }
// }
