// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:classifield_app/screens/chat_detail_screen.dart';
import 'package:classifield_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:classifield_app/models/classifield.dart';

class DetailScreen extends StatelessWidget {
  final Classifieds classifieds;
  const DetailScreen({
    Key? key,
    required this.classifieds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              classifieds.classifeldImage,
              fit: BoxFit.fill,
            ),
          ),
          Text(classifieds.classifieldTitle),
          Text(classifieds.classifieldDescribe),
          CustomButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDetailScreen(
                          receiverUserId: classifieds.classfieldOwnerUserId),
                    ));
              },
              text: 'Contact')
        ],
      ),
    );
  }
}
