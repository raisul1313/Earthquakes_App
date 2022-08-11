import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowSimpleMap extends StatefulWidget {
  const ShowSimpleMap({Key? key}) : super(key: key);

  @override
  State<ShowSimpleMap> createState() => _ShowSimpleMapState();
}

class _ShowSimpleMapState extends State<ShowSimpleMap> {
  late GoogleMapController mapController;
  static LatLng _center = const LatLng(23.7508090983811, 90.39362394532306);
  static LatLng _anotherLoaction = const LatLng(23.814867, 90.379406);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToIntel,
        label: Text("Mirpur 10"),
        icon: Icon(Icons.place),
      ),
      body: GoogleMap(
          markers: {officeMarker, homeMarker},
          mapType: MapType.terrain,
          onMapCreated: _onMapCreated,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(target: _center, zoom: 11.0)),
    );
  }

  static final CameraPosition mirpur10Position = CameraPosition(
      target: LatLng(23.8069294, 90.3665091),
      zoom: 14.0,
      tilt: 1.0,
      bearing: 1.0);

  Future<void> _goToIntel() async {
    final GoogleMapController controller = await mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(mirpur10Position));
  }

  Marker officeMarker = Marker(
      markerId: MarkerId("Office"),
      position: _center,
      infoWindow: InfoWindow(title: "Office", snippet: "This is my office"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));

  Marker homeMarker = Marker(
      markerId: MarkerId("Home"),
      position: _anotherLoaction,
      infoWindow: InfoWindow(title: "Home", snippet: "This is my home"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
}
