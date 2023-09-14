import 'package:my_contacts_app/storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_contacts_app/widgets/text_filed_inputs.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({Key? key}) : super(key: key);

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Storage().addNewContacts(_nameController.text,
                    _phoneController.text, _emailController.text);

                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
        title: const Text('Add contats'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: TextFieldInput(
                hintText: 'Enter Name',
                textEditingController: _nameController,
                textInputType: TextInputType.text,
                isPass: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid input';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: TextFieldInput(
                hintText: 'Enter Phone Number',
                textEditingController: _phoneController,
                textInputType: TextInputType.phone,
                isPass: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid input';
                  }
                  if (value.length < 10) {
                    return 'Phone number should have at least 10 digits';
                  }
                  return null;
                },

              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: TextFieldInput(
                hintText: 'Enter email',
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
                isPass: false,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 200,
              height: 50,
              child: OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                ),
                onPressed: () {
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8,),
                    Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
