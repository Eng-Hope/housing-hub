
import 'package:flutter/material.dart';
import 'package:hub/Repository/functionalities.dart';
import 'package:hub/screens/homedrawer.dart';
import 'package:hub/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    final requests =  supabase.from('request').select();
    return  Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      drawer: const HomeDrawer(),
      body:  Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Text('Requests', style: TextStyle(fontSize: 22),),
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

                              return ListTile(
                                contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                                leading:  CircleAvatar(
                                  child: Text(
                                   request['roomId'].toString(), style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                title: Text(
                                  request['fullName']+' ($location)',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  request['description'].toString(),
                                  style: const TextStyle(fontSize: 15),
                                ),
                                trailing: Text(
                                  request['contacts'].toString(),
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
      ),
    );
  }
}
