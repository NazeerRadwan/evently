import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evently/models/Event.dart';
import 'package:evently/core/resources/AssetsManager.dart';
import 'package:evently/core/resources/AppConstants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EventScreen extends StatefulWidget {
  final Event event;

  const EventScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    markers.add(
      Marker(
        markerId: MarkerId('eventLocation'),
        position: LatLng(
          widget.event.latitude ?? 30.0444,
          widget.event.longitude ?? 31.2357,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Event Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined),
            onPressed: () {
              // Handle edit event
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              // Handle delete event
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image or type icon
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Center(
                child: Image.asset(
                  eventImage[widget.event.type ?? 'sport'] ??
                      'assets/images/sport.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event title
                  Text(
                    widget.event.title ?? 'Event Title',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Date and time
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.calendar_today, color: Colors.blue),
                    ),
                    title: Text(
                      DateFormat('dd MMMM yyyy').format(
                        widget.event.dateTime?.toDate() ?? DateTime.now(),
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat('hh:mm a').format(
                        widget.event.dateTime?.toDate() ?? DateTime.now(),
                      ),
                    ),
                  ),

                  // Location
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    title: Text(
                      'Event Location',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text('Cairo, Egypt'),
                  ),

                  // Map
                  Container(
                    height: 200,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            widget.event.latitude ?? 30.0444,
                            widget.event.longitude ?? 31.2357,
                          ),
                          zoom: 15,
                        ),
                        onMapCreated: (controller) {
                          mapController = controller;
                        },
                        markers: markers,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: false,
                      ),
                    ),
                  ),

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.event.desc ?? 'No description available',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
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
