import 'dart:async';
import 'dart:math';

import 'package:aksesin/data/datasource/map_service.dart';
import 'package:aksesin/presentation/provider/maps_provider.dart';
import 'package:aksesin/presentation/view/akses_jalan_detail/BottomPlaceInfo.dart';
import 'package:aksesin/presentation/view/akses_jalan_detail/akses_teman_dialog.dart';
import 'package:aksesin/presentation/view/akses_jalan_detail/cuaca_dialog.dart';
import 'package:aksesin/presentation/view/akses_jalan_detail/kondisi_dialog.dart';
import 'package:aksesin/presentation/view/akses_jalan_detail/route_bottom_section.dart';
import 'package:aksesin/presentation/view/akses_jalan_detail/sos_dialog.dart';
import 'package:aksesin/presentation/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MapView extends StatefulWidget {
  final String? destinationAddress;
  final String? userId;

  MapView({this.destinationAddress, this.userId});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(-6.1747525534221595, 106.82719276918434));
  late GoogleMapController mapController;

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final destinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  String? _placeDistance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController _scrollController = ScrollController();

  late MapService _mapService;

  bool _showRouteBottomSection = false;

  late StreamSubscription<Position> _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    dotenv.load(); 
    _mapService = MapService();
    _getCurrentLocation();

    if (widget.userId != null) {
      _setDestinationToUserLocation(widget.userId!);
    } else if (widget.destinationAddress != null) {
      destinationAddressController.text = widget.destinationAddress!;
      _destinationAddress = widget.destinationAddress!;
    }

    _positionStreamSubscription = Geolocator.getPositionStream(
    ).listen((Position position) {
      Provider.of<MapsProvider>(context, listen: false).setCurrentPosition(position);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );
      _getAddress();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        _showBottomSheet(context);
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        _showBottomSheet(context);
      }
    });
  }

  Future<void> _setDestinationToUserLocation(String userId) async {
    FirebaseFirestore.instance.collection('user_locations').doc(userId).snapshots().listen((doc) {
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          final latitude = data['latitude'];
          final longitude = data['longitude'];
          setState(() {
            _destinationAddress = '$latitude, $longitude';
            destinationAddressController.text = _destinationAddress;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Icon prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.9,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Provider.of<MapsProvider>(context, listen: false).setCurrentPosition(position);
    await Provider.of<MapsProvider>(context, listen: false).updateUserLocationInFirestore();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18.0,
        ),
      ),
    );
    await _getAddress();
  }

  _getAddress() async {
    try {
      Position _currentPosition = Provider.of<MapsProvider>(context, listen: false).currentPosition;
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      String _currentAddress =
          "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      Provider.of<MapsProvider>(context, listen: false).setCurrentAddress(_currentAddress);
      startAddressController.text = _currentAddress;
      _startAddress = _currentAddress;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _calculateDistance() async {
    try {
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark =
          await locationFromAddress(_destinationAddress);

      Position _currentPosition = Provider.of<MapsProvider>(context, listen: false).currentPosition;
      double startLatitude = _startAddress == startAddressController.text
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = _startAddress == startAddressController.text
          ? _currentPosition.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      Provider.of<MapsProvider>(context, listen: false).addMarker(startMarker);
      Provider.of<MapsProvider>(context, listen: false).addMarker(destinationMarker);

      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;

      List<LatLng> polylineCoordinates = Provider.of<MapsProvider>(context, listen: false).polylineCoordinates;
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
        _showRouteBottomSection = true;
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    PolylineResult result = await _mapService.getRouteBetweenCoordinates(
      dotenv.env['GOOGLE_MAPS_API_KEY']!, 
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      TravelMode.walking,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        Provider.of<MapsProvider>(context, listen: false).polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    print("GAJELAS");
    print(result.errorMessage);
    print(result.points);
    print(result.status);
    
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: Provider.of<MapsProvider>(context, listen: false).polylineCoordinates,
      width: 3,
    );
    Provider.of<MapsProvider>(context, listen: false).addPolyline(polyline);
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _destinationAddress,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text('$_placeDistance km'),
              Text(
                'Ringkasan ulasan',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(Icons.sentiment_very_satisfied, color: Colors.green),
                      Text('Sangat Baik'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.sentiment_satisfied, color: Colors.lightGreen),
                      Text('Baik'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.sentiment_neutral, color: Colors.amber),
                      Text('Buruk'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.sentiment_very_dissatisfied, color: Colors.red),
                      Text('Sangat Buruk'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Ahmad Kiran\nPetunjuk arah yang diberikan sangat jelas dan akurat. Sebagai pengguna kursi roda saya merasa perjalanan jauh lebih mudah dan aman.',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Viviane Angeli\nSebagai tunanetra, saya sangat terbantu. Rute yang direkomendasikan juga mempertimbangkan jalur yang aman dan mudah dilalui. Keren!',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      context.pop();
                    } catch (e) {
                        context.go('/home');
                    }
                  },
                  child: Text(
                    'Mulai Perjalanan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              markers: Provider.of<MapsProvider>(context).markers,
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              polylines: Provider.of<MapsProvider>(context).polylines.values.toSet(),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                try {
                                  context.pop();
                                } catch (e) {
                                    context.go('/home'); 
                                }
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.red),
                              SizedBox(width: 10),
                              Expanded(
                                child: _textField(
                                  label: 'Lokasi Anda',
                                  hint: 'Choose starting point',
                                  prefixIcon: Icon(Icons.looks_one),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.my_location),
                                    onPressed: () {
                                      startAddressController.text = Provider.of<MapsProvider>(context, listen: false).currentAddress;
                                      _startAddress = Provider.of<MapsProvider>(context, listen: false).currentAddress;
                                      mapController.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                            target: LatLng(
                                              Provider.of<MapsProvider>(context, listen: false).currentPosition.latitude,
                                              Provider.of<MapsProvider>(context, listen: false).currentPosition.longitude,
                                            ),
                                            zoom: 18.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  controller: startAddressController,
                                  focusNode: startAddressFocusNode,
                                  width: width,
                                  locationCallback: (String value) {
                                    setState(() {
                                      _startAddress = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.blue),
                              SizedBox(width: 10),
                              Expanded(
                                child: _textField(
                                  label: 'Tujuan anda',
                                  hint: 'Choose destination',
                                  prefixIcon: Icon(Icons.looks_two),
                                  controller: destinationAddressController,
                                  focusNode: destinationAddressFocusNode,
                                  width: width,
                                  locationCallback: (String value) {
                                    setState(() {
                                      _destinationAddress = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _showRouteBottomSection
                      ? [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0, bottom: 100.0),
                            child: ClipOval(
                              child: Material(
                                color: Colors.red,
                                child: InkWell(
                                  splashColor: Colors.red,
                                  child: SizedBox(
                                    width: 65,
                                    height: 65,
                                    child: Icon(Icons.sos, color: Colors.white),
                                  ),
                                  onTap: () async {
                                    final user = FirebaseAuth.instance.currentUser;
                                    if (user != null) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          print("INI USER ID : ${user.uid}");
                                          return SosDialog(userId: user.uid, status: true);
                                        },
                                      );
                                    } else {
                                      print("KALO MASIH NULL KOCAK SIH.");
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]
                      : [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                            child: ClipOval(
                              child: Material(
                                color: Colors.orange.shade100,
                                child: InkWell(
                                  splashColor: Colors.orange,
                                  child: SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: Icon(Icons.traffic),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return KondisiDialog();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                            child: ClipOval(
                              child: Material(
                                color: Colors.orange.shade100,
                                child: InkWell(
                                  splashColor: Colors.orange,
                                  child: SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: Icon(Icons.cloud, color: Colors.white),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CuacaDialog();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0, bottom: 160.0),
                            child: ClipOval(
                              child: Material(
                                color: AppColors.primaryColor,
                                child: InkWell(
                                  splashColor: AppColors.primaryColor,
                                  child: SizedBox(
                                    width: 65,
                                    height: 65,
                                    child: Icon(Icons.wifi, color: Colors.white),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AksesTemanDialog();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                ),
              ),
            ),
            if (_showRouteBottomSection)
              Align(
                alignment: Alignment.bottomCenter,
                child: RouteBottomSection(
                  placeDistance: _placeDistance,
                  destination: _destinationAddress,
                ),
              )
            else
            BottomPlaceInfo(
              onStartJourney: () async {
                if (_startAddress != '' && _destinationAddress != '') {
                  startAddressFocusNode.unfocus();
                  destinationAddressFocusNode.unfocus();
                  Provider.of<MapsProvider>(context, listen: false).clearMarkers();
                  Provider.of<MapsProvider>(context, listen: false).clearPolylines();
                  Provider.of<MapsProvider>(context, listen: false).clearPolylineCoordinates();
                  _placeDistance = null;

                  _calculateDistance().then((isCalculated) {
                    if (isCalculated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Distance Calculated Sucessfully'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error Calculating Distance'),
                        ),
                      );
                    }
                  });
                }
              },
              destinationAddress: _destinationAddress,
              placeDistance: _placeDistance,
            ),
          ],
        ),
      ),
    );
  }
}