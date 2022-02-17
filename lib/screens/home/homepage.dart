import 'package:firebase_auth/firebase_auth.dart';
import 'package:marker_icon/marker_icon.dart';
import 'package:mechanic/helpers/constants.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mechanic/helpers/loading_screen.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/providers/location_provider.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:mechanic/screens/home/selected_mechanic.dart';
import 'package:mechanic/screens/home/widgets/bottom_map.dart';
import 'package:mechanic/screens/home/widgets/map_appbar.dart';
import 'package:mechanic/screens/home/widgets/my_marker.dart';
import 'package:mechanic/screens/side_drawer.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
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
          markerId: const MarkerId('1'),
          onTap: () {
            mapMechanicPrompt(context, mechanic);
          },
          //circle to show the mechanic profile in map
          icon: await MarkerIcon.downloadResizePictureCircle(mechanic.profile!,
              size: (size.height * .16).toInt(),
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

  final GlobalKey globalKey = GlobalKey();
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

    return Scaffold(
      drawer: const SideDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            // MyMarker(globalKey),
            _locationData == null
                ? const LoadingScreen()
                : GoogleMap(
                    markers: _markers,
                    onMapCreated: _onMapCreated,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            _locationData.latitude!, _locationData.longitude!),
                        zoom: 15),
                  ),

            const Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: MapAppBar(),
            ),
            const Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: BottomMapWidget(),
            )
          ],
        ),
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
