import 'package:classifield_app/models/classifield.dart';
import 'package:classifield_app/services/auth_services.dart';
import 'package:classifield_app/services/db_services.dart';
import 'package:classifield_app/widgets/custom_button.dart';
import 'package:classifield_app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String url =
      'https://arabam-blog.mncdn.com/wp-content/uploads/2021/03/07_5-1068x602.jpg';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currUserId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFieldInput(
                  text: 'Title', textEditingController: _titleController),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFieldInput(
                  text: 'Describe', textEditingController: _descController),
            ),
            CustomButton(
                onTap: () {
                  Classifieds classifieds = Classifieds(
                      currUserId,
                      const Uuid().v4(),
                      _titleController.text,
                      _descController.text,
                      url,
                      DateTime.now());
                  DbServices().saveClassifield(classifieds);
                },
                text: 'PUBLISH'),
          ],
        ),
      ),
    );
  }
}
