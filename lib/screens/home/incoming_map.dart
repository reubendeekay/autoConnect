import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:marker_icon/marker_icon.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/helpers/loading_screen.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/providers/location_provider.dart';
import 'package:provider/provider.dart';

class IncomingMapScreen extends StatefulWidget {
  const IncomingMapScreen({Key? key, required this.request}) : super(key: key);
  final RequestModel request;

  @override
  State<IncomingMapScreen> createState() => _IncomingMapScreenState();
}

class _IncomingMapScreenState extends State<IncomingMapScreen> {
  GoogleMapController? mapController;

  Set<Marker> _markers = <Marker>{};
  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    mapController!.setMapStyle(value);

    final size = MediaQuery.of(context).size;

    //for loop to map markers in different locations

    _markers.add(
      Marker(
        markerId: MarkerId(widget.request.id!),
        onTap: () {},
        //circle to show the mechanic profile in map
        icon: await MarkerIcon.downloadResizePictureCircle(
            widget.request.mechanic!.profile!,
            size: (size.height * .1).toInt(),
            borderSize: 10,
            addBorder: true,
            borderColor: kPrimaryColor),
        position: LatLng(widget.request.mechanic!.location!.latitude,
            widget.request.mechanic!.location!.longitude),
      ),
    );

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false).getCurrentLocation();
    var _locationData = Provider.of<LocationProvider>(
      context,
    ).locationData;

    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(widget.request.mechanic!.location!.latitude,
              widget.request.mechanic!.location!.longitude),
          zoom: 15,
        ),
      ),
    );
    return _locationData == null
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Mechanic in Transit',
              ),
              backgroundColor: kPrimaryColor,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: GoogleMap(
              markers: _markers,
              onMapCreated: _onMapCreated,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target:
                      LatLng(_locationData.latitude!, _locationData.longitude!),
                  zoom: 15),
            ),
          );
  }
}

class MapContainer extends StatefulWidget {
  const MapContainer({Key? key, required this.request}) : super(key: key);

  final RequestModel request;

  @override
  State<MapContainer> createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Get.offAll(() => IncomingMapScreen(
            request: widget.request,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void deleteDialog(BuildContext context, RequestModel request) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Center(
                child: Text('Delete ${request.mechanic!.name!} Request',
                    style: const TextStyle(color: Colors.white))),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/delete.json',
                    height: 100,
                  ),
                  const Text(
                      'This may affect how fast other mechanics will accept your requests.Notice that this action is irreversible. Do you want to continue?',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              const SizedBox(
                width: 120,
              ),
              GestureDetector(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection('requests')
                      .doc('mechanics')
                      .collection(request.mechanic!.id!)
                      .doc(request.id!)
                      .update({'status': 'cancelled'});
                  await FirebaseFirestore.instance
                      .collection('userData')
                      .doc('bookings')
                      .collection(uid)
                      .doc(request.id!)
                      .update({'status': 'cancelled'});
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                width: 25,
              )
            ],
          ));
}
