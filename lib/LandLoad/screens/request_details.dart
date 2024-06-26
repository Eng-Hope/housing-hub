import 'package:flutter/material.dart';
import 'package:hub/LandLoad/screens/home.dart';
import 'package:hub/LandLoad/screens/homedrawer.dart';
import 'package:hub/Repository/functionalities.dart';

class RequestDetails extends StatefulWidget {
  final String requestId;
  const RequestDetails({super.key, required this.requestId});

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final request = supabase
        .from('request')
        .select(
            'created_at, fullName, location, contacts, description, rooms(imageUrl)')
        .eq('id', widget.requestId)
        .single();

    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('Request Details'),
        centerTitle: false,
      ),
      body: FutureBuilder(
          future: request,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('no data found'),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('an error has occurred'),
                );
              } else {
                final data = snapshot.data!;
                final username = data['fullName'];
                final location = data['location'];
                final contact = data['contacts'];
                final description = data['description'];
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        child: Image.network(data['rooms']['imageUrl']),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tenant Name : $username',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Tenant Location : $location',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Tenant Contact : $contact',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Tenant Comment : $description',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Are you sure you want to delete this request ?'),
                                              content: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () => {
                                                      Navigator.pop(context),
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel,
                                                      size: 35,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      await supabase
                                                          .from('request')
                                                          .delete()
                                                          .match({'id': widget.requestId});
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (contact) =>
                                                          const Home(),
                                                        ),);
                                                    },
                                                    icon: isLoading
                                                        ? const Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    )
                                                        : const Icon(
                                                      Icons.done,
                                                      size: 35,
                                                      color: Colors.green,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                      size: 30,
                                    ),
                                  )),
                            ],
                          )),
                    ],
                  ),
                );
              }
            }
          }),
    );
  }
}
