import 'package:flutter/material.dart';
import 'package:hub/Repository/functionalities.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home.dart';
import 'login.dart';
import 'rooms.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool isLoading = false;
  final User? user = supabase.auth.currentUser;
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user!.email!),
            accountEmail: const Text('user@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(user!.email![0].toUpperCase()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('home'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Request'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.house),
            title: const Text('rooms'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Rooms()));
            },
          ),
          ListTile(
            leading: isLoading
                ? const CircularProgressIndicator(
                    value: .5,
                  )
                : const Icon(Icons.logout),
            title: const Text('logout'),
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              try {
                await supabase.auth.signOut();
                setState(() {
                  isLoading = false;
                });
              } catch (e) {
                setState(() {
                  isLoading = false;
                });
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //       content: Row(
                //     children: [
                //       Icon(Icons.dangerous),
                //       Text(
                //         'an error has occurred try again',
                //         style: TextStyle(color: Colors.redAccent),
                //       ),
                //     ],
                //   )),
                // );
              }
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            title: const Text(
              'delete account',
              style: TextStyle(color: Colors.redAccent,),
            ),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
