import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic/firebase_options.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/helpers/global_error_screen.dart';
import 'package:mechanic/providers/admin_user_provider.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/providers/chat_provider.dart';
import 'package:mechanic/providers/location_provider.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:mechanic/providers/payment_provider.dart';
import 'package:mechanic/screens/chat/chat_room.dart';
import 'package:mechanic/screens/chat/chat_screen.dart';
import 'package:mechanic/screens/drawer/hidden_drawer.dart';
import 'package:mechanic/screens/favourites/favourites_screen.dart';
import 'package:mechanic/screens/home/homepage.dart';

import 'package:mechanic/screens/mechanic_profile/mechanic_profile_screen.dart';
import 'package:mechanic/screens/my_boookings/my_bookings.dart';
import 'package:mechanic/screens/notifications/notifications_screen.dart';
import 'package:mechanic/screens/user/user_profile.dart';
import 'package:mechanic/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ErrorWidget.builder = (FlutterErrorDetails details) {

  //   return const Material(child: GlobalErrorScreen());
  // };
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LocationProvider()),
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: ChatProvider()),
        ChangeNotifierProvider.value(value: MechanicProvider()),
        ChangeNotifierProvider.value(value: AdminUserProvider()),
        ChangeNotifierProvider.value(value: PaymentProvider()),
      ],
      child: GetMaterialApp(
        title: 'AutoConnect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.nunitoTextTheme(),
        ),
        // home: const SplashScreen(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snap) =>
              snap.hasData ? HidenDrawer() : const SplashScreen(),
        ),
        routes: {
          Homepage.routeName: (ctx) => Homepage(),
          UserProfile.routeName: (ctx) => const UserProfile(),
          MyBookingsScreen.routeName: (ctx) => const MyBookingsScreen(),
          FavouritesScreen.routeName: (ctx) => const FavouritesScreen(),
          NotificationsScreen.routeName: (ctx) => const NotificationsScreen(),
          ChatScreen.routeName: (ctx) => const ChatScreen(),
          MechanicProfileScreen.routeName: (ctx) =>
              const MechanicProfileScreen(),
          ChatRoom.routeName: (ctx) => ChatRoom(),
        },
      ),
    );
  }
}
