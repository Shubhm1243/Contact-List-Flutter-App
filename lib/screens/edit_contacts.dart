import 'package:flutter/material.dart';
import 'package:my_contacts_app/storage/firebase_storage.dart';
import 'package:my_contacts_app/widgets/snackbar.dart';
import '../widgets/text_filed_inputs.dart';
import 'homepage.dart';

class EditContacts extends StatefulWidget {
  const EditContacts(
      {Key? key,
      required this.docID,
      required this.name,
      required this.phone,
      required this.email})
      : super(key: key);
  final String docID, name, phone, email;

  @override
  State<EditContacts> createState() => _EditContactsState();
}

class _EditContactsState extends State<EditContacts> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
    _nameController.text = widget.name;
    _phoneController.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit contact'),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Storage().editContacts(_nameController.text,
                    _phoneController.text, _emailController.text, widget.docID);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Column(
            children: [
              TextFieldInput(
                hintText: 'Enter Name',
                textEditingController: _nameController,
                textInputType: TextInputType.text,
                isPass: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                hintText: 'Enter Phone Number',
                textEditingController: _phoneController,
                textInputType: TextInputType.phone,
                isPass: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  if (value.length < 10) {
                    return 'Phone number should have at least 10 digits';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                hintText: 'Enter email',
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
                isPass: false,
              ),
              const SizedBox(
                height: 40,
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
                    Storage().deleteContact(widget.docID);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                    showSnackBar(context, "Contact Deleted Successfully");
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete,color: Colors.red,),
                      SizedBox(width: 8,),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
