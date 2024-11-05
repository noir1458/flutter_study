import 'package:flutter/material.dart';
enum Select1 {Project_Team_Leader, Project_Team_Member}

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
      home: const MyHomePage(title: 'Grade Calculator'),
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
  final _midtermController = TextEditingController();
  final _finaltermController = TextEditingController();
  bool _isAbsence= false;
  Select1 _select1 = Select1.Project_Team_Leader;
  final _pointList = List.generate(10, (i)=> '$i Point');
  var _selectedPoint = '0 Point';
  var _grade = 'A';

  void dispose() {
    _midtermController.dispose();
    _finaltermController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mid-term exam'
                ),
                controller: _midtermController,
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Final exam'
                ),
                controller: _finaltermController,
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 20,
              ),
              RadioListTile(
                title: Text('Project Team Leader (+10)'),
                value: Select1.Project_Team_Leader,
                groupValue: _select1,
                onChanged: (value){
                  setState(() {
                    _select1 = value!;
                  });
                },
              ),

              RadioListTile(
                title: Text('Project Team Member'),
                value: Select1.Project_Team_Member,
                groupValue: _select1,
                onChanged: (value){
                  setState(() {
                    _select1 = value!;
                  });
                },
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Additional Point', style: TextStyle(fontSize: 18),),
                  Container(
                    width: 100,
                  ),
                  DropdownButton(
                    value: _selectedPoint,
                    items: _pointList.map(
                        (point) => DropdownMenuItem(
                          value: point,
                          child: Text(point))).toList(),
                    onChanged: (value){
                    setState(() {
                    _selectedPoint = value!;
                    });}
                  
                    ),
                ],
              ),

              CheckboxListTile(
                title: Text('Absence less than 4'),
                value: _isAbsence,
                onChanged: (bool? value){
                  setState(() {
                    _isAbsence = value!;
                  });
                },
              ),
              Container(
                height: 20,
              ),
              Text(_grade, style: TextStyle(fontSize: 50, color: Colors.red),),
              Container(
                height: 20,
              ),
              ElevatedButton(onPressed: (){
                var res;
                if (_isAbsence==false) {
                  res = 'F';
                }
                else{
                  var midterm = int.parse(_midtermController.text);
                  var finalterm = int.parse(_finaltermController.text);
                  var addpoint = int.parse(_selectedPoint[0]);
                  var totalpoint = midterm + finalterm + addpoint;

                  if (_select1 == Select1.Project_Team_Leader) {
                    totalpoint += 10;
                  }

                  if (totalpoint >= 170) {
                    res = 'A';
                  } else if (150 <= totalpoint && totalpoint < 170) {
                    res = 'B';
                  } else if (130 <= totalpoint && totalpoint < 150) {
                    res = 'C';
                  } else if (110 <= totalpoint && totalpoint < 130) {
                    res = 'D';
                  } else {
                    res = 'F';
                  }

                }

                setState(() {
                  _grade = res;
                });
              }, 
                  child: Text('Enter'))
              

            ],
          ),
        ),
      ),
    );
  }
}
