import 'package:flutter/material.dart';
import 'package:hub/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final supabase = Supabase.instance.client;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              style: const TextStyle(
                fontSize: 20,
              ),
              controller: email,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              obscureText: true,
              style: const TextStyle(
                fontSize: 20,
              ),
              controller: password,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  setState(() {
                    isLoading = true;
                  });
                  await supabase.auth.signInWithPassword(
                      email: email.text, password: password.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyApp(),
                    ),
                  );
                  setState(() {
                    isLoading = false;
                  });
                } catch (e) {
                  setState(() {
                    isLoading = false;
                  });
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('login'),
            ),
          ],
        ),
      ),
    );
  }
}
