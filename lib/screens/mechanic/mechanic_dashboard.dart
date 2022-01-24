import 'package:flutter/material.dart';
import 'package:mechanic/screens/mechanic/dashboard_top.dart';

class MechanicDashboard extends StatelessWidget {
  const MechanicDashboard({Key? key}) : super(key: key);
  static const routeName='/mechanic-dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
DashboardTop(),
        ],
      ),
    );
  }
}
