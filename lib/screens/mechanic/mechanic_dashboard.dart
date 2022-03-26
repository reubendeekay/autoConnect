import 'package:flutter/material.dart';
import 'package:mechanic/helpers/cached_image.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/screens/mechanic/dashboard_top.dart';
import 'package:mechanic/screens/mechanic/mechanic_register/widgets/mechanic_service_tile.dart';
import 'package:provider/provider.dart';

class MechanicDashboard extends StatelessWidget {
  const MechanicDashboard({Key? key}) : super(key: key);
  static const routeName = '/mechanic-dashboard';

  @override
  Widget build(BuildContext context) {
    final mechanic = Provider.of<AuthProvider>(context).mechanic;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              BackgroundDashboard(
                mechanic: mechanic!,
              ),
            ],
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              const DashboardTop(),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
                child: Text(
                  'Your Services',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 5,
                        color: kPrimaryColor,
                        offset: Offset(1, 1),
                      ),
                    ],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (ctx, i) => const MechanicServiceTile(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BackgroundDashboard extends StatelessWidget {
  const BackgroundDashboard({Key? key, this.mechanic}) : super(key: key);

  final MechanicModel? mechanic;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
            height: size.height * 0.5,
            width: size.width,
            child: cachedImage(
              mechanic!.profile!,
              fit: BoxFit.cover,
            )),
        Container(
          height: size.height * 0.5,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              kPrimaryColor.withOpacity(0.1),
              kPrimaryColor.withOpacity(0.3),
              kPrimaryColor.withOpacity(0.5),
              kPrimaryColor.withOpacity(0.7),
              Colors.white.withOpacity(0.4),
              Colors.white.withOpacity(0.6),
              Colors.white.withOpacity(0.8),
              Colors.white,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        )
      ],
    );
  }
}
