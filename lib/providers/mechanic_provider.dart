import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mechanic/helpers/my_refs.dart';
import 'package:mechanic/models/analytics_model.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/models/review_model.dart';
import 'package:mechanic/models/service_model.dart';

class MechanicProvider with ChangeNotifier {
  List<MechanicModel>? _mechanics;
  List<MechanicModel>? get mechanics => _mechanics;

  Future<void> getMechanics() async {
    final results =
        await FirebaseFirestore.instance.collection('mechanics').get();

    List<AnalyticsModel> anaytics = [];

    anaytics = await Future.wait(results.docs.map((result) async {
      final data = await FirebaseFirestore.instance
          .collection('mechanics')
          .doc(result.id)
          .collection('account')
          .doc('analytics')
          .get();
      return AnalyticsModel.fromJson(data);
    }).toList());

//MAPPPING THE ARRAY OF MAPS FROM FIREBASE TO A MECHANIC MODEL

    final myResults = results.docs;
    _mechanics = List.generate(
        myResults.length,
        (index) => MechanicModel(
              address: myResults[index]['address'],
              closingTime: myResults[index]['closingTime'],
              openingTime: myResults[index]['openingTime'],
              profile: myResults[index]['profile'],
              analytics: anaytics[index],
              description: myResults[index]['description'],
              images: myResults[index]['images'],
              location: myResults[index]['location'],
              isBusy: myResults[index]['isBusy'],
              phone: myResults[index]['phone'],
              name: myResults[index]['name'],
              id: myResults[index].id,
              services: myResults[index]['services']
                  .map((k) => ServiceModel.fromJson(k))
                  .toList(),
            ));

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

    List<AnalyticsModel> anaytics = [];

    anaytics = await Future.wait(results.docs.map((result) async {
      final data = await FirebaseFirestore.instance
          .collection('mechanics')
          .doc(result.id)
          .collection('account')
          .doc('analytics')
          .get();
      return AnalyticsModel.fromJson(data);
    }).toList());

//MAPPING MECHANICS INTO A MECHANIC MODEL
//e Represents each individual element in the array obtained from fetching data from Cloud Firestore

    final myResults = results.docs;
    return List.generate(
        myResults.length,
        (index) => MechanicModel(
              address: myResults[index]['address'],
              closingTime: myResults[index]['closingTime'],
              openingTime: myResults[index]['openingTime'],
              profile: myResults[index]['profile'],
              analytics: anaytics[index],
              description: myResults[index]['description'],
              images: myResults[index]['images'],
              location: myResults[index]['location'],
              isBusy: myResults[index]['isBusy'],
              phone: myResults[index]['phone'],
              name: myResults[index]['name'],
              id: myResults[index].id,
              services: myResults[index]['services']
                  .map((k) => ServiceModel.fromJson(k))
                  .toList(),
            ));
  }

  Future<void> requestBooking(RequestModel booking) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final id = FirebaseFirestore.instance.collection('requests').doc().id;
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
    await userDataRef.doc(uid).collection('notifications').doc(id).set({
      'imageUrl':
          'https://website-assets-fs.freshworks.com/attachments/cjrufc17v02f1crg0zsp9gcq7-how-is-it-issue-tracking-software-used-2x.one-half.png',
      'message':
          'Your request for mechanic ${booking.mechanic!.name} has been sent. Once confirmed you will be notified.',
      'type': 'booking',
      'createdAt': Timestamp.now(),
      'id': id,
    });
    await userDataRef
        .doc(booking.mechanic!.id)
        .collection('notifications')
        .doc(id)
        .set({
      'imageUrl':
          'https://website-assets-fs.freshworks.com/attachments/cjrufc17v02f1crg0zsp9gcq7-how-is-it-issue-tracking-software-used-2x.one-half.png',
      'message':
          'Your request for mechanic ${booking.mechanic!.name} has been sent. Once confirmed you will be notified.',
      'type': 'booking',
      'createdAt': Timestamp.now(),
      'id': id,
    });

    notifyListeners();
  }

  Future<void> payRequest(RequestModel booking) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final id = booking.id;
    await FirebaseFirestore.instance
        .collection('requests')
        .doc('mechanics')
        .collection(booking.mechanic!.id!)
        .doc(id)
        .update({
      'status': 'paid',
    });
    await FirebaseFirestore.instance
        .collection('userData')
        .doc('bookings')
        .collection(uid)
        .doc(id)
        .update({
      'status': 'paid',
    });

    await FirebaseFirestore.instance
        .doc('mechanics/${booking.mechanic!.id}/account/analytics')
        .update({
      'completedRequests': FieldValue.increment(1),
      'balance': FieldValue.increment(double.parse(booking.amount!)),
      'totalEarnings': FieldValue.increment(double.parse(booking.amount!)),
    });

    await userDataRef.doc(uid).collection('notifications').doc(id).set({
      'imageUrl':
          'https://www.insperity.com/wp-content/uploads/Pay_compression1200x600.png',
      'message':
          'You have successfully paid KES ${booking.amount} to  ${booking.mechanic!.name} .Thank you for using our service.',
      'type': 'booking',
      'createdAt': Timestamp.now(),
      'id': id,
    });

    await userDataRef
        .doc(booking.mechanic!.id!)
        .collection('notifications')
        .doc(id)
        .set({
      'imageUrl':
          'https://www.insperity.com/wp-content/uploads/Pay_compression1200x600.png',
      'message':
          '${booking.user!.fullName!} has successfully paid KES ${booking.amount} for your service. Thank you for choosing our platform.',
      'type': 'booking',
      'createdAt': Timestamp.now(),
      'id': id,
    });

    notifyListeners();
  }

  Future<void> sendRating(ReviewModel review) async {
    await FirebaseFirestore.instance
        .doc('mechanics/${review.mechanicId!}/account/analytics')
        .update({
      'ratingCount': FieldValue.increment(1),
      'rating': FieldValue.increment(review.rating!),
    });

    await FirebaseFirestore.instance
        .collection('mechanics/${review.mechanicId!}/reviews')
        .doc()
        .set(review.toJson());

    notifyListeners();
  }

  Future<void> reportPayment(RequestModel booking) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final id = booking.id;
    await FirebaseFirestore.instance
        .collection('requests')
        .doc('mechanics')
        .collection(booking.mechanic!.id!)
        .doc(id)
        .update({
      'status': 'reported',
    });
    await FirebaseFirestore.instance
        .collection('userData')
        .doc('bookings')
        .collection(uid)
        .doc(id)
        .update({
      'status': 'reported',
    });

    await userDataRef
        .doc(booking.mechanic!.id!)
        .collection('notifications')
        .doc(id)
        .set({
      'imageUrl':
          'https://static.wixstatic.com/media/b11507_4a144943276543ccaa3776f6857ff47d~mv2.png/v1/fit/w_609%2Ch_349%2Cal_c/file.png',
      'message':
          '${booking.user!.fullName!} has reported your payment for your service.',
      'type': 'booking',
      'createdAt': Timestamp.now(),
      'id': id,
    });

    notifyListeners();
  }
}
