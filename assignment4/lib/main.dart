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
      initialRoute: '/',
      routes: {
        '/' : (context) => const MyHomePage(),
        '/Measure' : (context) => Measure(),
        '/Milk' : (context) => Milk(),
        '/Result' : (context) => Result(),
        '/Sweet' : (context) => Sweet(),
        '/Juice' : (context) => Juice(),
        '/Again' : (context) => Again()
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Choose Beverage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('I want to help you choose the beverage'),
            const Text('Let\'s start!'),
            ElevatedButton(
              child : const Text('Go'),
              onPressed: (){
                setState(() {
                  Navigator.pushNamed(context, '/Measure');
                });
                },
            )
          ],
        ),
      ),
    );
  }
}

class Measure extends StatefulWidget {
  const Measure({super.key});

  @override
  State<Measure> createState() => _MeasureState();
}

class _MeasureState extends State<Measure> {
  int c = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Measure Your Coffee'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('How many cup of coffee did you drink?'),
              Text('${c} cups'),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('-'),
                    onPressed: (){
                      setState(() {
                        c--;
                      });
                    } ,
                  ),
                  ElevatedButton(
                    child: const Text('+'),
                    onPressed: (){
                      setState(() {
                        c++;
                      });
                    } ,
                  ),
                ],
              ),
              ElevatedButton(
                child: const Text('Next'),
                onPressed: (){
                  if (c<=1){
                    Navigator.pushNamed(context, '/Milk', arguments: c);
                  } else {
                    Navigator.pushNamed(context, '/Juice' ,arguments: c);
                  }
                } ,
              ),
            ],
          ),
          ),
    );
  }
}

class Milk extends StatelessWidget {
  const Milk({super.key});

  @override
  Widget build(BuildContext context) {
    final c = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Milk'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Since you drank ${c} cup of coffee'),
            const Text('You may want to coffee'),
            const Text('Do you want milk in the coffee?'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/Sweet');
                  } ,
                ),
                ElevatedButton(
                  child: const Text('No'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/Result', arguments: 'Americano');
                  } ,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Your best beverage is'),
            Text(res),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: (){
            Navigator.of(context).popUntil((route)=>route.isFirst);
          }
      ),
    );
  }
}

class Sweet extends StatelessWidget {
  const Sweet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sweet Coffee'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Do you want Sweet coffee?'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/Result', arguments: 'Mocha Latte');
                  } ,
                ),
                ElevatedButton(
                  child: const Text('No'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/Result', arguments: 'Caffe Latte');
                  } ,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Juice extends StatelessWidget {
  const Juice({super.key});

  @override
  Widget build(BuildContext context) {
    final c = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Juice or Latte'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Since you drank ${c} cup of coffee'),
            const Text('You may not want coffee'),
            const Text('Do you want juice of latte?'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Juice'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/Result', arguments: 'Grapefruit Juice');
                  } ,
                ),
                ElevatedButton(
                  child: const Text('Latte'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/Again');
                  } ,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Again extends StatelessWidget {
  const Again({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Coffee Again'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Do you want some more coffee?'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/Sweet');
                  } ,
                ),
                ElevatedButton(
                  child: const Text('No'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/Result', arguments: 'Sweet Potato Latte');
                  } ,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
