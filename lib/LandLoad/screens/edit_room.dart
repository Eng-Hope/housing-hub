import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hub/screens/rooms.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Repository/functionalities.dart';
import '../../screens/homedrawer.dart';
import '../../screens/login.dart';

class EditRoom extends StatefulWidget {
  final String postCode;
  final String contact;
  final String price;
  final String imageUrl;
  final String userId;
  final String location;
  final String electricityAvailability;
  final String waterAvailability;
  final String paymentDuration;
  final String availableRooms;
  final String allowedGender;
  final String roomStatus;
  final String roomId;

   const EditRoom({
     super.key,
     required this.userId,
     required this.postCode,
     required this.contact,
     required this.electricityAvailability,
     required this.waterAvailability,
     required this.paymentDuration,
     required this.availableRooms,
     required this.allowedGender,
     required this.roomStatus,
     required this.price,
     required this.imageUrl,
     required this.roomId,
     required this.location,
});

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
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
  void initState() {
    super.initState();
    location.text = widget.location.toString();
    postCode.text = widget.postCode.toString();
    electricityAvailability.text = widget.electricityAvailability.toString();
    waterAvailability.text = widget.waterAvailability.toString();
    roomStatus.text = widget.roomStatus.toString();
    paymentDuration.text = widget.paymentDuration.toString();
    availableRooms.text = widget.availableRooms.toString();
    dropdownValue = widget.allowedGender.toString();
    contact.text = widget.contact.toString();
    price.text = widget.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
    SizedBox size = const SizedBox(
      height: 20,
    );
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text(
          'Edit Room',
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
                Card(
                  color: Colors.white12,
                  child: SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: image == null? Image.network(widget.imageUrl, fit: BoxFit.fill,): Image.file(File(image!.path), fit: BoxFit.fill,),
                  ),
                ),
                size,
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(height: 0.1),
                        onChanged: (String? value) {
                          setState(() {
                          location.text = value!;
                          });
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
                          setState(() {
                            postCode.text = value!;
                          });
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
                    setState(() {
                      electricityAvailability.text = value!;
                    });
                  },
                  controller: electricityAvailability,
                  decoration: const InputDecoration(
                    hintText: 'electricity status',
                  ),
                ),
                size,
                TextField(
                  onChanged: (String? value) {
                    setState(() {
                      waterAvailability.text = value!;
                    });
                  },
                  controller: waterAvailability,
                  decoration: const InputDecoration(
                    hintText: 'Water status',
                  ),
                ),
                size,

                TextField(
                  onChanged: (String? value) {
                    setState(() {
                      roomStatus.text = value!;
                    });
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
                          setState(() {
                            paymentDuration.text = value!;
                          });
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
                          setState(() {
                            availableRooms.text = value!;
                          });
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
                    setState(() {
                      contact.text = value!;
                    });
                  },
                  controller: contact,
                  decoration: const InputDecoration(
                    hintText: 'Contact',
                  ),
                ),
                size,
                TextField(
                  onChanged: (String? value) {
                    setState(() {
                      price.text = value!;
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
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.blue),
                  child: const Text('upload new image', style: TextStyle(
                    fontSize: 16,
                  ),),
                ),
                size,
                (   postCode.text.isEmpty ||
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

                    late bool status;

                    if(image != null){
                      String imageUrl = await uploadRoomImage(image!);
                      if (imageUrl.isEmpty) {
                      } else {
                        status = await editRoom(
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
                            roomStatus.text,
                            widget.roomId.toString(),
                        );

                        if (status) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'room changed successfully',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Rooms(),),);
                        } else if (status == false) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                              content: Text(
                                'an error has occurred',
                                style: TextStyle(color: Colors.redAccent),
                              )));
                        }
                      }
                    }
                    else if(image == null){
                        status = await editRoom(
                            postCode.text,
                            location.text,
                            contact.text,
                            int.parse(price.text),
                            widget.imageUrl,
                            electricityAvailability.text,
                            waterAvailability.text,
                            paymentDuration.text,
                            availableRooms.text,
                            dropdownValue,
                            roomStatus.text,
                            widget.roomId,
                        );
                        if (status) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'room changed successfully',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Rooms(),),);
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
                      : const Text('edit', style: TextStyle(
                    fontSize: 16,
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
