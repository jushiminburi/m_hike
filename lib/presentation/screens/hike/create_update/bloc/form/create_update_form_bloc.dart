import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:m_hike/common/extension/string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_hike/common/utils.dart';
import 'package:m_hike/data/remote/maps/place_repository.dart';
import 'package:m_hike/domain/models/coordinate.dart';
import 'package:path/path.dart' as p;
import 'package:m_hike/domain/models/maps/search_place.dart';
import 'package:geocoding/geocoding.dart';
import 'package:path_provider/path_provider.dart';

part 'create_update_form_event.dart';
part 'create_update_form_state.dart';
part 'create_update_form_bloc.freezed.dart';

@injectable
class CreateUpdateFormBloc
    extends Bloc<CreateUpdateHikeFormEvent, CreateUpdateHikeFormState> {
  CreateUpdateFormBloc(this._placesRepository)
      : super(CreateUpdateHikeFormState()) {
    //* Initialize form data
    on<_Init>((event, emit) async {
      final position = await _determinePosition();
      Coordinate coordinateOrigin = const Coordinate();
      String startingPlace = '';
      if (event.startHikeController?.text == null) {
        coordinateOrigin =
            Coordinate(lat: position.latitude, lng: position.longitude);
        startingPlace = await _getAddressFromLatLng(position);
      }

      emit(CreateUpdateHikeFormState(
        isarId: event.isarId,
        nameHike: event.nameHike ?? '',
        locationHikeController:
            event.locationHikeController ?? TextEditingController(text: ''),
        startHikeController: event.startHikeController ??
            TextEditingController(text: startingPlace),
        coordinatePlaceOrigin: coordinateOrigin,
        startDate: event.startDate,
        isParking: event.isParking ?? false,
        distanceHike: event.distanceHike ?? 0,
        levelDifficult: event.levelDifficult ?? 1,
        description: event.description ?? '',
        estimateCompleteTime: event.estimateCompleteTime ?? 0,
        imagesPath: event.imagesPath ?? <String>[],
      ));
    });

    //* Update fields data with current data
    on<CreateUpdateHikeFormEvent>((event, emit) async {
      if (event is _NameChanged) {
        emit(state.copyWith(nameHike: event.value));
      }
      if (event is _ListLocation) {
        if (event.value.isNotEmpty) {
          final result =
              await _placesRepository.getDataPlacesAutoComplete(event.value);
          emit(state.copyWith(locationNameSuggest: result));
        } else {
          emit(state.copyWith(locationNameSuggest: null));
        }
      }
      if (event is _LocationChanged) {
        final result =
            await _placesRepository.getDataPlace(event.value.placeId);
        emit(state.copyWith(
            locationHikeController:
                TextEditingController(text: event.value.description),
            coordinateDestination: Coordinate(
                lat: result.geometry.location.lat,
                lng: result.geometry.location.lng),
            locationNameSuggest: null));
      }
      if (event is _ListStartLocation) {
        if (event.value.isNotEmpty) {
          final result =
              await _placesRepository.getDataPlacesAutoComplete(event.value);
          emit(state.copyWith(locationStartNameSuggest: result));
        } else {
          emit(state.copyWith(locationStartNameSuggest: null));
        }
      }
      if (event is _LocationStartChanged) {
        final result =
            await _placesRepository.getDataPlace(event.value.placeId);
        emit(state.copyWith(
            startHikeController:
                TextEditingController(text: event.value.description),
            coordinatePlaceOrigin: Coordinate(
                lat: result.geometry.location.lat,
                lng: result.geometry.location.lng),
            locationStartNameSuggest: null));
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

          List<String> imageCopyWith = [];
          imageCopyWith.add(image.path);
          emit(state
              .copyWith(imagesPath: [...state.imagesPath, ...imageCopyWith]));
        } else {
          List<XFile> images = await picker.pickMultiImage();
          List<String> imagesFormat = [];
          for (final image in images) {
            imagesFormat.add(image.path);
          }
          emit(state
              .copyWith(imagesPath: [...state.imagesPath, ...imagesFormat]));
        }
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

  Future<String> _getAddressFromLatLng(Position position) async {
    String placeName = '';
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      placeName =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}';
    }).catchError((e) {
      debugPrint(e);
    });
    return placeName;
  }

  Future<String> saveImagePermanently(String? imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = p.basename(imagePath!);
    return '${directory.path}/$name';
  }

  final PlacesRepository _placesRepository;
}
