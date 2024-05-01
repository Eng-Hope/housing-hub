import 'package:flutter/material.dart';
import 'package:hub/screens/homedrawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jylqmcgxltifhynbxebv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp5bHFtY2d4bHRpZmh5bmJ4ZWJ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM0NTU4MzIsImV4cCI6MjAyOTAzMTgzMn0.F3VtLhX_8MwjfErDpshdbNUjwnGqskBHFVdC90oJzeE',
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      home: Scaffold(
        drawer: const HomeDrawer(),
        appBar: AppBar(
          title: const Text('Hub'),
        ),
        body: const Center(
          child: Text('home'),
        ),
      ),
    );
  }
}
