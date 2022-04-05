import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanic/models/service_model.dart';

class MechanicModel {
  final String? name;
  final String? profile;
  final File? profileFile;
  List<dynamic>? images = [];
  List<File>? fileImages = [];
  final String? phone;
  final String? description;
  final String? openingTime;
  final String? closingTime;
  final String? address;
  List<dynamic>? services = [];
  //FIREBASE CLASS FOR LONGITUDE AND LATITUDE
  final GeoPoint? location;
  final String? id;

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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profile': profile,
      'phone': phone,
      'description': description,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'address': address,
      'location': location,
      'id': id,
      'images': images,
      'services': services!.map((e) => e.toJson()).toList(),
    };
  }

  factory MechanicModel.fromJson(Map<String, dynamic> json) {
    return MechanicModel(
      address: json['address'],
      name: json['name'],
      phone: json['phone'],
      description: json['description'],
      profile: json['profile'],
      openingTime: json['openingTime'],
      location: json['location'],
      id: json['id'],
      closingTime: json['closingTime'],
      services: json['services'],
      images: json['images'],
    );
  }
}
