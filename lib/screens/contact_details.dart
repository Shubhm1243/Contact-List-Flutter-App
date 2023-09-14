import 'package:flutter/material.dart';
import 'package:my_contacts_app/storage/firebase_storage.dart';
import 'edit_contacts.dart';

class ContactDetailsScreen extends StatefulWidget {
  final String docID;

  const ContactDetailsScreen({Key? key, required this.docID}) : super(key: key);

  @override
  _ContactDetailsScreenState createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  String? contactName; // Variable to store the fetched contact name
  String? contactNumber;
  String? contactEmail;

  @override
  void initState() {
    super.initState();
    fetchContactName(widget.docID);
    fetchContactNumber(widget.docID);
    fetchContactEmail(widget.docID);

  }

  Future<void> fetchContactName(String docID) async {
    final name = await Storage().getContactName(docID);
    setState(() {
      contactName = name;
    });
  }
  Future<void> fetchContactNumber(String docID) async {
    final number = await Storage().getContactNumber(docID);
    setState(() {
      contactNumber = number;
    });
  }
  Future<void> fetchContactEmail(String docID) async {
    final em = await Storage().getContactEmail(docID);
    setState(() {
      contactEmail = em;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditContacts(
                    docID: widget.docID,
                    name: contactName ?? '',
                    phone: contactNumber??'', // Replace with the actual phone value
                    email: contactEmail??'', // Replace with the actual email value
                  ),
                ),
              );
            },
            child: const Text('Edit'),
          ),
        ],
        title: const Text('Contact Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                child: Text(
                  contactName?.substring(0, 1) ?? '?',
                  style: const TextStyle(fontSize: 36),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                contactName ?? 'Loading...',
                // Display "Loading..." while fetching
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    child: IconButton(
                      icon: const Icon(Icons.call),
                      onPressed: () {},
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      icon: const Icon(Icons.message),
                      onPressed: () {},
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      icon: const Icon(Icons.video_call),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
