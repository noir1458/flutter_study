import 'package:flutter/material.dart';
import 'package:untitled/editpage.dart';
import 'package:provider/provider.dart';
import 'score.dart';

class Scorepage extends StatelessWidget {
  const Scorepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scores'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ScorePanel(),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Editpage()));
          }, child: const Text('Edit'))
        ],
      ),
    );
  }
}

class ScorePanel extends StatelessWidget {
  const ScorePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Mid-Term', style: TextStyle(fontSize: 20),),
            SizedBox(
              height: 20,
            ),
            Text(context.watch<Scores>().midTermExam.toString(), style: TextStyle(fontSize: 20),),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Final', style: TextStyle(fontSize: 20),),
            SizedBox(
              height: 20,
            ),
            Text(context.watch<Scores>().finalExam.toString(), style: TextStyle(fontSize: 20),),
          ],
        ),
      ],
    );
  }
}
