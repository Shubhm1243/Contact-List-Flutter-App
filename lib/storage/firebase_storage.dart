import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Storage {
  User? user = FirebaseAuth.instance.currentUser;

  Future addNewContacts(String name, String phone, String email) async {
    Map<String, dynamic> data = {"name": name, "phone": phone, "email": email};
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('contacts')
          .add(data);
      print('Documented added');
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<String?> getContactName(String docID) async {
    if (docID == null || docID.isEmpty) {
      print('Invalid docID: $docID');
      return null;
    }
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('contacts')
          .doc(docID)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['name'] as String?;
      }

      return null; // Return null if the document doesn't exist
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> getContactNumber(String docID) async {
    if (docID == null || docID.isEmpty) {
      print('Invalid docID: $docID');
      return null;
    }
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('contacts')
          .doc(docID)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['phone'] as String?;
      }

      return null; // Return null if the document doesn't exist
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> getContactEmail(String docID) async {
    if (docID == null || docID.isEmpty) {
      print('Invalid docID: $docID');
      return null;
    }
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('contacts')
          .doc(docID)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['email'] as String?;
      }

      return null; // Return null if the document doesn't exist
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<QuerySnapshot> getContacts({String? searchQuery}) async* {
    var contactsQuery = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('contacts')
        .orderBy("name");

    if(searchQuery != null && searchQuery.isNotEmpty){
      String searchEnd = searchQuery.substring(0, searchQuery.length - 1) +
          String.fromCharCode(searchQuery.codeUnitAt(searchQuery.length - 1) + 1);
      contactsQuery = contactsQuery.where("name",isGreaterThanOrEqualTo: searchQuery, isLessThan: searchEnd);

    }
    var contacts = contactsQuery.snapshots();
    yield* contacts;
  }

  //editing contacts
  Future editContacts(
      String name, String phone, String email, String docID) async {
    Map<String, dynamic> data = {"name": name, "phone": phone, "email": email};
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('contacts')
          .doc(docID)
          .update(data);
      print('Documented updated');
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future deleteContact(String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('contacts')
          .doc(docID)
          .delete();
      print('deleted');
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }
}
