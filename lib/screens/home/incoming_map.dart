import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:marker_icon/marker_icon.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/helpers/loading_screen.dart';
import 'package:mechanic/helpers/time_helper.dart';
import 'package:mechanic/models/analytics_model.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/models/user_model.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/providers/chat_provider.dart';
import 'package:mechanic/providers/location_provider.dart';
import 'package:mechanic/screens/chat/chat_room.dart';
import 'package:mechanic/screens/mechanic_profile/mechanic_profile_screen.dart';
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
            size: (size.height * .12).toInt(),
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
    Future.delayed(Duration.zero, () async {
      await Provider.of<AuthProvider>(context, listen: false)
          .getCurrentUser(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false).getCurrentLocation();
    var _locationData = Provider.of<LocationProvider>(
      context,
    ).locationData;

    mapController?.animateCamera(
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
            body: Stack(
            children: [
              GoogleMap(
                markers: _markers,
                onMapCreated: _onMapCreated,
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        _locationData.latitude!, _locationData.longitude!),
                    zoom: 15),
              ),
              Positioned(
                  left: 15,
                  right: 15,
                  top: 10,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  widget.request.mechanic!.profile!)),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.request.mechanic!.name}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Incoming     -${getCreatedAt(widget.request.createdAt!)}',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 13),
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              final users = Provider.of<ChatProvider>(context,
                                      listen: false)
                                  .contactedUsers;
                              List<String> room = users.map<String>((e) {
                                return e.chatRoomId!.contains(
                                        FirebaseAuth.instance.currentUser!.uid +
                                            '_' +
                                            widget.request.mechanic!.id!)
                                    ? FirebaseAuth.instance.currentUser!.uid +
                                        '_' +
                                        widget.request.mechanic!.id!
                                    : widget.request.mechanic!.id! +
                                        '_' +
                                        FirebaseAuth.instance.currentUser!.uid;
                              }).toList();

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.request.mechanic!.id)
                                  .get()
                                  .then((value) {
                                Navigator.of(context)
                                    .pushNamed(ChatRoom.routeName, arguments: {
                                  'user': UserModel(
                                    userId: value['userId'],
                                    fullName: value['fullName'],
                                    imageUrl: value['profilePic'],
                                    isMechanic: value['isMechanic'],
                                    lastSeen: value['lastSeen'],
                                    isOnline: value['isOnline'],
                                    email: value['email'],
                                    phoneNumber: value['phoneNumber'],
                                  ),
                                  'chatRoomId': room.isEmpty
                                      ? FirebaseAuth.instance.currentUser!.uid +
                                          '_' +
                                          widget.request.mechanic!.id!
                                      : room.first,
                                });
                              });
                            },
                            child: const Icon(
                              FontAwesomeIcons.comment,
                              size: 22,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              bool? res =
                                  await FlutterPhoneDirectCaller.callNumber(
                                      widget.request.mechanic!.phone!);

                              if (res == false) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('Oops could not make phone call'),
                                ));
                              }
                            },
                            child: const Icon(
                              Icons.call,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ));
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
      Get.off(() => IncomingMapScreen(
            request: widget.request,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void cancelRequest(BuildContext context, RequestModel request) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Center(
                child: Text('Delete ${request.mechanic!.name!} Request',
                    style: const TextStyle(color: Colors.black))),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/cancel.json',
                    height: 100,
                  ),
                  const Text(
                      'This may affect how fast other mechanics will accept your requests.Notice that this action is irreversible. Do you want to continue?',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey)),
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
