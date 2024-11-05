import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = '';
  double squareside = 100;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gesture 사용하기
            GestureDetector(
              child: AnimatedContainer( // 애니메이션이 가능한 Container로 바뀐다
                width: squareside,
                height: squareside,
                color: Colors.orange,
                duration: Duration(seconds: 1),
              ),
              onTap:(){
                setState(() {
                  if (text == '') {
                    text = 'This is an orange square,';
                  } else {
                    text = '';
                  }
                });
              },
              onLongPress: (){
                setState(() {
                  if (squareside > 75) {
                    squareside = 50;
                    text = 'This is an small orange square,';
                  } else {
                    squareside = 100;
                    text = 'This is an normal orange square,';
                  }
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(text,style: TextStyle(
              fontSize: 20
            ),)
          ],
        ),
      ),
    );
  }
}
