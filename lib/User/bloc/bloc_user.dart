import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skype_clone/User/model/message.dart';
import 'package:skype_clone/User/model/user.dart';
import 'package:skype_clone/User/repository/auth_repository.dart';
import 'package:skype_clone/User/repository/cloud_firestore_api.dart';
import 'package:skype_clone/User/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {
  final authRepository = AuthRepository();
  final CloudFirestoreAPI _cloudFirestoreAPI = CloudFirestoreAPI();

  //Streams
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;
  User get currentUser => FirebaseAuth.instance.currentUser;

//Login in app
  Future<User> signIn() => authRepository.signInFirebase();

//LogOut off app
  signOut() => authRepository.signOut();

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(UserModel user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

//Get contacts
  Future<Iterable<Contact>> getContacts() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      return contacts;
    }
  }

  @override
  void dispose() {}

  Future<void> addMessageToDb(
      Message message, UserModel sender, UserModel receiver) {
    _cloudFirestoreAPI.addMessageToDb(message, sender, receiver);
  }
}
