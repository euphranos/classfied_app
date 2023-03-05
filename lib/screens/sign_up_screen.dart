import 'package:classifield_app/models/user.dart';
import 'package:classifield_app/screens/sign_in_screen.dart';
import 'package:classifield_app/services/auth_services.dart';
import 'package:classifield_app/widgets/custom_button.dart';
import 'package:classifield_app/widgets/text_field.dart';
import 'package:flutter/material.dart';

import 'nav_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
              Text(
                'SIGN UP',
                style: TextStyle(fontSize: 35),
              ),
              const SizedBox(height: 20),
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
                      String res = await AuthServices()
                          .signUpWithEmailAndPassword(
                              emailController.text, passwordController.text);
                      if (res == 'Success') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavScreen(),
                            ));
                      } else {
                        print(res);
                      }
                    },
                    text: 'Sign UP'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ));
                },
                child: Text('Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
