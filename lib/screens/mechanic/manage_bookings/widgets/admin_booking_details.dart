import 'package:flutter/material.dart';
import 'package:mechanic/helpers/cached_image.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/request_model.dart';

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
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Booking Details',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600)),
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
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(children: [
                              Row(
                                children: [
                                  Text(booking.services!.first.serviceName!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  const Spacer(),
                                  const Text(
                                    'COMPLETE',
                                    style: TextStyle(color: Colors.green),
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
                            color: Colors.grey, fontWeight: FontWeight.w600)),
                    const Divider(),
                    _detailsTile('Booking ID', booking.id!),
                    _detailsTile('Vehicle', booking.vehicleModel!),
                    _detailsTile('Booking Date', '10:00 AM, 20 Jan 2022'),
                    _detailsTile('Problem', booking.problem!),
                  ]),
            ),
          ),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                height: 45,
                child: RaisedButton(
                  onPressed: () {},
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
          SizedBox(
            height: 10,
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
