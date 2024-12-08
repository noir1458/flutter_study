import 'package:flutter/material.dart';

class SuccessRegisterPage extends StatefulWidget {
  const SuccessRegisterPage({super.key});

  @override
  State<SuccessRegisterPage> createState() => _SuccessRegisterPageState();
}

class _SuccessRegisterPageState extends State<SuccessRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have successfully registered', style: TextStyle(fontSize: 20),),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Login')
            )
          ],
        ),
      ),
    );
  }
}
