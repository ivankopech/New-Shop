import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogIn = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _isAuthenticating = false;
  var _enteredUsername = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = false;
      });
      if (_isLogIn) {
        final userCredential = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        //
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed'),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
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
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
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
                          const SizedBox(
                            height: 10,
                          ),
                          if (!_isLogIn)
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Username',
                              ),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Please enter a valid username';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredUsername = value!;
                              },
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Plase enter a valid password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(_isLogIn ? 'Login' : 'Sign up'),
                            ),
                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogIn = !_isLogIn;
                                });
                              },
                              child: Text(_isLogIn
                                  ? 'Create an account'
                                  : 'I already have an account'),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// final _firebase = FirebaseAuth.instance;

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final _form = GlobalKey<FormState>();

//   var _enteredEmail = '';
//   var _enteredPassword = '';
//   var _enteredUserName = '';
//   var _isLogin = true;
//   var _isAuthenticating = false;

//   void _submit() async {
//     final isValid = _form.currentState!.validate();

//     if (!isValid || !_isLogin) {
//       return;
//     }

//     _form.currentState!.save();

//     try {
//       setState(() {
//         _isAuthenticating = false;
//       });
//       if (_isLogin) {
//         final userCredential = await _firebase.signInWithEmailAndPassword(
//           email: _enteredEmail,
//           password: _enteredPassword,
//         );
//       } else {
//         final userCredetials = await _firebase.createUserWithEmailAndPassword(
//           email: _enteredEmail,
//           password: _enteredPassword,
//         );

//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userCredetials.user!.uid)
//             .set({
//           'email': _enteredEmail,
//           'username': _enteredUserName,
//         });

//         print('mail es: ' + _enteredEmail);
//         print('password es: ' + _enteredPassword);
//       }
//     } on FirebaseAuthException catch (error) {
//       if (error.code == 'email-already-in-use') {
//         //
//       }
//       ScaffoldMessenger.of(context).clearSnackBars();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(error.message ?? 'Authentication failed'),
//         ),
//       );
//       setState(() {
//         _isAuthenticating = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.primary,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: EdgeInsets.only(
//                   top: 30,
//                   bottom: 20,
//                   right: 20,
//                   left: 20,
//                 ),
//                 width: 200,
//                 child: Image.asset('assets/images/transporte.png'),
//               ),
//               Card(
//                 margin: const EdgeInsets.all(20),
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(15),
//                   child: Form(
//                     key: _form,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           autocorrect: false,
//                           textCapitalization: TextCapitalization.none,
//                           validator: (value) {
//                             if (value == null ||
//                                 value.trim().isEmpty ||
//                                 !value.contains('@')) {
//                               return 'Plase enter a valid email address';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             _enteredEmail = value!;
//                           },
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         if (!_isLogin)
//                           TextFormField(
//                             decoration: InputDecoration(
//                               labelText: 'Username',
//                             ),
//                             autocorrect: false,
//                             textCapitalization: TextCapitalization.none,
//                             validator: (value) {
//                               if (value == null ||
//                                   value.trim().isEmpty ||
//                                   value.length < 4) {
//                                 return 'Plase enter a valid username';
//                               }
//                               return null;
//                             },
//                             onSaved: (value) {
//                               _enteredUserName = value!;
//                             },
//                           ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                           ),
//                           obscureText: true,
//                           autocorrect: false,
//                           textCapitalization: TextCapitalization.none,
//                           validator: (value) {
//                             if (value == null ||
//                                 value.trim().isEmpty ||
//                                 value.length < 5) {
//                               return 'Plase enter a valid password';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             _enteredPassword = value!;
//                           },
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         if (_isAuthenticating)
//                           const CircularProgressIndicator(),
//                         if (!_isAuthenticating)
//                           ElevatedButton(
//                             onPressed: _submit,
//                             style: ElevatedButton.styleFrom(
//                               primary: Theme.of(context)
//                                   .colorScheme
//                                   .primaryContainer,
//                             ),
//                             child: Text(_isLogin ? 'Log In' : 'Sign Up'),
//                           ),
//                         if (!_isAuthenticating)
//                           TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 _isLogin = !_isLogin;
//                               });
//                             },
//                             child: Text(_isLogin
//                                 ? 'Create an account'
//                                 : 'Already have an account'),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
