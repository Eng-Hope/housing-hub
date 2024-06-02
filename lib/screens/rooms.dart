import 'package:flutter/material.dart';
import 'package:hub/LandLoad/screens/room_widget.dart';
import 'package:hub/Repository/functionalities.dart';
import 'package:hub/LandLoad/screens/homedrawer.dart';
import 'package:hub/LandLoad/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'add_rooms.dart';

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  final User? user = supabase.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
    final rooms = supabase
        .from('rooms')
        .select()
        .eq('userId', supabase.auth.currentUser!.id);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()=>{
            setState(() {
            }),
          }, icon: const Icon(Icons.refresh),),
        ],
        title: const Text(
          'Rooms',
          style: TextStyle(fontSize: 26),
        ),

      ),
      drawer: const HomeDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'registered rooms',
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddRooms(),
                      ),
                    );
                  },
                  child: const Text('new'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: rooms,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('no data found'),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('an error has occured'),
                      );
                    } else {
                      final data = snapshot.data;
                      return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          itemCount: data!.length,
                          itemBuilder: (context, index) {
                            final room = data[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Room(
                                location: room['location'].toString(),
                                imageUrl: room['imageUrl'].toString(),
                                roomStatus: room['status'].toString(),
                                price: room['price'].toString(),
                                roomId: room['id'].toString(),
                              ),
                            );
                          });
                    }
                  }
                }),
          ),
        ],
      ),
    );
  }
}
