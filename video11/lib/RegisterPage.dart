import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/SuccessRegister.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Registerpage extends StatelessWidget {
  const Registerpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool saving = false;
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String userName = '';
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
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'User Name '),
                onChanged: (value) {
                  userName = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        saving = true;
                      });
                      final newUser =
                      await _authentication.createUserWithEmailAndPassword(
                          email: email, password: password);
                      FirebaseFirestore.instance.collection('user').doc(newUser.user!.uid).set({
                        'userName' : userName,
                        'email' : email,

                      });
                      if (newUser.user != null) {
                        _formKey.currentState!.reset();
                        // 위젯이 트리에 마운트가 되지 않으면 에러가 될수 있다 - async를 썼으므로
                        // 아직 트리에 마운트가 되지 않을수가 있겠구나 하는거...
                        // 마운트가 되지 않았으면 하기전에 리턴하라, 마운트 되었으면 무시하라
                        if (!mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (
                                    context) => const SuccessRegisterPage()));
                      }
                      setState(() {
                        saving = false;
                      });
                    } catch (e) { // 예외처리
                      print(e);
                    }
                  },
                  child: const Text('Enter')),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('If you already registered,'),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('log in with your email'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
