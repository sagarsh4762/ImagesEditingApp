// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/services/firebase_services.dart';
import 'package:wallpaper_app/view/info_card.dart';
import 'package:wallpaper_app/view/login_page.dart';

class ProfileDetail extends StatefulWidget {
  // static const url = "Images Editing App";

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("About Me"),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "${FirebaseAuth.instance.currentUser!.photoURL}"),
              ),
              Text(
                "${FirebaseAuth.instance.currentUser!.displayName}",
                style: const TextStyle(
                  fontSize: 40.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
              // const Text(
              //   "Flutter Developer",
              //   style: TextStyle(
              //       fontSize: 30,
              //       color: Colors.black38,
              //       letterSpacing: 2.5,
              //       fontWeight: FontWeight.bold,
              //       fontFamily: "Source Sans Pro"),
              // ),
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),

              // we will be creating a new widget name info carrd

              // InfoCard(
              //     text: ProfileDetail.url,
              //     icon: Icons.web,
              //     onPressed: () async {}),
              // InfoCard(
              //     text: "${FirebaseAuth.instance.currentUser!.phoneNumber}",
              //     icon: Icons.phone,
              //     onPressed: () async {}),
              InfoCard(
                  text: "${FirebaseAuth.instance.currentUser!.email}",
                  icon: Icons.email,
                  onPressed: () async {}),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () async {
                  await FirebaseServices().signout();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ));
  }
}
