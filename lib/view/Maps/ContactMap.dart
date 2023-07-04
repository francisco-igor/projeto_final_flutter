import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/repositories.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import '../Drawer/Drawer.dart';
import 'package:http/http.dart' as http;

class ContactMap extends StatefulWidget {
  const ContactMap({Key? key});

  @override
  State<ContactMap> createState() => _ContactMapState();
}

class _ContactMapState extends State<ContactMap> {
  late CameraPosition _startPosition;
  late CameraPosition _lastPosition;
  late Position _position;
  LatLng? latLong;

  late List<Marker> markers = [];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  void _onMapTapped(LatLng position) {
    setState(() {
      latLong = position;
    });

    _lastPosition = CameraPosition(
      target: LatLng(latLong!.latitude, latLong!.longitude),
      zoom: 16,
    );
  }

  void requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
  }

  void _myLocation() async {
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _startPosition = CameraPosition(
        target: LatLng(_position.latitude, _position.longitude),
        zoom: 16,
      );
    });

    _loadMarkers();
  }

  void _loadMarkers() async {
    List<Marker> localMarkers = [];
    Marker currentMarker = Marker(
      markerId: const MarkerId('aqui'),
      position: _startPosition.target,
      infoWindow: const InfoWindow(title: 'Local Atual'),
      onTap: () {
        setState(() {
          latLong = _startPosition.target;
        });
      },
    );
    localMarkers.add(currentMarker);
    setState(() {
      markers = localMarkers;
    });
  }

  @override
  void initState() {
    super.initState();
    _myLocation();
    _fetchContacts();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapinha Maroto'),
        centerTitle: true,
      ),
      drawer: const SideBar(),
      body: FutureBuilder<void>(
        future: _controller.future,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return GoogleMap(
              initialCameraPosition: _startPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: _onMapTapped,
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: Set<Marker>.from(markers),
            );
          } else {
            return const Center(
              child: Text('Erro ao carregar o mapa.'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToBeginning,
        label: const Text('Anterior'),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Future<void> _goToBeginning() async {
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_lastPosition));
  }

  void _fetchContacts() async {
    final List<Map<String, dynamic>> contacts = await UserDatabase().getUsers();
    final List<Marker> newMarkers = [];

    for (final contact in contacts) {
      final String location = contact['location'] as String;

      final LatLng? latLng = await getLatLngFromAddress(location);

      if (latLng != null) {
        final Marker marker = Marker(
          markerId: MarkerId(contact['id'].toString()),
          position: latLng,
        );

        newMarkers.add(marker);
      }
    }
    setState(() {
      markers = newMarkers;
    });
  }

  Future<LatLng?> getLatLngFromAddress(String address) async {
    final String url =
        'https://nominatim.openstreetmap.org/search?q=$address&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);

        return LatLng(lat, lon);
      }
    }

    return null;
  }
}
