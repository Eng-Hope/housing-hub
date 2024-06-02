import 'package:flutter/material.dart';
import 'package:hub/LandLoad/screens/edit_room.dart';
import 'package:hub/Repository/functionalities.dart';
import 'package:hub/screens/rooms.dart';

class RoomInfo extends StatefulWidget {
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

  const RoomInfo({
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

  @override
  State<RoomInfo> createState() => _RoomInfoState();
}

class _RoomInfoState extends State<RoomInfo> {
  final TextStyle style = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size,
            height: 300,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
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
                      'Location : ${widget.location}',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Post Code : ${widget.postCode}',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Available rooms : ${widget.availableRooms}',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Room Status : ${widget.roomStatus}',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Price : ${widget.price}',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Payment Duration : ${widget.paymentDuration}',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Water : ${widget.waterAvailability}',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Electricity : ${widget.electricityAvailability}',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Allowed Gender : ${widget.allowedGender}',
                      style: style,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Contact : ${widget.contact}',
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  EditRoom(
                          userId: widget.userId,
                          postCode: widget.postCode,
                          contact: widget.contact,
                          electricityAvailability: widget.electricityAvailability,
                          waterAvailability: widget.waterAvailability,
                          paymentDuration: widget.paymentDuration,
                          availableRooms: widget.availableRooms,
                          allowedGender: widget.allowedGender,
                          roomStatus: widget.roomStatus,
                          price: widget.price,
                          imageUrl: widget.imageUrl,
                          roomId: widget.roomId,
                          location: widget.location,
                        ),
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
                          'Edit',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      )),
                  onPressed: () async {
                    showDialog(context: context, builder: (context){
                      return  AlertDialog(
                        title: const Text('Are sure you want to delete this room?'),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),),
                              onPressed: (){
                                Navigator.pop(context);
                              }, child: const Icon(Icons.cancel),),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),),
                              onPressed: () async{
                              setState(() {
                                isLoading = true;
                              });
                              bool isDeleted = await deleteRoom(widget.roomId);
                              setState(() {
                                isLoading = false;
                              });
                              if (isDeleted == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Rooms(),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Room deleted successful' , style: TextStyle(
                                      color: Colors.green,
                                    ),),
                                  ),
                                );
                              }
                              else if(isDeleted == false){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('An error has occurred', style: TextStyle(
                                      color: Colors.red,
                                    ),),
                                  ),
                                );
                              }
                            },  child: isLoading
                                ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ) : const Icon(Icons.delete, color: Colors.red,),),
                          ],
                        ),
                      );
                    });
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
