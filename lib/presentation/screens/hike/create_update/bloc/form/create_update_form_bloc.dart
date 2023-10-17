import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:m_hike/common/extension/string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_hike/common/utils.dart';
import 'package:m_hike/domain/models/image.dart';

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
          nameHike: event.nameHike ?? '',
          locationHike: event.locationHike ?? '',
          startDate: event.startDate,
          isParking: event.isParking ?? false,
          distanceHike: event.distanceHike ?? 0,
          levelDifficult: event.levelDifficult ?? 1,
          description: event.description ?? '',
          estimateCompleteTime: event.estimateCompleteTime ?? 0,
          imagesPath: event.imagesPath ?? <ImageLocal>[],
          startLocation: event.startLocation ?? ''));
    });

    //* Update fields data with current data
    on<CreateUpdateHikeFormEvent>((event, emit) async {
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
        emit(state.copyWith(isParking: event.value == 1));
      }
      if (event is _DistanceHikeChanged) {
        emit(state.copyWith(distanceHike: event.value));
      }
      if (event is _LevelDifficultChanged) {
        emit(state.copyWith(levelDifficult: event.value));
      }
      if (event is _ImagesPathChanged) {
        final ImagePicker picker = ImagePicker();
        if (event.isCamera) {
          XFile? image = await picker.pickImage(source: ImageSource.camera);
          if (image == null) {
            return;
          }
          final Uint8List imagesPath = await image.readAsBytes();
          List<ImageLocal> imageCopyWith = [];
          imageCopyWith.add(ImageLocal(image: imagesPath.toList()));
          emit(state
              .copyWith(imagesPath: [...state.imagesPath, ...imageCopyWith]));
        } else {
          List<XFile> images = await picker.pickMultiImage();
          List<ImageLocal> imagesFormat = [];
          for (final image in images) {
            final listIneImage = await image.readAsBytes();
            imagesFormat.add(ImageLocal(image: listIneImage.toList()));
          }
          emit(state
              .copyWith(imagesPath: [...state.imagesPath, ...imagesFormat]));
        }
      }
      if (event is _StartLocationChanged) {
        emit(state.copyWith(startLocation: event.value));
      }
      if (event is _DescriptionChanged) {
        emit(state.copyWith(description: event.value));
      }
      if (event is _RemoveImage) {
        state.imagesPath.removeAt(event.index);
        emit(state.copyWith(imagesPath: state.imagesPath));
      }
    });

    //* Create new or update hike to local storage

    on<_CreateOrUpdateHike>((event, emit) {
      if (event.id == null) {
      } else {}
    });
  }
  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 
  return await Geolocator.getCurrentPosition();
}

//  void getNearbyPlaces() async {

//     var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ','
//     + longitude.toString() + '&radius=' + radius + '&key=' + apiKey
//     );

//     var response = await http.post(url);

//     nearbyPlacesResponse = NearbyPlacesResponse.fromJson(jsonDecode(response.body));

//   }
}
