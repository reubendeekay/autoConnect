import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mechanic/models/service_model.dart';

class PaymentProvider with ChangeNotifier {
  double _price = 0;
  double get price => _price;

  String _message = '';
  String get message => _message;
  bool isInit = false;
  List<ServiceModel> _services = [];
  List<ServiceModel> get services => _services;

  void initiliasePrice(double initPrice) {
    _price = initPrice;
  }

  Future<void> addService(ServiceModel service) async {
    if (_services.contains(service)) {
      _services.remove(service);

      notifyListeners();
      return;
    }
    _services.add(service);
    notifyListeners();
  }
}
