import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone/User/model/message.dart';
import 'package:skype_clone/User/model/user.dart';

class CloudFirestoreAPI {
  final String USERS = "users";

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void updateUserData(UserModel user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return await ref.set(
      {
        'uid': user.uid,
        'searchKey': user.searchKey,
        'name': user.name,
        'email': user.email,
        'photoURL': user.photoURL,
        'lastSignIn': DateTime.now()
      },
    );
  }

  Future<void> addMessageToDb(
      Message message, UserModel sender, UserModel receiver) {
    var map = message.toMap();

    _db
        .collection("messages")
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    return _db
        .collection("messages")
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }
}
