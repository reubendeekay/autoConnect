import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic/firebase_options.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/providers/admin_user_provider.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/providers/chat_provider.dart';
import 'package:mechanic/providers/location_provider.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:mechanic/screens/chat/chat_screen.dart';
import 'package:mechanic/screens/favourites/favourites_screen.dart';
import 'package:mechanic/screens/home/homepage.dart';
import 'package:mechanic/screens/mechanic/mechanic_dashboard.dart';
import 'package:mechanic/screens/mechanic/mechanic_register_screen.dart';
import 'package:mechanic/screens/my_boookings/my_bookings.dart';
import 'package:mechanic/screens/notifications/notifications_screen.dart';
import 'package:mechanic/screens/user/user_profile.dart';
import 'package:mechanic/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
              snap.hasData ? const Homepage() : const SplashScreen(),
        ),
        routes: {
          Homepage.routeName: (ctx) => const Homepage(),
          UserProfile.routeName: (ctx) => const UserProfile(),
          MyBookingsScreen.routeName: (ctx) => const MyBookingsScreen(),
          FavouritesScreen.routeName: (ctx) => const FavouritesScreen(),
          NotificationsScreen.routeName: (ctx) => const NotificationsScreen(),
          ChatScreen.routeName: (ctx) => const ChatScreen(),
          MechanicRegisterScreen.routeName: (ctx) =>
              const MechanicRegisterScreen(),
          MechanicDashboard.routeName: (ctx) => const MechanicDashboard(),
        },
      ),
    );
  }
}
