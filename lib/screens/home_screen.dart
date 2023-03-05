import 'package:classifield_app/models/classifield.dart';
import 'package:classifield_app/services/db_services.dart';
import 'package:classifield_app/widgets/classfield_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Classifieds>>(
      stream: DbServices().getClassifields(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          List<Classifieds> allClass = snapshot.data!;
          return ListView.builder(
            itemCount: allClass.length,
            itemBuilder: (context, index) {
              return ClassifieldWidget(classifieds: allClass[index]);
            },
          );
        }
        return Center(
          child: Text('error'),
        );
      },
    );
  }
}
