import 'package:evently/core/resources/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:evently/ui/home/tabs/map_tab/providers/map_tab_provider.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    MapTabProvider provider = Provider.of<MapTabProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: provider.cameraPosition,
              mapType: MapType.normal,
              markers: provider.markers,
              onMapCreated: (controller) {
                provider.mapController = controller;
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.getUserLocation();
        },
        // shape: RoundedRectangleBorder(
        //  borderRadius: BorderRadiusGeometry.circular(12),
        //),
        backgroundColor: ColorsManager.primaryColor,
        foregroundColor: ColorsManager.lightBackgroundColor,
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
