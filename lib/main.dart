import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/Provider/favorite_provider.dart';
import 'package:wallpaper_app/widgets/bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAuCMgHnahCylUkWwGUUJ2RBdY11THl5DM',
          appId: '1:696045029703:android:92be65ce2c91f998686462',
          messagingSenderId: '',
          projectId: 'edify-8f53e'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavouriteProvider(),
      child: const MaterialApp(
        home: BottomNavBar(),
      ),
    );
  }
}
