import 'package:flutter/material.dart';
class RoomDetails extends StatelessWidget {
  final String roomId;
  const RoomDetails({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
       children: <Widget>[
     Image.asset(
     'assets/images/background.png',
       fit: BoxFit.cover,
       width: double.infinity,
       height: double.infinity,
     ),
         Center(
           child: Text(roomId),
         ),
      ],
     ),
    );
  }
}
