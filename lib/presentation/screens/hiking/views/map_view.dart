import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:m_hike/common/constants.dart/app_image.dart';
import 'package:m_hike/data/remote/maps/place_repository.dart';
import 'package:m_hike/domain/models/hike.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, required this.hike});
  final Hike hike;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Location _locationController = Location();
  Hike get hike => widget.hike;
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
  LatLng _currentP = const LatLng(0.0, 0.0);
  Map<PolylineId, Polyline> polylines = {};
  @override
  void initState() {
    super.initState();
    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) => {
              generatePolyLineFromPoints(coordinates),
            }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
          target: LatLng(hike.coordinatePlaceOfOrigin?.lat ?? 0,
              hike.coordinatePlaceOfOrigin?.lng ?? 0)),
      onMapCreated: _mapController.complete,
      markers: {
        Marker(
          markerId: const MarkerId("_currentLocation"),
          icon: icon,
          position: _currentP,
        ),
        Marker(
            markerId: const MarkerId("_sourceLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(hike.coordinatePlaceOfOrigin?.lat ?? 0,
                hike.coordinatePlaceOfOrigin?.lng ?? 0)),
        Marker(
            markerId: const MarkerId("_destionationLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(hike.coordinateDestination?.lat ?? 0,
                hike.coordinateDestination?.lng ?? 0))
      },
      polylines: Set<Polyline>.of(polylines.values),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      key,
      PointLatLng(hike.coordinatePlaceOfOrigin?.lat ?? 0,
          hike.coordinatePlaceOfOrigin?.lng ?? 0),
      PointLatLng(hike.coordinatePlaceOfOrigin?.lat ?? 0,
          hike.coordinatePlaceOfOrigin?.lng ?? 0),
      travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      debugPrint(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 4);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
