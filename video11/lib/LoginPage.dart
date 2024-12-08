import 'package:flutter/material.dart';
import 'package:untitled/ChatPage.dart';
import 'package:untitled/RegisterPage.dart';
import 'RegisterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ChatPage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled/RegisterPage.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool saving = false;
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: saving,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        saving = true;
                      });
                      final currentUser =
                      await _authentication.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (currentUser.user != null) {
                        _formKey.currentState!.reset();
                        // if (!mounted) return;
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => ChatPage()));
                      }
                      setState(() {
                        saving = false; // 이 함수가 완료될때까지 true였다가 false로
                      });
                    } catch (e){
                      print(e);
                    }
                  },
                  child: Text('Enter')),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('If you did not register,'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registerpage()));
                      },
                      child: Text('Register your email'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
