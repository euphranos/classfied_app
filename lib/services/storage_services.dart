import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageServices {
  var storageServices = FirebaseStorage.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> uploadImage(String pathName, Uint8List file) async {
    var ref = storageServices
        .ref()
        .child(pathName)
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
