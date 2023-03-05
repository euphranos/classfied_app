import 'package:classifield_app/models/user.dart';
import 'package:classifield_app/services/auth_services.dart';
import 'package:classifield_app/services/db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: FutureBuilder<UserModel>(
        future: DbServices().getUser(currentUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            UserModel user = snapshot.data!;
            return Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(user.userPhoto),
                ),
                Text(user.userEmail),
                Text(user.userName),
              ],
            );
          }
          return Center(
            child: Text('error'),
          );
        },
      ),
    );
  }
}
