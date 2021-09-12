import 'package:flutter/material.dart';
import '../screens/chat_screen.dart';

class AuthForm extends StatefulWidget {
  bool isLoading;
  final void Function(String email, String pass, String username, bool isLogin)
      submitFn;

  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final _isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (_isValid != null) {
      _formKey.currentState?.save();
      //send auth request
      widget.submitFn(_userEmail.trim(), _userPassword, _userName, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email address",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return "This field can't be blank";
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    decoration: InputDecoration(labelText: "Username"),
                    validator: (value) {
                      if (value!.isEmpty) return "This field can't be blank";
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value!;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (value) {
                    if (value!.isEmpty) return "This field can't be blank";
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                (widget.isLoading)
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? "Login" : "Signup")),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? "Create new account"
                        : "I already have an account")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
