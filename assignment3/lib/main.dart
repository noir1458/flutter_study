import 'package:flutter/material.dart';
List<String> tmpList = [];

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
      home: const MyHomePage(title: 'Grade Calculator'),
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

  // 리스트에 항목을 추가하는 함수
  void addItemToList(String item) {
    setState(() {
      tmpList.add(item); // tmpList에 항목을 추가하고 상태를 갱신
    });
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          bottom: TabBar(
              tabs: [
                Tab(text: 'information', height: 50),
                Tab(text: 'List', height: 50)
              ]
          ),
        ),
        body: TabBarView(
          children: [
            MyForm(),
            ReorderableListView.builder(
              itemCount: tmpList.length,
              itemBuilder: (c,i){
                return Dismissible(
                  background: Container(color: Colors.red,),
                  key: ValueKey(tmpList[i]),
                  direction: DismissDirection.endToStart,
                  child: ListTile(
                    title: Text(tmpList[i]),
                    leading: Icon(Icons.home),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      tmpList.removeAt(i);
                    });
                    print(tmpList);
                  },
                );
              },
              onReorder: (int oldIndex,int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  tmpList.insert(newIndex,tmpList.removeAt(oldIndex));
                  print(tmpList);
                });
              },
            ),
          ],
        )
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  StudentResult studentResult = StudentResult('name', 0, 0);
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formkey,
        child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'name'
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some String, not a number';
                  } else if (RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Please enter some String, not a number';
                  }
                  return null;
                },
                onSaved: (value) {
                  studentResult.name = (value!);
                },
              ),
              Container(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Project Point'
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some Integer';
                  } else if (int.tryParse(value)==null){
                    return 'Please enter some Integer';
                  }
                  return null;
                },
                onSaved: (value) {
                  studentResult.ProjectPoint = int.parse(value!);
                },
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'AdditionalPoint'
                ),
                value: studentResult.additionalPoint,
                items: List.generate((11), (i) {
                  if (i==0) {
                    return DropdownMenuItem(
                      value: 0,
                      child: Text('Choose the additional Point'),
                    );
                  }
                  return DropdownMenuItem(
                    value: i,
                    child: Text('${i} point'),
                  );
                }),
                validator: (value) {
                  if (value == 0) {
                    return 'Please select the point';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    studentResult.additionalPoint = value!;
                  });
                },
              ),
              SizedBox(
                height: 80,
              ),
              GestureDetector(
                child: Container(
                  height: 50,
                  child: Center(child: Text('Enter')),
                  color: Colors.blue,
                ),
                onTap: (){
                  setState(() {
                    if (_formkey.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('process')
                      ));
                      _formkey.currentState!.save();
                      print(studentResult);
                      String tmpadd = '${studentResult.name} : ${studentResult.ProjectPoint + studentResult.additionalPoint}';
                      tmpList.add(tmpadd);
                      print(tmpList);
                    }
                  });

                },
              )
            ],
          ),
      ),
    );
  }
}

class StudentResult {
  String name;
  int ProjectPoint;
  int additionalPoint;

  StudentResult(
      this.name,this.ProjectPoint,this.additionalPoint
      );

  @override
  String toString(){
    return '('
        '$name, '
        '$ProjectPoint, '
        '$additionalPoint)';
  }
}