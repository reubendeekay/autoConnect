import 'dart:io';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  String? vehicleName;
  String? problem;
  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Servicing Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text('Date of Service'),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 85,
                    child: DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: kPrimaryColor,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        // New date selected
                        // setState(() {
                        //   _selectedValue = date;
                        // });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Vehicle Details'),
                  const SizedBox(height: 10),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        vehicleName = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Vehicle model/name',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.blueGrey[100]),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    maxLines: null,
                    maxLength: null,
                    onChanged: (value) {
                      setState(() {
                        problem = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Problem description',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.blueGrey[100]),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Add photos of the problem/vehicle(Optional)',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blueGrey[100]),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ...List.generate(
                            images.length,
                            (index) => Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  height: 80,
                                  width: 80,
                                  child: Image.file(images[index]),
                                ))
                      ],
                    ),
                  )
                ],
              ),
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
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
