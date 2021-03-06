import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/models/service_model.dart';
import 'package:mechanic/models/user_model.dart';
import 'package:mechanic/screens/auth/auth_exception.dart';

final uid = FirebaseAuth.instance.currentUser!.uid;

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  bool isOnline = false;
  MechanicModel? _mechanic;
  MechanicModel? get mechanic => _mechanic;
  //STEP 1

  Future<AuthResultStatus> login({String? email, String? password}) async {
    UserCredential? _currentUser;

    AuthResultStatus _status;

    try {
      _currentUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      if (_currentUser.user != null) {
        _status = AuthResultStatus.successful;
        await FirebaseMessaging.instance.getToken().then((token) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'pushToken': token});
        }).catchError((err) {});

        await getCurrentUser(_currentUser.user!.uid);
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
      return _status;
    }

    notifyListeners();
    return _status;
  }

  Future<AuthResultStatus> signUp(
      {String? email,
      String? password,
      String? fullName,
      String? phoneNumber}) async {
    AuthResultStatus _status;
    UserCredential? _currentUser;

    try {
      //FIREBASE SIGNUP WITH EMAIL AND PASSWORD
      _currentUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      if (_currentUser.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
      return _status;
    }

//ENTERING USER DATA TO THE DATABASE FIRESTORE VIA SET METHOD
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.user!.uid)
        .set({
      'userId': _currentUser.user!.uid,
      'email': email,
      'password': password,
      'fullName': fullName,
      'isOnline': true,
      'lastSeen': Timestamp.now().millisecondsSinceEpoch,
      'isAdmin': false,
      'isMechanic': false,
      'phoneNumber': phoneNumber,
      'profilePic':
          'https://www.theupcoming.co.uk/wp-content/themes/topnews/images/tucuser-avatar-new.png',
      'dateOfBirth': null,
    });
    await FirebaseMessaging.instance.getToken().then((token) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'pushToken': token});
    }).catchError((err) {});
    getCurrentUser(_currentUser.user!.uid);

    notifyListeners();
    return _status;
  }

  Future<void> getCurrentUser(String userId) async {
    //GETTING USER DETAILS OF CURRENT USER IN SESSION

    final _currentUser =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
//mapping the fetched user data from the database to A USER MODEL
    _user = UserModel(
        email: _currentUser['email'],
        fullName: _currentUser['fullName'],
        phoneNumber: _currentUser['phoneNumber'],
        imageUrl: _currentUser['profilePic'],
        isMechanic: _currentUser['isMechanic'],
        userId: _currentUser['userId'],
        isOnline: _currentUser['isOnline'],
        lastSeen: _currentUser['lastSeen'],
        password: _currentUser['password']);

    if (_currentUser['isMechanic']) {
      await getMechanicDetails(userId);
    }

    notifyListeners();
  }

  Future<void> updateProfile(UserModel user, String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'email': user.email,
      'fullName': user.fullName,
      'phoneNumber': user.phoneNumber,
    });
    notifyListeners();
  }

  Future<void> addToWishList(String propertyId, bool isLike) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'wishlist': isLike
          ? FieldValue.arrayUnion([propertyId])
          : FieldValue.arrayRemove([propertyId]),
    });
  }

  Future<void> getOnlineStatus() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final databaseRef = FirebaseDatabase.instance.ref('users/$uid');
    if (!isOnline) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'isOnline': true,
        'lastSeen': DateTime.now().microsecondsSinceEpoch,
      });
      databaseRef.update({
        'isOnline': true,
        'lastSeen': DateTime.now().microsecondsSinceEpoch,
      });
      isOnline = true;
    }

    databaseRef.onDisconnect().update({
      'isOnline': false,
      'lastSeen': DateTime.now().microsecondsSinceEpoch,
    }).then((_) => {
          isOnline = false,
        });

    notifyListeners();
  }

  Future<void> getMechanicDetails(String userId) async {
    final results = await FirebaseFirestore.instance
        .collection('mechanics')
        .doc(userId)
        .get();

    _mechanic = MechanicModel(
      id: results.id,
      address: results['address'],
      closingTime: results['closingTime'],
      openingTime: results['openingTime'],
      services:
          results['services'].map((e) => ServiceModel.fromJson(e)).toList(),
      profile: results['profile'],
      description: results['description'],
      images: results['images'],
      location: results['location'],
      phone: results['phone'],
    );
  }
}
