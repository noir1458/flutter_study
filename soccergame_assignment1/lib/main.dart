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
      title: 'Soccer Game',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Soccer Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter_your = 0;
  int _counter_rival = 0;
  int win = 0;
  int draw = 0;
  int lose = 0;

  void _resetgame() { // 내 골
    setState(() {
       _counter_your = 0;
       _counter_rival = 0;
    });
  }

  void _incrementCounter_your() { // 내 골
    setState(() {
      _counter_your++;
    });
  }

  void _incrementCounter_rival() { // 상대 골
    setState(() {
      _counter_rival++;
    });
  }

  void __setscore() {
    setState(() {
      if (_counter_your > _counter_rival){
        win ++;
      }
      else if (_counter_your < _counter_rival){
        lose ++;
      }
      else{
        draw ++;
      }
      _counter_your = 0;
      _counter_rival = 0;
    });
  }

  void __refresh() {
    setState(() {
      _counter_your = 0;
      _counter_rival = 0;
      win = 0;
      draw = 0;
      lose = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Image(
            image: AssetImage('assets/ball.png'),
            width: 100,
          ),


          TextButton(onPressed: _resetgame, child: Text('Reset game'),),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your Team  ',style: TextStyle(fontSize: 20),),
              Text('Your Rival',style: TextStyle(fontSize: 20),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$_counter_your',style: TextStyle(fontSize: 20),),
              Text(':',style: TextStyle(fontSize: 20),),
              Text('$_counter_rival',style: TextStyle(fontSize: 20),),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: _incrementCounter_your, child: Text('Goal')),
              TextButton(onPressed: _incrementCounter_rival, child: Text('Goal')),
            ],
          ),

          TextButton(onPressed: __setscore, child: Text('Game Over')),

          Text('Set score',style: TextStyle(fontSize: 20),),
          Text('win : $win draw : $draw lose : $lose',style: TextStyle(fontSize: 20),),


        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: __refresh,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
