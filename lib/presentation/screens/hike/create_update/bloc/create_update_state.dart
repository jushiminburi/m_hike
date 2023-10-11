part of 'create_update_bloc.dart';

@freezed
class CreateUpdateHikeState with _$CreateUpdateHikeState {
  const factory CreateUpdateHikeState.init() = _initial;
  const factory CreateUpdateHikeState.loading() = _loading;
  const factory CreateUpdateHikeState.saved() = _saved;
  const factory CreateUpdateHikeState.error(String? message) = _error;
}
