import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiKantorPage extends StatefulWidget {
  const LokasiKantorPage({super.key});

  @override
  State<LokasiKantorPage> createState() =>
      _LokasiKantorPageState();
}

class _LokasiKantorPageState
    extends State<LokasiKantorPage> {
  static const LatLng lokasiAwal =
      LatLng(-6.914744, 107.609810);

  final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('kantor_pusat'),
      position: LatLng(-6.914744, 107.609810),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Pusat',
      ),
    ),
    const Marker(
      markerId: MarkerId('kantor_utara'),
      position: LatLng(-6.904744, 107.609810),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Utara',
      ),
    ),
    const Marker(
      markerId: MarkerId('kantor_selatan'),
      position: LatLng(-6.924744, 107.609810),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Selatan',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: lokasiAwal,
          zoom: 13,
        ),
        markers: markers,
      ),
    );
  }
}