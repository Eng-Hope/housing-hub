import 'package:flutter/material.dart';
import 'package:hub/Repository/functionalities.dart';

class RoomsRequests extends StatefulWidget {
  final String roomId;
  final String userId;
  const RoomsRequests({super.key, required this.roomId, required this.userId});

  @override
  State<RoomsRequests> createState() => _RoomsRequestsState();
}

class _RoomsRequestsState extends State<RoomsRequests> {
  TextEditingController fullName = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizedBox size = const SizedBox(
      height: 30,
    );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white,),
                  );
                }
            ),
          ),

          Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Request Room', style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                                 ),
                ),

                const SizedBox(height: 35,),
                TextField(
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (String? value) {
                    setState(() {});
                  },
                  controller: fullName,
                  decoration: const InputDecoration(
                    hintText: 'Full Name ',
                    filled: true,
                  ),
                ),
                size,
                TextField(
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (String? value) {
                    setState(() {});
                  },
                  controller: location,
                  decoration: const InputDecoration(
                    hintText: 'Location',
                    filled: true,
                  ),
                ),
                size,
                TextField(
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (String? value) {
                    setState(() {});
                  },
                  controller: contact,
                  decoration: const InputDecoration(
                    hintText: 'Contact',
                    filled: true
                  ),
                ),
                size,
                TextField(
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (String? value) {
                    setState(() {});
                  },
                  controller: description,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    filled: true,
                  ),
                ),
                size,
                (fullName.text.isEmpty ||
                        location.text.isEmpty ||
                        contact.text.isEmpty ||
                        description.text.isEmpty)
                    ? const Text(
                        'fill this form',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          bool status = await sendRequest(
                              fullName.text,
                              location.text,
                              contact.text,
                              description.text,
                              widget.roomId,
                              widget.userId
                          );
                          setState(() {
                            isLoading = false;
                          });
                          if (status) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'request sent successfully',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          } else if (status == false) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Text(
                                  'an error has occurred',
                                  style: TextStyle(color: Colors.redAccent),
                                )));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 52),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text('submit', style: TextStyle(
                          fontSize: 20,
                        ),),
                      ),
              ],
            ),
          ),
        ),
      ],),
    );
  }
}
