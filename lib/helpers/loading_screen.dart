import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mechanic/providers/location_provider.dart';
import 'package:mechanic/screens/home/homepage.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Center(child: Lottie.asset('assets/map.json', fit: BoxFit.fitHeight)),
    );
  }
}

class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen({Key? key}) : super(key: key);

  @override
  State<InitialLoadingScreen> createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<LocationProvider>(context, listen: false)
          .getCurrentLocation()
          .then((_) =>
              Navigator.of(context).pushReplacementNamed(Homepage.routeName));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
            child: Lottie.asset('assets/map.json', fit: BoxFit.fitHeight)),
      ),
    );
  }
}
