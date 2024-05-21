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
  TextEditingController roomStatus = TextEditingController();
  TextEditingController waterAvailability = TextEditingController();
  TextEditingController electricityAvailability = TextEditingController();
  TextEditingController paymentDuration = TextEditingController();
  TextEditingController availableRooms = TextEditingController();
  static const List<String> list = <String>['Both', 'Male', 'Female'];
  String dropdownValue = list.first;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
    SizedBox size = const SizedBox(
      height: 20,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(height: 0.1),
                        onChanged: (String? value) {
                          setState(() {});
                        },
                        controller: location,
                        decoration: const InputDecoration(
                          hintText: 'Location',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(height: 0.1),
                        onChanged: (String? value) {
                          setState(() {});
                        },
                        controller: postCode,
                        decoration: const InputDecoration(
                          hintText: 'Post Code',
                        ),
                      ),
                    ),
                  ],
                ),
                size,
                TextField(
                  onChanged: (String? value) {
                    setState(() {});
                  },
                  controller: electricityAvailability,
                  decoration: const InputDecoration(
                    hintText: 'electricity status',
                  ),
                ),
                size,
                TextField(
                  onChanged: (String? value) {
                    setState(() {});
                  },
                  controller: waterAvailability,
                  decoration: const InputDecoration(
                    hintText: 'Water status',
                  ),
                ),
                size,

                TextField(
                  onChanged: (String? value) {
                    setState(() {});
                  },
                  controller: roomStatus,
                  decoration: const InputDecoration(
                    hintText: 'Room status',
                  ),
                ),
                size,
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (String? value) {
                          setState(() {});
                        },
                        controller: paymentDuration,
                        decoration: const InputDecoration(
                          hintText: 'Payment Duration',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (String? value) {
                          setState(() {});
                        },
                        controller: availableRooms,
                        decoration: const InputDecoration(
                          hintText: 'Available rooms',
                        ),
                      ),
                    ),
                  ],
                ),
                size,
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                      'Allowed Gender',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        hint: const Text(
                          'Allowed Gender',
                          style: TextStyle(color: Colors.black),
                        ),
                        value: dropdownValue,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                        icon: const Icon(Icons.arrow_upward),
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                      ),
                    ),
                  ],
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
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.blue),
                  child: const Text('upload image'),
                ),
                size,
                (image == null ||
                        postCode.text.isEmpty ||
                        location.text.isEmpty ||
                        contact.text.isEmpty ||
                        price.text.isEmpty||
                        electricityAvailability.text.isEmpty||
                        waterAvailability.text.isEmpty||
                        paymentDuration.text.isEmpty||
                        availableRooms.text.isEmpty||
                        roomStatus.text.isEmpty
                )
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
                                imageUrl,
                              electricityAvailability.text,
                              waterAvailability.text,
                              paymentDuration.text,
                              availableRooms.text,
                              dropdownValue,
                              roomStatus.text
                            );
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
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.blue,
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
      ),
    );
  }
}
