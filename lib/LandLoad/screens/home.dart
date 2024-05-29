import 'package:flutter/material.dart';
import 'package:hub/LandLoad/screens/request_details.dart';
import 'package:hub/Repository/functionalities.dart';
import 'package:hub/LandLoad/screens/homedrawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = supabase.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
    final requests = supabase.from('request').select().eq('userId', user!.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request'),
      ),
      drawer: const HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder(
                  future: requests,
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
                              final request = data[index];
                              String location = request['location'];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: ListTile(
                                  tileColor: Colors.black12,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 1),
                                  leading: const CircleAvatar(
                                    child: Icon(Icons.person),
                                  ),
                                  title: Text(
                                    request['fullName'] + ' ($location)',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    request['description'].toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          request['contacts'].toString(),
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RequestDetails(
                                                  requestId:
                                                      request['id'].toString(),
                                                ),
                                              ),
                                            ),
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                          child: const Text('view'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
