import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app/models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
      if(user != null){
        return User(uid: user.uid);
      }else{
        return null;
      }
  }


  Stream<User> get user => _auth.onAuthStateChanged.map(_userFromFirebaseUser);

  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try{
      return _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}
