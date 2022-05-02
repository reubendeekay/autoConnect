import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/screens/auth/auth_screen.dart';
import 'package:mechanic/screens/chat/chat_screen.dart';
import 'package:get/route_manager.dart';

import 'package:mechanic/screens/favourites/favourites_screen.dart';
import 'package:mechanic/screens/home/homepage.dart';

import 'package:mechanic/screens/my_boookings/my_bookings.dart';
import 'package:mechanic/screens/notifications/notifications_screen.dart';
import 'package:mechanic/screens/user/user_profile.dart';
import 'package:mechanic/splash_screen.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final isMechanic = Provider.of<AuthProvider>(context).user!.isMechanic;

    List<Map<String, dynamic>> options = [
      {
        'title': 'Home',
        'icon': Icons.home,
        'screen': Homepage.routeName,
      },
      {
        'title': 'Your Profile',
        'screen': UserProfile.routeName,
        'icon': Icons.person_outline,
      },
      {
        'title': 'Bookings',
        'icon': Icons.approval_outlined,
        'screen': MyBookingsScreen.routeName,
      },
      {
        'title': 'Favourites',
        'icon': Icons.favorite_outline,
        'screen': FavouritesScreen.routeName,
      },
      {
        'title': 'Chat',
        'icon': FontAwesomeIcons.comment,
        'screen': ChatScreen.routeName,
      },
      {
        'title': 'Notifications',
        'icon': Icons.notifications_active_outlined,
        'screen': NotificationsScreen.routeName,
      },
      {
        'title': 'Analytics',
        'icon': Icons.show_chart,
        'screen': null,
      },
      {
        'title': 'Help and Support',
        'screen': null,
        'icon': Icons.help_outline,
      },
      {
        'title': 'Log out',
        'screen': 'Log out',
        'icon': Icons.logout_outlined,
      }
    ];
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          topDrawer(context),
          ...List.generate(
              options.length,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      if (options[index]['screen'] == Homepage.routeName) {
                        Navigator.of(context).pop();
                      } else if (options[index]['screen'] == 'Log out') {
                        Navigator.of(context).pop();
                        Get.off(() => const SplashVideoScreen());
                        FirebaseAuth.instance.signOut();
                      } else {
                        // Navigator.of(context).pop();

                        Navigator.of(context)
                            .pushNamed(options[index]['screen']);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Icon(
                            options[index]['icon'],
                            size: 18,
                            color:
                                selectedIndex == index ? kPrimaryColor : null,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            options[index]['title'],
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  selectedIndex == index ? kPrimaryColor : null,
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
        ],
      ),
    );
  }

  Widget topDrawer(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).padding.top + 75,
      width: double.infinity,
      child: Column(
        children: [
          const Spacer(),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
                text: 'Auto',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor),
                children: [
                  TextSpan(
                    text: 'Connect',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 30),
                  ),
                ]),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
