import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:marker_icon/marker_icon.dart';
import 'package:mechanic/helpers/constants.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mechanic/helpers/loading_screen.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/providers/chat_provider.dart';
import 'package:mechanic/providers/location_provider.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:mechanic/screens/home/arrived_widget.dart';
import 'package:mechanic/screens/home/cancelled_widget.dart';
import 'package:mechanic/screens/home/incoming_map.dart';
import 'package:mechanic/screens/home/review_container.dart';
import 'package:mechanic/screens/home/selected_mechanic.dart';
import 'package:mechanic/screens/home/widgets/map_appbar.dart';
import 'package:mechanic/screens/payment/widgets/initialize_payment.dart';
import 'package:mechanic/screens/payment/widgets/updated_payment.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key, this.opendrawer}) : super(key: key);
  VoidCallback? opendrawer;
  static const routeName = '/home';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  GoogleMapController? mapController;

  Set<Marker> _markers = <Marker>{};
  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    mapController!.setMapStyle(value);

    await Provider.of<MechanicProvider>(context, listen: false).getMechanics();
    final mechanics =
        Provider.of<MechanicProvider>(context, listen: false).mechanics;
    final size = MediaQuery.of(context).size;

    //for loop to map markers in different locations
    for (var mechanic in mechanics!) {
      _markers.add(
        Marker(
          markerId: MarkerId(mechanic.id!),
          onTap: () {
            mapMechanicPrompt(context, mechanic);
          },
          //circle to show the mechanic profile in map
          icon: await MarkerIcon.downloadResizePictureCircle(mechanic.profile!,
              size: (size.height * .13).toInt(),
              borderSize: 10,
              addBorder: true,
              borderColor: kPrimaryColor),
          position:
              LatLng(mechanic.location!.latitude, mechanic.location!.longitude),
        ),
      );
    }

    setState(() {});
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero).then((_) async {});
  // }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false).getCurrentLocation();
    var _locationData = Provider.of<LocationProvider>(
      context,
    ).locationData;

    final size = MediaQuery.of(context).size;
    Provider.of<AuthProvider>(context, listen: false)
        .getCurrentUser(FirebaseAuth.instance.currentUser!.uid);
    Provider.of<ChatProvider>(context, listen: false).getChats();

    return Scaffold(
      key: _key,
      // drawer: const SideDrawer(),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('userData')
                .doc('bookings')
                .collection(FirebaseAuth.instance.currentUser!.uid)
                .orderBy(
                  'createdAt',
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> allDocs = snapshot.data!.docs;
                if (allDocs
                    .where((element) => element['status'] == 'arrived')
                    .isNotEmpty) {
                  return const ArrivedWidget();
                }

                if (allDocs
                    .where((element) => element['status'] == 'denied')
                    .isNotEmpty) {
                  final myDocs = allDocs
                      .where((element) => element['status'] == 'denied')
                      .toList();
                  final RequestModel request = RequestModel.fromJson(myDocs[0]);
                  return CancelledWidget(request: request, isDenied: true);
                }
                if (allDocs
                    .where((element) => element['status'] == 'cancelled')
                    .isNotEmpty) {
                  final myDocs = allDocs
                      .where((element) => element['status'] == 'cancelled')
                      .toList();
                  final RequestModel request = RequestModel.fromJson(myDocs[0]);
                  return CancelledWidget(request: request);
                }

                if (allDocs
                    .where((element) => element['status'] == 'updated')
                    .isNotEmpty) {
                  final myDocs = allDocs
                      .where((element) => element['status'] == 'updated')
                      .toList();
                  return UpdatedPaymentContainer(
                      request: RequestModel.fromJson(myDocs.first));
                }
                if (allDocs
                    .where((element) => element['status'] == 'paid')
                    .isNotEmpty) {
                  final myDocs = allDocs
                      .where((element) => element['status'] == 'paid')
                      .toList();
                  return ReviewContainer(
                      request: RequestModel.fromJson(myDocs.first));
                }

                if (allDocs
                    .where((element) => element['status'] == 'completed')
                    .isNotEmpty) {
                  final myDocs = allDocs
                      .where((element) => element['status'] == 'completed')
                      .toList();
                  return InitializePayment(
                      request: RequestModel.fromJson(myDocs.first));
                }

                if (allDocs
                    .where((element) => element['status'] == 'ongoing')
                    .isNotEmpty) {
                  final myDocs = allDocs
                      .where((element) => element['status'] == 'ongoing')
                      .toList();
                  return IncomingMapScreen(
                      request: RequestModel.fromJson(myDocs.first));
                }
              }

              return Stack(
                children: [
                  // MyMarker(globalKey),
                  _locationData == null
                      ? const LoadingScreen()
                      : GoogleMap(
                          markers: _markers,
                          onMapCreated: _onMapCreated,
                          mapType: MapType.normal,
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: true,
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(_locationData.latitude!,
                                  _locationData.longitude!),
                              zoom: 15),
                        ),

                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Row(
                      children: [
                        Container(
                          color: Colors.white,
                          margin: const EdgeInsets.all(5.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: widget.opendrawer,
                                child: const Icon(
                                  Icons.menu,
                                  color: Colors.grey,
                                  size: 25,
                                )),
                          ),
                        ),
                        const MapAppBar(),
                      ],
                    ),
                  ),
                  // const Positioned(
                  //   bottom: 15,
                  //   left: 0,
                  //   right: 0,
                  //   child: BottomMapWidget(),
                  // )
                ],
              );
            }),
      ),
    );
  }
}

void mapMechanicPrompt(BuildContext context, MechanicModel mechanic) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return SelectedMechanicPrompt(mechanic: mechanic);
      });
}
