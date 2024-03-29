import 'package:croptivate_app/screens/authentication/register_seller.dart';
import 'package:croptivate_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:croptivate_app/models/user.dart';

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


  //Sign In with Email and Password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  //Register with Email and Password - Seller
  Future registerSeller(String email, String password) async {
    
    //, Map<String, dynamic> sellerInfo
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user!);
      //Create a new document for sellers with the uid
      // await DatabaseService(uid: user!.uid).addUserSeller(sellerInfo);
      // 
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Register with Email and Password - Buyer
  Future registerBuyer(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //Create a new document for buyer with the uid
      // await DatabaseService(uid: user!.uid).addUserBuyer(buyerInfo);
      return _userFromFirebase(user!);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Register with Email and Password - Transporter
  Future registerTransporter(String email, String password, Map<String, dynamic> transporterInfo) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

       //Create a new document for transporter with the uid
      await DatabaseService(uid: user!.uid).addUserTransporter(transporterInfo);
      return _userFromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

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

