import 'package:firebase_auth/firebase_auth.dart';
import 'package:croptivate_app/models/user_data.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on FirebaseUser
  MyUser? _userFromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
      .map((User? user) => user != null ? _userFromFirebase(user) : null);
  }

  //Sign In Anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign In with Email and Password

  //Register with Email and Password - Seller

  //Register with Email and Password - Buyer

  //Register with Email and Password - Transporter

  //Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}

