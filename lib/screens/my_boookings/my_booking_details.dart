import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/request_model.dart';

class MyBookingDetails extends StatelessWidget {
  const MyBookingDetails({Key? key, required this.request}) : super(key: key);
  final RequestModel request;

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
                services(),
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
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'KES ' + request.amount!,
                style: const TextStyle(
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
          ...List.generate(
            request.services!.length,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.services![i].serviceName!,
                  ),
                  const Spacer(),
                  Text(
                    'KES ' + request.services![i].price!,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
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
        children: [
          const Text(
            'Date & Time',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(DateFormat('dd MMM yyyy').format(request.date!)),
          Text(
            DateFormat('hh:mm a').format(request.date!),
            style: const TextStyle(color: Colors.grey),
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
        children: [
          const Text(
            'Mechanic Details',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(request.mechanic!.name!),
          Text(
            request.mechanic!.address!,
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
            children: [
              const Text(
                'Model: ',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                request.vehicleModel!,
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
          Text(
            request.problem!,
          ),
        ],
      ),
    );
  }
}

const tProblem =
    'After a significant number of daily drives and road trips, you begin to notice an unusual tyre wear i.e the tread wear of a particular tyre does not match with the rest of the tyres. This means that you need to get wheel balancing done on an immediate basis. Interestingly, the front tyres of a car are more prone to uneven tyre wear as they experience more pressure and weight offset.';
