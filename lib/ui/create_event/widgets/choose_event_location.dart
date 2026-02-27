import 'package:evently/core/resources/ColorsManager.dart';
import 'package:evently/ui/create_event/provider/create_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseEventLocation extends StatefulWidget {
  final CreateEventProvider provider;
  const ChooseEventLocation({super.key, required this.provider});

  @override
  State<ChooseEventLocation> createState() => _ChooseEventLocationState();
}

class _ChooseEventLocationState extends State<ChooseEventLocation> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          initialCameraPosition: widget.provider.cameraPosition,
          onMapCreated: (controller) {
            mapController = controller;
            widget.provider.setMapController(controller);
          },
          markers: widget.provider.markers,
          onTap: (LatLng location) {
            widget.provider.changeEventLocation(location);
            widget.provider.convertLatLngForEvent();
            setState(() {});
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
