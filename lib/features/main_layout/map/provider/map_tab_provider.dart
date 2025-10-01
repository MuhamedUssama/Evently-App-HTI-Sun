import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTabProvider extends ChangeNotifier {
  Location location = Location();

  MapTabProvider() {
    log('Mab Tab provider created');
    getUserLocation();
    setLocationListener();
  }

  Set<Marker> markers = {};

  late GoogleMapController mapController;

  late final StreamSubscription<LocationData> _locationStream;

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );

  Future<bool> _getLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }

    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkLocationServices() async {
    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    return serviceEnabled;
  }

  Future<void> getUserLocation() async {
    bool permissionGranted = await _getLocationPermission();

    if (!permissionGranted) return;

    bool isServceEnabled = await _checkLocationServices();

    if (!isServceEnabled) return;

    LocationData locationData = await location.getLocation();

    _changeLocationOnMap(locationData);

    notifyListeners();
  }

  void setLocationListener() {
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);

    _locationStream = location.onLocationChanged.listen((
      LocationData locationData,
    ) {
      _changeLocationOnMap(locationData);
      notifyListeners();
    });
  }

  void _changeLocationOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 17,
    );

    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
        infoWindow: InfoWindow(
          title: 'My location',
          snippet: 'This is marker no.1',
        ),
      ),
    );

    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  void dispose() {
    mapController.dispose();
    _locationStream.cancel();
    log('MabTab Provider Disposed');
    super.dispose();
  }
}
