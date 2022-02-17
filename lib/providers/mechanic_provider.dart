import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mechanic/models/mechanic_model.dart';

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
                .contains(searchTerm.toLowerCase()) ||
            element['services']
                .toLowerCase()
                .contains(searchTerm.toLowerCase()))
        .toList();

    notifyListeners();

// [
//   {
//     1: '1',
//   }
//   {
//     2: '2',
//   }
// ]

//MAPPING MECHANICS INTO A MECHANIC MODEL
//e Represents each individual element in the array obtained from fetching data from Cloud Firestore

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
}
