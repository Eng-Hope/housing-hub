import 'package:flutter/material.dart';
import 'package:hub/Repository/functionalities.dart';
import 'package:hub/screens/room_widget.dart';
import 'package:hub/screens/welcome.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://qglhbkwrcpbvunzwucpk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFnbGhia3dyY3BidnVuend1Y3BrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYxMjQ1NjgsImV4cCI6MjAzMTcwMDU2OH0.R5xc2PNYxZBobez4smwAvB6IBXMC4oRhi1pJAxY01kw',
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
    final rooms = supabase.from('rooms').select('id, price, imageUrl, location, status').like('location', '%$q%');
    return Scaffold(
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
                  child: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Welcome(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 20, right: 20, bottom: 10),
                child: TextField(
                  onChanged: (String? value) {
                    if (value != null) {
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 20),
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
        ],
      ),
    );
  }
}
