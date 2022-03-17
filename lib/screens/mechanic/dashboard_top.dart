import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mechanic/screens/chat/chat_screen.dart';
import 'package:mechanic/screens/mechanic/manage_bookings/manage_bookings_screen.dart';

class DashboardTop extends StatelessWidget {
  const DashboardTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SizedBox(
        width: size.width,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_outlined),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Your Dashboard',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ChatScreen.routeName);
                    },
                    child: const Icon(
                      FontAwesomeIcons.paperPlane,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Center(
                child: Column(
              children: const [
                Text(
                  'BALANCE',
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'KSH. 0.0',
                  style: TextStyle(fontSize: 24),
                )
              ],
            )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                DashboardTopOption(
                  color: Colors.green,
                  icon: Icons.dashboard_customize,
                  title: 'Manage\nServices',
                ),
                DashboardTopOption(
                  color: Colors.blue,
                  icon: Icons.event_seat_outlined,
                  title: 'Manage\nBookings',
                  routeName: ManageBookingsScreen.routeName,
                ),
                DashboardTopOption(
                  color: Colors.orange,
                  icon: Icons.bar_chart,
                  title: 'Your\nAnalytics',
                ),
                DashboardTopOption(
                  color: Colors.red,
                  icon: Icons.person_search_rounded,
                  title: 'Mechanic\nProfile',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DashboardTopOption extends StatelessWidget {
  final Color? color;
  final String? title;
  final IconData? icon;
  final String? routeName;

  const DashboardTopOption(
      {Key? key, this.color, this.title, this.icon, this.routeName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName!),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            if (title != null)
              const SizedBox(
                height: 5,
              ),
            if (title != null)
              FittedBox(
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
