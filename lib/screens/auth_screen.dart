import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../widgets/authForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/chat_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = "authScreen";

  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading=false;
  void _submitAuthForm(
      String email, String password, String username, bool isLogin) async {
    final _auth = FirebaseAuth.instance;
    AuthResult authResult;
    try {
      setState(() {
        isLoading=true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({'username': username, 'email': email});
      }
      // Navigator.of(context).pushNamed(ChatScreen.routeName,
      //     arguments: {'email': authResult.user.email});
      setState(() {
        isLoading=false;
      });
    } on PlatformException catch (err) {
      var message = "An error occurred, please check your credentials";
      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm,isLoading),
    );
  }
}
