// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currUser = FirebaseAuth.instance.currentUser!.uid;
    bool isMe = message.senderId == currUser ? true : false;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
      child: SizedBox(
        height: 40,
        width: 100,
        child: Column(
          crossAxisAlignment:
              isMe == true ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: isMe == true
                    ? Colors.green.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.6),
              ),
              child: Text(
                message.message,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
