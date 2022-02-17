import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:mechanic/models/mechanic_model.dart';

class AdminUserProvider with ChangeNotifier {
  Future<void> registerMechanic(MechanicModel mech) async {
    //GETTING USER ID OF CURRENT USER USING THE APP
    final uid = FirebaseAuth.instance.currentUser!.uid;
    List<String> imageUrls = [];

//UPLOADING IMAGES TO FIREBASE STORAGE
    final profileResult = await FirebaseStorage.instance
        .ref('mechanics/$uid')
        .putFile(mech.profileFile!);

    //getting url of image
    String profileUrl = await profileResult.ref.getDownloadURL();

    await Future.wait(mech.fileImages!.map((file) async {
      final result =
          await FirebaseStorage.instance.ref('mechanics/$uid').putFile(file);
      String url = await result.ref.getDownloadURL();
      imageUrls.add(url);
    }).toList());

//UPLOADING mechanic Data TO FIREBASE DATABASE
    await FirebaseFirestore.instance.collection('mechanics').doc(uid).set({
      'name': mech.name,
      'phone': mech.phone,
      'address': mech.address,
      'description': mech.description,
      'openingTime': mech.openingTime,
      'closingTime': mech.closingTime,
      'location': mech.location,
      'profile': profileUrl,
      'images': imageUrls,
      'services': mech.services!.isEmpty
          ? []
          : mech.services!.map((service) => service.toJson()).toList(),
    });
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'isMechanic': true,
    });
    notifyListeners();
  }
}
