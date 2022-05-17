import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String? id;
  final String? profilePic;
  final String? amount;
  final String? name;
  final Timestamp? createdAt;
  final String? mechanicId;
  final String? mechanicName;
  final String? customerName;

  TransactionModel({
    this.id,
    this.profilePic,
    this.amount,
    this.name,
    this.createdAt,
    this.mechanicId,
    this.mechanicName,
    this.customerName,
  });

  factory TransactionModel.fromJson(dynamic json) {
    return TransactionModel(
      id: json['id'],
      profilePic: json['profilePic'],
      amount: json['amount'],
      name: json['name'],
      createdAt: json['createdAt'],
      mechanicId: json['mechanicId'],
      mechanicName: json['mechanicName'],
      customerName: json['customerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profilePic': profilePic,
      'amount': amount,
      'name': name,
      'createdAt': createdAt,
      'mechanicName': mechanicName,
      'customerName': customerName,
      'mechanicId': mechanicId,
    };
  }
}
