// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:classifield_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:classifield_app/models/classifield.dart';

class ClassifieldWidget extends StatelessWidget {
  final Classifieds classifieds;
  const ClassifieldWidget({
    Key? key,
    required this.classifieds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(classifieds: classifieds),
              ));
        },
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 200,
                child: Image.network(
                  classifieds.classifeldImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 200,
                child: Column(
                  children: [
                    Text(
                      classifieds.classifieldTitle,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(classifieds.classifieldDescribe),
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
