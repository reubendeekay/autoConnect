import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class MechanicModel {
  final String? name;
  final String? profile;
  final File? profileFile;
  List<dynamic>? images = [];
  List< File>? fileImages = [];
  final String? phone;
  final String? description;
  final String? openingTime;
  final String? closingTime;
  final String? address;
  final GeoPoint? location;
  final String? id;
  List<ServicesModel>? services = [];

  MechanicModel({
    this.name,
    this.profile,
    this.phone,
    this.description,
    this.openingTime,
    this.fileImages,
    this.profileFile,
    this.closingTime,
    this.address,
    this.location,
    this.id,
    this.images,
    this.services,
  });
}

class ServicesModel {
  final String? serviceName;
  final String? price;

  ServicesModel({this.serviceName, this.price});

Map toJson() {
  return {
    'serviceName': serviceName,
    'price': price,
  
};
}
}
