import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//SCREEN INFO
//This is the initial page of the application
//This will be rendered before the Tabs Screen

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //Text Controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //Focus Nodes
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  //Form key
  final _formKey = GlobalKey<FormState>();

  //Login Mode
  //No TextFormField for entering a username
  //Username is only required when signing up for the first time
  bool _loginMode = true;

  //Function executed when form is submitted
  void _saveForm() {
    //Confirming we are getting data
    final data = FirebaseFirestore.instance.collection('temporary');

    data.doc('temp').get().then((value) {
      print(value.data());
    }).catchError((error) {
      print(error.toString());
    });

    //Validation
    //Each TextFormField will execute it's Validator
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  @override
  void dispose() {
    super.dispose();
    //Dispose all the controllers and Focus Nodes to prevent memory leaks
    _usernameController.dispose();
    _usernameFocusNode.dispose();
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Card(
          color: Theme.of(context).canvasColor,
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Username
                  if (!_loginMode)
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 5) {
                          return 'Username must be atleast 4 characters.';
                        }
                        return null;
                      },
                      focusNode: _usernameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          'Username',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                  //Email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!value!.contains('@')) {
                        return 'Invalid email.';
                      }
                      return null;
                    },
                    focusNode: _emailFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        'Email',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  //password
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 7) {
                        return 'Password must be atleast 6 characters.';
                      }
                      return null;
                    },
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      fillColor: Theme.of(context).accentColor,
                      label: Text(
                        'Password',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: Theme.of(context).accentColor,
                    ),
                    onPressed: _saveForm,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 4,
                      ),
                      child: Text(
                        (!_loginMode) ? 'Sign Up' : 'Login',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        _loginMode = !_loginMode;
                      });
                    },
                    child: Text(
                      (!_loginMode) ? 'Log in instead' : 'Sign Up instead',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
