import 'package:flutter/material.dart';
import 'package:hub/screens/home.dart';
import 'package:hub/screens/welcome.dart';
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
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: IconButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Welcome(),
                    ),
                  ),
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login Here',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
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
                          builder: (context) => const Home(),
                        ),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });
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
                      : const Text(
                          'login',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
