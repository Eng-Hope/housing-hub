import 'package:flutter/material.dart';
import 'package:hub/screens/homedrawer.dart';

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(),
      drawer: const HomeDrawer(),
      body: const Center(
        child: Text('rooms'),
      ),
    );
  }
}
