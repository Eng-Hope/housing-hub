import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hub/Repository/functionalities.dart';
import 'package:hub/screens/home.dart';
import 'package:hub/screens/login.dart';
import 'package:hub/screens/room_request.dart';
import 'package:hub/screens/welcome.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jylqmcgxltifhynbxebv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp5bHFtY2d4bHRpZmh5bmJ4ZWJ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM0NTU4MzIsImV4cCI6MjAyOTAzMTgzMn0.F3VtLhX_8MwjfErDpshdbNUjwnGqskBHFVdC90oJzeE',
  );
  runApp(const Welcome());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final User? user = supabase.auth.currentUser;
String q = "";
  @override
  Widget build(BuildContext context) {
    final rooms = supabase.from('rooms').select().like('location', '%$q%');
    return  Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child:  Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const Welcome(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_back, color: Colors.white,),);
                    },
                  ),),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
                child: TextField(
                  onChanged: (String? value){
                    if(value != null){
                      setState(() {
                        q = value;
                      });
                    }
                  },
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: 'Search for rooms',
                    contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                  ),
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
                                          builder: (context) => RoomsDetails(
                                            roomId: room['id'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/room.jpeg',
                                      height: 100,
                                    ),
                                  ),
                                  title: Text(
                                    room['location'],
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
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
        ],),
      );
  }
}
