import 'package:flutter/material.dart';
import 'package:mechanic/helpers/cached_image.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/screens/home/widgets/request_service_button.dart';
import 'package:mechanic/screens/mechanic_profile/widgets/mechanic_profile_body.dart';

class MechanicProfileScreen extends StatelessWidget {
  const MechanicProfileScreen({Key? key, this.mechanic}) : super(key: key);
  static const routeName = '/mechanic-profile';
  final MechanicModel? mechanic;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  expandedHeight: size.height * 0.25,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text('',
                        style: TextStyle(fontSize: 15.0, shadows: [
                          Shadow(
                              color: Theme.of(context).primaryColor,
                              blurRadius: 5)
                        ])),
                    background: cachedImage(
                      mechanic!.profile!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, i) => MechanicProfileBody(
                              mechanic: mechanic!,
                            ),
                        childCount: 1))
              ],
            ),
            Positioned(
                bottom: 10,
                left: 15,
                right: 15,
                child: RequestServiceButton(
                  mechanic: mechanic!,
                )),
          ],
        ),
      ),
    );
  }
}
