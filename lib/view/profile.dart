// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:wallpaper_app/view/info_card.dart';

class ProfileDetail extends StatefulWidget {
  static const url = "Images Editing App";
  static const email = "sharma9785sagar007@gmail.com";
  static const location = "Rajasthan, India";

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
        backgroundColor: Colors.white24,
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/favicon.jpg'),
              ),
              const Text(
                "Sagar Sharma",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
              const Text(
                "Flutter Developer",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black38,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Source Sans Pro"),
              ),
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),

              // we will be creating a new widget name info carrd

              InfoCard(
                  text: ProfileDetail.url,
                  icon: Icons.web,
                  onPressed: () async {}),
              InfoCard(
                  text: ProfileDetail.location,
                  icon: Icons.location_city,
                  onPressed: () async {}),
              InfoCard(
                  text: ProfileDetail.email,
                  icon: Icons.email,
                  onPressed: () async {}),
            ],
          ),
        ));
  }
}
