import 'package:flutter/material.dart';
import 'package:hub/Repository/functionalities.dart';
import 'package:hub/screens/homedrawer.dart';
import 'package:hub/screens/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddRooms extends StatefulWidget {
  const AddRooms({super.key});

  @override
  State<AddRooms> createState() => _AddRoomsState();
}

class _AddRoomsState extends State<AddRooms> {
  final User? user = supabase.auth.currentUser;
  final ImagePicker picker = ImagePicker();
  late XFile? image = null;
  TextEditingController postCode = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController price = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
    SizedBox size = const SizedBox(
      height: 30,
    );
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text(
          'New Room',
          style: TextStyle(fontSize: 26),
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (String? value){
                  setState(() {

                  });
                },
                controller: postCode,
                decoration: const InputDecoration(
                  hintText: 'Post Code',
                ),
              ),
              size,
              TextField(
                onChanged: (String? value){
                  setState(() {

                  });
                },
                controller: location,
                decoration: const InputDecoration(
                  hintText: 'Location',
                ),
              ),
              size,
              TextField(
                onChanged: (String? value){
                  setState(() {

                  });
                },
                controller: contact,
                decoration: const InputDecoration(
                  hintText: 'Contact',
                ),
              ),
              size,
              TextField(
                onChanged: (String? value){
                  setState(() {

                  });
                },
                controller: price,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Price',
                ),
              ),
              size,
              ElevatedButton(
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  foregroundColor: Colors.white,
                ),
                child: const Text('upload image'),
              ),
              size,
              (image == null ||
                      postCode.text.isEmpty ||
                      location.text.isEmpty ||
                      contact.text.isEmpty ||
                      price.text.isEmpty)
                  ? const Text('fill the form')
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        String imageUrl = await uploadRoomImage(image!);
                        if (imageUrl.isEmpty) {
                        } else {
                          bool status = await addRoom(
                              postCode.text,
                              location.text,
                              contact.text,
                              int.parse(price.text),
                              imageUrl);
                          if (status) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'room added successfully',
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
                        }
                        setState(() {
                          isLoading = false;
                        });
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
