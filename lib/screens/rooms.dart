import 'package:flutter/material.dart';
import 'package:hub/Repository/functionalities.dart';
import 'package:hub/screens/add_rooms.dart';
import 'package:hub/screens/homedrawer.dart';
import 'package:hub/screens/login.dart';
import 'package:hub/screens/room_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  final User? user = supabase.auth.currentUser;

  final rooms = supabase
      .from('rooms')
      .select()
      .eq('userId', supabase.auth.currentUser!.id);

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
    return Scaffold(
      appBar: AppBar(
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
                              vertical: 5, horizontal: 15),
                          itemCount: data!.length,
                          itemBuilder: (context, index) {
                            final room = data[index];
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              leading: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 RoomsDetails(roomId: room['id'],)));
                                  },
                                  child: Image.asset(
                                    'assets/images/room.jpeg',
                                    height: 100,
                                  )),
                              title: Text(
                                room['location'],
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                room['price'].toString(),
                                style: const TextStyle(fontSize: 15),
                              ),
                              trailing: Text(
                                room['contact'].toString(),
                                style: const TextStyle(fontSize: 17),
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
