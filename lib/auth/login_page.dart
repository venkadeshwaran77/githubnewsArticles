import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_articles/auth/signup_page.dart';
import 'package:news_articles/custom_scaffold.dart';
import 'package:news_articles/thems/colors_theme.dart';
import 'package:news_articles/widgets/snakbar.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late String email;
  late String password;

  bool processing = false;
  final GlobalKey<FormState> _formSignInKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool rememberPassword = true;
  bool passwordVisible = false;

  void LogIn() async {
    setState(() {
      processing = true;
    });
    if (_formSignInKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        _formSignInKey.currentState!.reset();
        Navigator.pushReplacementNamed(context, "home_screen");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
            _scaffoldKey,
            'No user found for that email.',
          );
        } else if (e.code == 'wrong-password') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
            _scaffoldKey,
            'Wrong password provided for that user.',
          );
        }
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessageHandler.showSnackBar(_scaffoldKey, 'please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key:_scaffoldKey,
      child: CustomScaffold(
        child: Column(
          children: [
            Expanded(flex: 1, child: SizedBox(height: 10)),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formSignInKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome back',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: lightColorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            } else if (EmailValidator(value).isValidEmail() == false) {
                              return 'invalid email';
                            } else if (EmailValidator(value).isValidEmail() == true) {
                              return null;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                           label: Text('Email'),
                            hintText: "Enter Email",
                            hintStyle: TextStyle(color: Colors.black26),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        TextFormField(
                          obscureText: true,
                          obscuringCharacter: "*",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: InputDecoration(
                            label: Text('Password'),
                            hintText: "Enter Password",
                            hintStyle: TextStyle(color: Colors.black26),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberPassword,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      rememberPassword = value!;
                                    });
                                  },
                                  activeColor: lightColorScheme.primary,
                                ),
                                Text(
                                  'Remember me',
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: Text(
                                "Forget password?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightColorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              LogIn();
                              if (_formSignInKey.currentState!.validate() &&
                                rememberPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(
                                    child: Text('Processing Data'),
                                  ),
                                ),
                              );
                            }else if (!rememberPassword) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please agree to the Processing of personal',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text("Log In"),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.7,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 10,
                              ),
                              child: Text(
                                'Sign up with',
                                style: TextStyle(color: Colors.black45),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.7,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            googleScreen(
                              child: Image(
                                image: AssetImage('assets/img/fb.png'),
                              ),
                              onPressed: () {},
                              height: 30,
                              width: 30,
                            ),
                            googleScreen(
                              child: Image(
                                image: AssetImage('assets/img/x1.png'),
                              ),
                              onPressed: () {},
                              height: 45,
                              width: 45,
                            ),
                            googleScreen(
                              child: Image(
                                image: AssetImage('assets/img/google.png'),
                              ),
                              onPressed: () {},
                              height: 40,
                              width: 40,
                            ),
                            googleScreen(
                              child: Image(
                                image: AssetImage('assets/img/apple1.png'),
                              ),
                              onPressed: () {},
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(color: Colors.black45),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  'signup_screen',
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightColorScheme.primary,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
      r'^([a-zA-Z0-9])+([\-\_\.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$',
    ).hasMatch(this);
  }
}
