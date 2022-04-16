import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mechanic/helpers/cached_image.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:mechanic/screens/mechanic_profile/widgets/mechanic_details_location.dart';
import 'package:provider/provider.dart';

class AdminBookingDetails extends StatelessWidget {
  const AdminBookingDetails({Key? key, required this.booking})
      : super(key: key);
  final RequestModel booking;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Booking Details',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600)),
                        const Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: size.width * 0.23,
                                height: size.width * 0.26,
                                child: cachedImage(
                                  booking.services!.first.imageUrl!,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Text(booking.services!.first.serviceName!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)),
                                      const Spacer(),
                                      Text(
                                        booking.status!.toUpperCase(),
                                        style: TextStyle(
                                            color: booking.status != 'pending'
                                                ? Colors.green
                                                : Colors.red),
                                      )
                                    ],
                                  )
                                ]),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Booking Details',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600)),
                        const Divider(),
                        _detailsTile('Booking ID', booking.id!),
                        _detailsTile('Vehicle', booking.vehicleModel!),
                        _detailsTile('Booking Date', '10:00 AM, 20 Jan 2022'),
                        _detailsTile('Problem', booking.problem!),
                        MechanicDetailsLocation(
                          imageUrl: booking.user!.imageUrl,
                          location: LatLng(booking.userLocation!.latitude,
                              booking.userLocation!.longitude),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: RaisedButton(
                        onPressed: () async {
                          await Provider.of<MechanicProvider>(context,
                                  listen: false)
                              .confirmRequest(
                            docId: booking.id,
                            mechanicId: booking.mechanic!.id!,
                            userId: booking.user!.userId!,
                          );
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Request Confirmed'),
                            ),
                          );
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        child: const Text('Confirm Booking'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: RaisedButton(
                        onPressed: () {},
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        child: const Text('Update Invoice'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ]),
          ),
        ],
      ),
    );
  }

  Container _detailsTile(String title, String detail) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(detail),
        ],
      ),
    );
  }
}
