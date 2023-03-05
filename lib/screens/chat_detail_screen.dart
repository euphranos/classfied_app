// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:classifield_app/models/message.dart';
import 'package:classifield_app/services/db_services.dart';
import 'package:classifield_app/widgets/message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class ChatDetailScreen extends StatefulWidget {
  final String receiverUserId;
  const ChatDetailScreen({
    Key? key,
    required this.receiverUserId,
  }) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  TextEditingController _messageController = TextEditingController();
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currUser = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          )),
          IconButton(
            onPressed: () {
              Message message = Message(
                  senderId: currUser,
                  receiverId: widget.receiverUserId,
                  message: _messageController.text,
                  sentTime: DateTime.now());
              DbServices().saveMessage(message);
              _messageController.clear();
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
      body: StreamBuilder<List<Message>>(
        stream: DbServices().getMessages(currUser, widget.receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            List<Message> allMessages = snapshot.data!;
            return ListView.builder(
              itemCount: allMessages.length,
              itemBuilder: (context, index) {
                Message message = allMessages[index];
                return MessageWidget(message: message);
              },
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
