import 'package:flutter/material.dart';
import 'package:hub/LandLoad/screens/room_info_widget.dart';
import 'package:hub/Repository/functionalities.dart';
class RoomDetails extends StatelessWidget {
  final String roomId;
  const RoomDetails({super.key, required this.roomId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder(
              future: getRoom(roomId),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('no data found'),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('an error has occurred'),
                    );
                  } else {
                    final room = snapshot.data!;
                    return RoomInfo(
                      userId: room['userId'].toString(),
                      postCode: room['postCode'].toString(),
                      contact: room['contact'].toString(),
                      electricityAvailability:
                      room['electricityAvailability'].toString(),
                      waterAvailability: room['waterAvailability'].toString(),
                      paymentDuration: room['paymentDuration'].toString(),
                      availableRooms: room['availableRooms'].toString(),
                      allowedGender: room['allowedGender'].toString(),
                      roomStatus: room['status'].toString(),
                      price: room['price'].toString(),
                      imageUrl: room['imageUrl'].toString(),
                      location: room['location'].toString(),
                      roomId: roomId,
                    );
                  }
                }
              }),
        ],
      ),
    );
  }
}
