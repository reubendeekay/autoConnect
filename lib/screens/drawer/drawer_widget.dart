import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/screens/auth/auth_screen.dart';
import 'package:mechanic/screens/chat/chat_screen.dart';
import 'package:mechanic/screens/drawer/drawer_avatar.dart';
import 'package:mechanic/screens/drawer/drawer_chart.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mechanic/screens/inquiry_screen.dart';
import 'package:mechanic/screens/mechanic_profile/widgets/mechanic_register/mechanic_register_screen.dart';

import 'package:mechanic/screens/my_boookings/my_bookings.dart';
import 'package:mechanic/screens/notifications/notifications_screen.dart';
import 'package:mechanic/screens/user/user_profile.dart';
import 'package:provider/provider.dart';

class DrawerItem {
  String title;
  IconData icon;
  Function onTap;

  DrawerItem({required this.title, required this.icon, required this.onTap});
}

class DrawerItems {
  // static final home = DrawerItem(
  //     title: "Home",
  //     icon: Icons.grid_view_outlined,
  //     onTap: () {
  //       Get.to(() => Homepage());
  //     });

  static final bookings = DrawerItem(
      title: "My Bookings",
      icon: FontAwesomeIcons.chartPie,
      onTap: () {
        Get.to(() => const MyBookingsScreen());
      });

  static final chat = DrawerItem(
      title: "Chat",
      icon: FontAwesomeIcons.comment,
      onTap: () {
        Get.to(() => const ChatScreen());
      });
  static final notification = DrawerItem(
      title: "Notifications",
      icon: Icons.notifications_active_outlined,
      onTap: () {
        Get.to(() => const NotificationsScreen());
      });
  static final logout = DrawerItem(
      title: "Logout",
      icon: Icons.logout_outlined,
      onTap: () async {
        await FirebaseAuth.instance.signOut();
        Get.offAll(() => const AuthScreen());
      });
  static final report = DrawerItem(
      title: "Support",
      icon: Icons.help_outline,
      onTap: () async {
        Get.to(() => const EnquiryScreen());
      });

  static final List<DrawerItem> all = [
    // home,
    bookings,
    chat,
    report,
    notification,
    logout
  ];
}

class DrawerWidget extends StatefulWidget {
  VoidCallback closdDrawer;
  DrawerWidget({Key? key, required this.closdDrawer}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget>
    with SingleTickerProviderStateMixin {
  final double runanim = 0.4;
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Column(
      children: [
        _buildButton(context),
        const ProgerssAvatar(),
        SizedBox(
          height: he * 0.02,
        ),
        _buidText(context),
        SizedBox(
          height: he * 0.02,
        ),
        Expanded(child: buildDrawerItem(context)),
        Row(
          children: [
            BottomLogo(),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget buildDrawerItem(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(padding: const EdgeInsets.all(0.0), children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
          leading: Icon(
            Icons.grid_view_outlined,
            color: Colors.white.withOpacity(0.2),
          ),
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          onTap: widget.closdDrawer,
        ),
        if (!user!.isMechanic!)
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            leading: Icon(
              Icons.person_outline,
              color: Colors.white.withOpacity(0.2),
            ),
            title: const Text(
              'Register as a Mechanic',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Get.to(() => const MechanicRegisterScreen());
            },
          ),
        ...DrawerItems.all
            .map((item) => ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  leading: Icon(
                    item.icon,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => item.onTap(),
                ))
            .toList(),
      ]),
    );
  }

  Widget _buildButton(contex) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: he * 0.09, left: we * 0.15),
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration:
          const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      child: Container(
          width: 47,
          height: 47,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF04123F),
          ),
          child: IconButton(
              onPressed: widget.closdDrawer,
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: 20,
              ))),
    );
  }

  Widget _buidText(context) {
    var we = MediaQuery.of(context).size.width;
    final user = Provider.of<AuthProvider>(
      context,
    ).user;
    return GestureDetector(
      onTap: () {
        Get.to(() => const UserProfile());
      },
      child: Container(
        margin: EdgeInsets.only(right: we * 0.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user!.fullName!.split(' ')[0],
              style: GoogleFonts.lato(
                  fontSize: 30,
                  letterSpacing: 2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            if (user.fullName!.split(' ').length > 1)
              Text(
                user.fullName!.split(' ')[1],
                style: GoogleFonts.lato(
                    fontSize: 30,
                    letterSpacing: 2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
