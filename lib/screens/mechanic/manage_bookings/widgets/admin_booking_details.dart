import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';

class AdminBookingDetails extends StatelessWidget {
  const AdminBookingDetails({Key? key}) : super(key: key);

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
                            child: Image.network(
                              'https://www.floridacareercollege.edu/wp-content/uploads/sites/4/2020/08/12-Reasons-to-Become-an-Automotive-Mechanic-Florida-Career-College.png',
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(children: [
                              Row(
                                children: const [
                                  Text('Tire Change',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  Spacer(),
                                  Text(
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
                    _detailsTile('Booking ID', '#123456789'),
                    _detailsTile('Vehicle', 'BMW X7'),
                    _detailsTile('Booking Date', '10:00 AM, 20 Jan 2022'),
                    _detailsTile('Problem', 'Tire Change'),
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
