import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUserName = '';
  var _isLogin = true;
  var _isAuthenticating = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 30,
                bottom: 20,
                right: 20,
                left: 20,
              ),
              width: 200,
              child: Image.asset('assets/images/transporte.png'),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'Plase enter a valid email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredEmail = value!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (!_isLogin)
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                          ),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.length < 4) {
                              return 'Plase enter a valid username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredUserName = value!;
                          },
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.length < 5) {
                            return 'Plase enter a valid password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredPassword = value!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (_isAuthenticating) const CircularProgressIndicator(),
                      if (!_isAuthenticating)
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: Text(_isLogin ? 'Log In' : 'Sign Up'),
                        ),
                      if (!_isAuthenticating)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Create an account'
                              : 'Already have an account'),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
