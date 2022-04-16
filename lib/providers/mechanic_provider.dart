import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mechanic/helpers/my_refs.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/models/service_model.dart';

class MechanicProvider with ChangeNotifier {
  List<MechanicModel>? _mechanics;
  List<MechanicModel>? get mechanics => _mechanics;

  Future<void> getMechanics() async {
    final results =
        await FirebaseFirestore.instance.collection('mechanics').get();

//MAPPPING THE ARRAY OF MAPS FROM FIREBASE TO A MECHANIC MODEL
    _mechanics = results.docs
        .map<MechanicModel>((e) => MechanicModel(
              address: e['address'],
              closingTime: e['closingTime'],
              openingTime: e['openingTime'],
              profile: e['profile'],
              description: e['description'],
              images: e['images'],
              location: e['location'],
              phone: e['phone'],
              name: e['name'],
              id: e.id,
              services:
                  e['services'].map((k) => ServiceModel.fromJson(k)).toList(),
            ))
        .toList();

    notifyListeners();
  }

  Future<List<MechanicModel>> searchMechanic(String searchTerm) async {
    final results =
        await FirebaseFirestore.instance.collection('mechanics').get();

    final searchResults = results.docs
        .where((element) =>
            element['name'].toLowerCase().contains(searchTerm.toLowerCase()) ||
            element['address']
                .toLowerCase()
                .contains(searchTerm.toLowerCase()) ||
            element['description']
                .toLowerCase()
                .contains(searchTerm.toLowerCase()))
        .toList();

    notifyListeners();

//MAPPING MECHANICS INTO A MECHANIC MODEL
//e Represents each individual element in the array obtained from fetching data from Cloud Firestore
    print(searchResults.length);
    return searchResults
        .map<MechanicModel>((e) => MechanicModel(
              address: e['address'],
              closingTime: e['closingTime'],
              openingTime: e['openingTime'],
              profile: e['profile'],
              description: e['description'],
              images: e['images'],
              location: e['location'],
              phone: e['phone'],
              name: e['name'],
              id: e.id,
            ))
        .toList();
  }

  Future<void> editService(ServiceModel services, String mechanicId,
      ServiceModel previousService) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    String? serviceUrl;
    if (services.imageFile != null) {
      final servResult = await FirebaseStorage.instance
          .ref('mechanics/$uid/services/')
          .putFile(services.imageFile!);
      serviceUrl = await servResult.ref.getDownloadURL();
    }

    await FirebaseFirestore.instance
        .collection('mechanics')
        .doc(mechanicId)
        .update({
      'services': FieldValue.arrayRemove([previousService.toJson()])
    });
    await FirebaseFirestore.instance
        .collection('mechanics')
        .doc(mechanicId)
        .update({
      'services': FieldValue.arrayUnion(
        [
          {
            'serviceName': services.serviceName,
            'price': services.price,
            'imageUrl': serviceUrl ?? services.imageUrl,
            'id': UniqueKey().toString(),
          }
        ],
      )
    });
    notifyListeners();
  }

  Future<void> addService(
      List<ServiceModel> services, String mechanicId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    List<String> serviceUrls = [];
    await Future.forEach(services, <File>(service) async {
      final servResult = await FirebaseStorage.instance
          .ref('mechanics/$uid/services/')
          .putFile(service!.imageFile!);
      String servUrl = await servResult.ref.getDownloadURL();
      serviceUrls.add(servUrl);
    });
    await FirebaseFirestore.instance
        .collection('mechanics')
        .doc(mechanicId)
        .update({
      'services': FieldValue.arrayUnion(
        List.generate(
            services.length,
            (i) => {
                  'serviceName': services[i].serviceName,
                  'price': services[i].price,
                  'imageUrl': serviceUrls[i],
                  'id': UniqueKey().toString(),
                }),
      )
    });
    notifyListeners();
  }

  Future<void> requestBooking(RequestModel booking) async {
    print(booking.toJson());
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final id =
        FirebaseFirestore.instance.collection('requests').doc('mechanics').id;
    await FirebaseFirestore.instance
        .collection('requests')
        .doc('mechanics')
        .collection(booking.mechanic!.id!)
        .doc(id)
        .set(booking.toJson());

    await FirebaseFirestore.instance
        .collection('userData')
        .doc('bookings')
        .collection(uid)
        .doc(id)
        .set(booking.toJson());

    notifyListeners();
  }

  Future<void> confirmRequest(
      {String? userId, String? mechanicId, String? docId}) async {
    await FirebaseFirestore.instance
        .collection('requests')
        .doc('mechanics')
        .collection(mechanicId!)
        .doc(docId)
        .update({'status': 'confirmed'});

    await FirebaseFirestore.instance
        .collection('userData')
        .doc('bookings')
        .collection(userId!)
        .doc(docId)
        .update({'status': 'confirmed'});
    await userDataRef.doc(userId).collection('notifications').doc(docId).set({
      'imageUrl':
          'https://previews.123rf.com/images/sarahdesign/sarahdesign1509/sarahdesign150900627/44517835-confirm-icon.jpg',
      'message': 'Your booking has been confirmed by the mechanic',
      'type': 'booking',
      'createdAt': Timestamp.now(),
      'id': docId,
    });

    notifyListeners();
  }
}
