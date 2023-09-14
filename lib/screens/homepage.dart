import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_contacts_app/auth/auth.dart';
import 'package:my_contacts_app/screens/add_contact.dart';
import 'package:my_contacts_app/storage/firebase_storage.dart';
import 'contact_details.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<QuerySnapshot> _stream;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchfocusNode = FocusNode();

  @override
  void initState() {
    _stream = Storage().getContacts();
    super.initState();
  }

  @override
  void dispose() {
    _searchfocusNode.dispose();
    super.dispose();
  }

  searchContacts(String search) {
    _stream = Storage().getContacts(searchQuery: search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width * 0.8, 80),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              onChanged: (value) {
                searchContacts(value);
                setState(() {});
              },
              controller: _searchController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text('Search'),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            _searchfocusNode.unfocus();
                            _stream = Storage().getContacts();
                          },
                          icon: const Icon(Icons.close),
                        )
                      : null),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddContacts(),
            ),
          );
        },
        child: const Icon(Icons.person_add_alt),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    maxRadius: 40,
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email
                          .toString()[0]
                          .toUpperCase(),
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                AuthMethods().signout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: ListTile(
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.logout),
                ),
                title: const Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("Loading"),
              );
            }
            // return ListView(
            //   children: snapshot.data!.docs
            //       .map((DocumentSnapshot document) {
            //         Map<String, dynamic> data =
            //             document.data()! as Map<String, dynamic>;
            //
            //         return ListTile(
            //           leading: CircleAvatar(
            //             child: Text(data["name"][0]),
            //           ),
            //           title: Text(data["name"]),
            //           subtitle: Text(data["phone"]),
            //           trailing: IconButton(
            //             icon: const Icon(Icons.call),
            //             onPressed: () {},
            //           ),
            //         );
            //       })
            //       .toList()
            //       .cast(),
            // );
            return snapshot.data!.docs.isEmpty
                ? const Center(
                    child: Text('No Contacts Found'),
                  )
                : ListView(
                    children: snapshot.data!.docs
                        .where((document) =>
                            document.data() != null) // Filter out null data
                        .map((DocumentSnapshot document) {
                      Map<String, dynamic>? data =
                          document.data() as Map<String, dynamic>?;

                      if (data == null || data["name"] == null) {
                        return const Text(
                            'Empty Contacts'); // Return an empty widget or another appropriate fallback
                      }

                      String name = data["name"];
                      String phone = data["phone"];

                      return TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  //     EditContacts(
                                  //   docID: document.id,
                                  //   name: data["name"],
                                  //   phone: data["phone"],
                                  //   email: data["email"],
                                  // ),
                                  ContactDetailsScreen(
                                docID: document.id,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 26,
                            child: Text(name.isNotEmpty
                                ? name[0]
                                : ''), // Handle empty name
                          ),
                          title: Text(name),
                          subtitle: Text(phone),
                        ),
                      );
                    }).toList(),
                  );
          }),
    );
  }
}
