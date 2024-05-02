import 'package:flutter/material.dart';
import 'package:hub/Repository/functionalities.dart';

class RoomsDetails extends StatefulWidget {
  final int roomId;
  const RoomsDetails({super.key, required this.roomId});

  @override
  State<RoomsDetails> createState() => _RoomsDetailsState();
}

class _RoomsDetailsState extends State<RoomsDetails> {
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Request Room'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (String? value) {
                  setState(() {});
                },
                controller: fullName,
                decoration: const InputDecoration(
                  hintText: 'Full Name ',
                ),
              ),
              size,
              TextField(
                onChanged: (String? value) {
                  setState(() {});
                },
                controller: location,
                decoration: const InputDecoration(
                  hintText: 'Location',
                ),
              ),
              size,
              TextField(
                onChanged: (String? value) {
                  setState(() {});
                },
                controller: contact,
                decoration: const InputDecoration(
                  hintText: 'Contact',
                ),
              ),
              size,
              TextField(
                onChanged: (String? value) {
                  setState(() {});
                },
                controller: description,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
              size,
              (fullName.text.isEmpty ||
                      location.text.isEmpty ||
                      contact.text.isEmpty ||
                      description.text.isEmpty)
                  ? const Text(
                      'fill the form',
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
                            widget.roomId.toString());
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
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 52),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('submit'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
