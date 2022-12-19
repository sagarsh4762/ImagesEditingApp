import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white24,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.black38,
          ),
          title: Text(
            text,
            style: const TextStyle(
                color: Colors.black38,
                fontSize: 19,
                fontFamily: "Source Sans Pro"),
          ),
        ),
      ),
    );
  }
}
