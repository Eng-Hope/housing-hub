import 'package:flutter/material.dart';
class Room extends StatelessWidget {
  final String roomId;
  final String location;
  final String imageUrl;
  final String price;
  final String roomStatus;
  const Room(
      {super.key,
      required this.location,
      required this.imageUrl,
      required this.roomStatus,
      required this.price,
      required this.roomId,
      });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return  Card(
      color: Colors.white54,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(location, style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),),
          ),
          SizedBox(
            width: width,
            height: 250,
            child: Image.network(imageUrl, fit: BoxFit.fill,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price : $price Tsh/=', style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),),
                    Text('Status : $roomStatus', style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),),
                  ],
                ),
                ElevatedButton(onPressed: ()=>{},
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )
                  ),
                    child: const Text('view details'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
