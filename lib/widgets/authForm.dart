import 'package:flutter/material.dart';
import '../screens/chat_screen.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email address",
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Username"),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(

                    onPressed: () {
                      Navigator.of(context).pushNamed(ChatScreen.routeName);
                    },
                    child: Text("Login")),
                TextButton(onPressed: () {}, child: Text("Create new account")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
