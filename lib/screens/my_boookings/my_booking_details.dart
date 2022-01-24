import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';

class MyBookingDetails extends StatelessWidget {
  const MyBookingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Details',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                mechanicDetails(),
                vehicleDetails(),
                dateAndTime(),
              ],
            ),
          ),
          bottomWidget(),
        ],
      ),
    );
  }

  Widget bottomWidget() {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 8),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Amount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$100',
                style: TextStyle(
                    fontSize: 16,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 45,
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: kPrimaryColor,
              child: const Text(
                'Cancel Booking',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ]));
  }

  Widget services() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Services',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Engine Detailing',
              ),
              Text(
                'KES 2400',
              ),
            ],
          ),
          const SizedBox(
            height: 2.5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Car Wash',
              ),
              Expanded(
                child: Text(
                  'KES 600',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dateAndTime() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Date & Time',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          Text('22 Feb, 2022'),
          Text(
            '10:00 AM',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget mechanicDetails() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Mechanic Details',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Best Mechanics'),
          Text(
            'Kileleshwa, Kenya',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget vehicleDetails() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vehicle Details',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Model: ',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'BMW X7',
              ),
            ],
          ),
          const SizedBox(
            height: 2.5,
          ),
          const Text(
            'Problem: ',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const Text(
            tProblem,
          ),
        ],
      ),
    );
  }
}

const tProblem =
    'After a significant number of daily drives and road trips, you begin to notice an unusual tyre wear i.e the tread wear of a particular tyre does not match with the rest of the tyres. This means that you need to get wheel balancing done on an immediate basis. Interestingly, the front tyres of a car are more prone to uneven tyre wear as they experience more pressure and weight offset.';
