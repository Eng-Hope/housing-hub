import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hub/screens/room_request.dart';

class RoomInfo extends StatelessWidget {
  final String postCode;
  final String contact;
  final String price;
  final String imageUrl;
  final String userId;
  final String location;
  final String electricityAvailability;
  final String waterAvailability;
  final String paymentDuration;
  final String availableRooms;
  final String allowedGender;
  final String roomStatus;
  final String roomId;

  RoomInfo({
    super.key,
    required this.userId,
    required this.postCode,
    required this.contact,
    required this.electricityAvailability,
    required this.waterAvailability,
    required this.paymentDuration,
    required this.availableRooms,
    required this.allowedGender,
    required this.roomStatus,
    required this.price,
    required this.imageUrl,
    required this.roomId,
    required this.location,
  });
  final TextStyle style = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: IconButton(onPressed: ()=>{
              Navigator.pop(context),
            }, icon: const Icon(Icons.arrow_back, color: Colors.white,),),
          ),
          Image.network(imageUrl),
          Card(
            color: Colors.white60,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Location : $location',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Post Code : $postCode',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Available rooms : $availableRooms',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Room Status : $roomStatus',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Price : $price',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Payment Duration : $paymentDuration',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Water : $waterAvailability',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Electricity : $electricityAvailability',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Allowed Gender : $allowedGender',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Contact : $contact',
                      style: style,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 5),
            child: Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RoomsRequests(roomId: roomId, userId: userId),
                    ),
                  ),
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    )),
                child: const Text(
                  'Make a request',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
