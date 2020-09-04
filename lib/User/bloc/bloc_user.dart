import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:skype_clone/User/model/user.dart';
import 'package:skype_clone/User/repository/auth_repository.dart';

class UserBloc implements Bloc {
  AuthRepository authRepository;

  //Streams
  Stream<FirebaseUser> streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;
  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();

//Login in app
  Future<FirebaseUser> signIn() => authRepository.signInWithGoogle();

  @override
  void dispose() {}
}
