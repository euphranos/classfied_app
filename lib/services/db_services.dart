import 'package:classifield_app/models/classifield.dart';
import 'package:classifield_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/message.dart';

class DbServices {
  var dbServices = FirebaseFirestore.instance;
  var currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> saveUserToDatabase(UserModel user) async {
    await dbServices.collection('users').doc(user.userId).set(user.toMap());
  }

  Future<void> saveClassifield(Classifieds classifieds) async {
    await dbServices
        .collection('classifields')
        .doc(classifieds.classifieldId)
        .set(classifieds.toMap());
  }

  Stream<List<Classifieds>> getClassifields() {
    return dbServices
        .collection('classifields')
        .orderBy('classfieldPublishTime')
        .snapshots()
        .map((event) {
      List<Classifieds> allClassifields = [];
      for (var doc in event.docs) {
        Classifieds classified = Classifieds.fromMap(doc.data());
        allClassifields.add(classified);
      }
      return allClassifields;
    });
  }

  Future<UserModel> getUser(String userId) async {
    var ref = await dbServices.collection('users').doc(userId).get();
    UserModel user = UserModel.fromMap(ref.data()!);
    return user;
  }

  Future<void> saveMessage(Message message) async {
    await dbServices
        .collection('messages')
        .doc(message.senderId)
        .collection('messages')
        .doc(message.receiverId)
        .collection('messages')
        .add(message.toMap());
  }

  Stream<List<Message>> getMessages(String senderId, String receiverId) {
    return dbServices
        .collection('messages')
        .doc(senderId)
        .collection('messages')
        .doc(receiverId)
        .collection('messages')
        .orderBy('sentTime')
        .snapshots()
        .map((event) {
      List<Message> allMessages = [];
      for (var doc in event.docs) {
        Message message = Message.fromMap(doc.data());
        allMessages.add(message);
      }
      return allMessages;
    });
  }

  Future<void> getContactedUsers() async {
    var ref = await dbServices
        .collection('messages')
        .doc(currentUserId)
        .collection('messages')
        .get();
    List<String> allUsersIds = [];
    ref.docs.forEach((element) {
      allUsersIds.add(element.id);
    });
  }
}
