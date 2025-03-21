import 'dart:async';
import 'package:aksesin/domain/entities/user_loc.dart';
import 'package:aksesin/presentation/view/pendamping_page/sos_diterima_dialog.dart';
import 'package:aksesin/presentation/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:aksesin/domain/usecases/track_user.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:aksesin/presentation/view/akses_jalan_detail/route_bottom_section.dart';
import 'package:geocoding/geocoding.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';

class TrackTemanPage extends StatefulWidget {
  final String userId;

  const TrackTemanPage({super.key, required this.userId});

  @override
  State<TrackTemanPage> createState() => _TrackTemanPageState();
}

class _TrackTemanPageState extends State<TrackTemanPage> {
  late GoogleMapController _mapController;
  Marker? _trackingMarker;
  Set<Marker> _markers = {};
  StreamSubscription<UserLocation>? _locationSubscription;
  late TrackUserById _trackUserById;
  String? _locationName; 
  bool _isSosDialogOpen = false; 

  @override
  void initState() {
    super.initState();
    _trackUserById = Provider.of<TrackUserById>(context, listen: false);
    _startTracking();
    _checkSosStatus();
  }

  Future<void> _startTracking() async {
    await _locationSubscription?.cancel();
    final userId = widget.userId;
    _locationSubscription = _trackUserById(userId).listen((UserLocation location) async {
      _updateLocation(LatLng(location.latitude, location.longitude));
      await _updateLocationName(location.latitude, location.longitude); 
    });
  }

  Future<void> _checkSosStatus() async {
    FirebaseFirestore.instance.collection('user_locations').doc(widget.userId).snapshots().listen((doc) {
      if (doc.exists && doc.data()?['sos'] == true) {
        if (!_isSosDialogOpen) {
          _isSosDialogOpen = true;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SosDiterimaDialog(locationName: _locationName);
            },
          ).then((_) {
            _isSosDialogOpen = false;
          });
        }
      } else {
        if (_isSosDialogOpen) {
          Navigator.of(context, rootNavigator: true).pop();
          _isSosDialogOpen = false;
        }
      }
    });
  }

  Future<void> _updateLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          _locationName = placemarks.first.locality; 
        });
      }
    } catch (e) {
      print("EROR NIH BANG : $e");
    }
  }

  void _updateLocation(LatLng position) {
    setState(() {
      _trackingMarker = Marker(
        markerId: const MarkerId('tracking'),
        position: position,
        infoWindow: const InfoWindow(title: 'Current Location'),
      );
      _markers = {_trackingMarker!};
      _mapController.animateCamera(CameraUpdate.newLatLng(position));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), 
        child: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0), 
            child: Text(_locationName ?? 'Tracking Location...'),
          ),
          titleTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0),
          leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: const Icon(Icons.arrow_back, color: Colors.white),
              ), 
            onPressed: () => context.pop(),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.42796133580664, -122.085749655962),
              zoom: 14.0,
            ),
            markers: _markers,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RouteBottomSection(
              placeDistance: _locationName, 
              destination: 'Destination',
            ),
          ),
        ],
      ),
    );
  }
}