import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:skype_clone/User/model/user.dart';
import 'package:skype_clone/User/repository/auth_repository.dart';
import 'package:skype_clone/User/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {
  AuthRepository authRepository;

  //Streams
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges.call;
  Stream<User> get authStatus => streamFirebase;
  User get currentUser => FirebaseAuth.instance.currentUser;

//Login in app
  Future<User> signIn() => authRepository.signInWithGoogle();

//LogOut off app
  signOut() => authRepository.signOutWithGoogle();

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(UserModel user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  @override
  void dispose() {}
}
