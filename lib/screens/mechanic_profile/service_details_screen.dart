import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/models/service_model.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/providers/location_provider.dart';
import 'package:mechanic/providers/payment_provider.dart';
import 'package:mechanic/screens/mechanic/service_tile.dart';
import 'package:mechanic/screens/payment/widgets/payment_screen.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:provider/provider.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({Key? key, required this.mech}) : super(key: key);
  final MechanicModel mech;

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  String? vehicleName;
  String? problem;
  List<File> imageFiles = [];
  List<Media> mediaList = [];
  ServiceModel? service;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final pay = Provider.of<PaymentProvider>(
      context,
    );
    final loc = Provider.of<LocationProvider>(context).locationData;
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
                        setState(() {
                          _selectedDate = date;
                        });
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
                        GestureDetector(
                          onTap: () {
                            openImagePicker(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blueGrey[100]),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ...List.generate(
                            imageFiles.length,
                            (index) => Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  height: 80,
                                  width: 80,
                                  child: Image.file(imageFiles[index]),
                                ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Select services'),
                  const SizedBox(
                    height: 5,
                  ),
                  ...List.generate(
                      widget.mech.services!.length,
                      (index) => ServiceTile(
                            widget.mech.services![index],
                          ))
                ],
              ),
            ),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: RaisedButton(
                onPressed: pay.services.isEmpty
                    ? null
                    : () async {
                        List<String> imageUrls = [];

                        for (var file in imageFiles) {
                          FirebaseStorage.instance
                              .ref(
                                  'requests/images/${DateTime.now().toIso8601String()}')
                              .putFile(file)
                              .then((value) => value.ref.getDownloadURL())
                              .then((val) => imageUrls.add(val.toString()));
                        }

                        final request = RequestModel(
                          date: _selectedDate,
                          createdAt: Timestamp.now(),
                          status: 'pending',
                          
                          userLocation:
                              GeoPoint(loc!.latitude!, loc.longitude!),
                          mechanic: widget.mech,
                          problem: problem,
                          user: user,
                          amount: pay.price.toStringAsFixed(2),
                          services: pay.services,
                          vehicleModel: vehicleName,
                          images: imageUrls,
                        );

                        Get.to(() => PaymentScreen(
                              request: request,
                            ));
                      },
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

  Future<void> openImagePicker(
    BuildContext context,
  ) async {
    // openCamera(onCapture: (image){
    //   setState(()=> mediaList = [image]);
    // });
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 0.95,
                minChildSize: 0.6,
                builder: (ctx, controller) => AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    color: Colors.white,
                    child: MediaPicker(
                      scrollController: controller,
                      mediaList: mediaList,
                      onPick: (selectedList) {
                        setState(() => mediaList = selectedList);

                        imageFiles = mediaList.map((e) => e.file!).toList();

                        mediaList.clear();

                        Navigator.pop(context);
                      },
                      onCancel: () => Navigator.pop(context),
                      mediaCount: MediaCount.multiple,
                      mediaType: MediaType.image,
                      decoration: PickerDecoration(
                        cancelIcon: const Icon(Icons.close),
                        albumTitleStyle: TextStyle(
                            color: Theme.of(context).iconTheme.color,
                            fontWeight: FontWeight.bold),
                        actionBarPosition: ActionBarPosition.top,
                        blurStrength: 2,
                        completeButtonStyle: const ButtonStyle(),
                        completeTextStyle:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                        completeText: 'Select',
                      ),
                    )),
              ));
        });
  }
}
