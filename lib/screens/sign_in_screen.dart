import 'package:classifield_app/screens/sign_up_screen.dart';
import 'package:classifield_app/services/db_services.dart';
import 'package:classifield_app/services/storage_services.dart';
import 'package:classifield_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../models/user.dart';
import '../services/auth_services.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  Uint8List? _img;
  String profilePhotoUrl =
      'https://st4.depositphotos.com/11634452/41441/v/600/depositphotos_414416674-stock-illustration-picture-profile-icon-male-icon.jpg';

  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();

    passwordController.dispose();
    super.dispose();
  }

  getImage() async {
    Uint8List? image = await pickImage(ImageSource.gallery);

    setState(() {
      _img = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SIGN IN',
                style: TextStyle(fontSize: 35),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  getImage();
                },
                child: Container(
                  child: _img == null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(profilePhotoUrl),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(_img!),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFieldInput(
                  text: 'Username',
                  textEditingController: userNameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFieldInput(
                  text: 'Email',
                  textEditingController: emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFieldInput(
                  text: 'Password',
                  textEditingController: passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomButton(
                    onTap: () async {
                      print('tiklandı');
                      UserModel user = UserModel(
                          const Uuid().v4(),
                          userNameController.text.trim(),
                          profilePhotoUrl,
                          emailController.text.trim(),
                          passwordController.text.trim());
                      print(user.userEmail);

                      String res =
                          await AuthServices().signInWithEmailAndPassword(user);
                      print(res);
                      if (res == 'Success' && _img != null) {
                        String downloadUrl = await StorageServices()
                            .uploadImage('profilePhotos', _img!);
                        user.userPhoto = downloadUrl;
                        await DbServices().saveUserToDatabase(user);
                      }
                    },
                    text: 'SIGN IN'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                },
                child: Text('SIGN IN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
