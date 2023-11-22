part of 'detail_hike_bloc.dart';

@freezed
class DetailHikeState with _$DetailHikeState {
  const factory DetailHikeState(Hike hike,
      {Function(GoogleMapController)? onCreateMap}) = _DetailHikeState;
}
