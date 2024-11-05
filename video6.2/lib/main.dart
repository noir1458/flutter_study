import 'dart:math';
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
  List items = List.generate(20, (i) => i);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ReorderableListView.builder(
        // 모든 ReorderableListView는 키를 가지고 있어야 한다. 위치와 관련되어 있기에 민감한 이슈
        itemCount: items.length,
        itemBuilder: (c,i) { // context, iteration num
          return Dismissible( // 제거할수 있도록
            background: Container(color: Colors.green,),
            key: ValueKey(items[i]),
            direction: DismissDirection.endToStart,
            child: ListTile(
              title: Text('Student ${items[i]}'),
              leading: Icon(Icons.home),
              trailing: Icon(Icons.navigate_next),
            ),
            onDismissed: (direction) { // 왼쪽으로 밀때 제거가 된다.
              setState(() {
                items.removeAt(i);
                print(items);
              });
            },
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex<newIndex){
              newIndex -= 1;
            }
            items.insert(newIndex, items.removeAt(oldIndex));
            print(items);
          });
        },
      ),
    );
  }
}

