import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final supabase = Supabase.instance.client;

Future<String> uploadRoomImage(XFile image) async {
  late String publicUrl;
  try {
    final String key = const Uuid().v4();
    const String storageDomain =
        "https://qglhbkwrcpbvunzwucpk.supabase.co/storage/v1/object/public/";
    final String path =
        await supabase.storage.from('images').upload(key, File(image.path));
    publicUrl = '$storageDomain/$path';
  } catch (e) {
    publicUrl = "";
  }
  return publicUrl;
}

Future<bool> addRoom(String postCode, String location, String contact,
    int price, String imageUrl, String electricityAvailability, String waterAvailability,
    String paymentDuration, String availableRooms, String allowedGender, String roomStatus) async {
  bool isAdded = false;
  try {
    await supabase.from('rooms').insert({
      'postCode': postCode,
      'location': location,
      'contact': contact,
      'price': price,
      'imageUrl': imageUrl,
      'userId': supabase.auth.currentUser!.id,
      'electricityAvailability': electricityAvailability,
      'waterAvailability': waterAvailability,
      'paymentDuration': paymentDuration,
      'availableRooms': availableRooms,
      'allowedGender': allowedGender,
      'status': roomStatus,

    });
    isAdded = true;
  } catch (e) {
    isAdded = false;
  }
  return isAdded;
}

Future<bool> sendRequest(String fullName, String location, String contacts,
    String description, String roomId, String userId) async {
  bool isSent = false;
  try {
    await supabase.from('request').insert({
      'fullName': fullName,
      'location': location,
      'contacts': contacts,
      'roomId': roomId,
      'description': description,
      'userId': userId,
    });
    isSent = true;
  } catch (e) {
    isSent = false;
  }
  return isSent;
}

Future<Map<String, dynamic>> getRoom(String roomId) async {
  return await supabase.from('rooms')
      .select()
      .eq('id', roomId)
      .single();
}
