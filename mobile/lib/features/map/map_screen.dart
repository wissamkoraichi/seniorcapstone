import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  LatLng? _me;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final perm = await Permission.locationWhenInUse.request();
    if (!perm.isGranted) {
      setState(() => _error = "Location permission denied");
      return;
    }

    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      setState(() => _error = "Location services are off");
      return;
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final here = LatLng(pos.latitude, pos.longitude);
    setState(() => _me = here);

    _controller?.animateCamera(
      CameraUpdate.newLatLngZoom(here, 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    const fallback = LatLng(41.7508, -88.1535);

    return Scaffold(
      appBar: AppBar(title: const Text("Map")),
      body: _error != null
          ? Center(child: Text(_error!))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _me ?? fallback,
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (c) {
                _controller = c;
                if (_me != null) {
                  c.animateCamera(CameraUpdate.newLatLngZoom(_me!, 16));
                }
              },
            ),
    );
  }
}
