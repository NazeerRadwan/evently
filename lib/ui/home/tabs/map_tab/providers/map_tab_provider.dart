import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTabProvider extends ChangeNotifier {
  MapTabProvider() {
    log('get Location in constructor');
    getUserLocation();
    // setLocationListener();
  }

  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.4219983, -122.084),
    zoom: 17,
  );

  Set<Marker> markers = {};

  final Location location = Location();
  late final StreamSubscription<LocationData> _locationStram;
  //String locationMessage = "";

  Future<bool> _getLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkLocationService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  void changeCameraPositionOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 17,
    );

    markers.add(
      Marker(
        markerId: const MarkerId("1"),
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
        infoWindow: const InfoWindow(
          title: "My location",
          snippet: "This is marker 1",
        ),
      ),
    );

    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void setLocationListener() {
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 500);

    _locationStram = location.onLocationChanged.listen((
      LocationData currentLocation,
    ) {
      changeCameraPositionOnMap(currentLocation);
      notifyListeners();
    });
  }

  Future<void> getUserLocation() async {
    bool isPermissionGranted = await _getLocationPermission();

    if (!isPermissionGranted) {
      //locationMessage = "Permission is denied.";
      //notifyListeners();
      return;
    }

    bool isGpsServiceEnabled = await _checkLocationService();

    if (!isGpsServiceEnabled) {
      //locationMessage = "GPS not enabled";
      //notifyListeners();
      return;
    }
    //locationMessage = "Getting location now...";
    //notifyListeners();

    LocationData locationData = await location.getLocation();

    changeCameraPositionOnMap(locationData);
    //locationMessage = "Latitude: ${userLocation.latitude}, Longitude: ${userLocation.longitude}";
    notifyListeners();
  }

  @override
  void dispose() {
    mapController.dispose();
    _locationStram.cancel();
    log("Provider disposed");
    super.dispose();
  }
}
