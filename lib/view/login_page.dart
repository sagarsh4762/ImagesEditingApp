// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wallpaper_app/services/firebase_services.dart';
import 'package:wallpaper_app/widgets/bottom_navbar.dart';

import '../widgets/customAppBar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: CustomAppBar(),
      ),
      body: Center(
        child: FloatingActionButton.extended(
          onPressed: () async {
            await FirebaseServices().signInWithGoogle();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BottomNavBar()));
          },
          icon: Image.asset(
            'assets/google_logo.jpg',
            height: 32,
            width: 32,
          ),
          label: const Text("Sign in with Google"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
