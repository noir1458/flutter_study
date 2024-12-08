import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Team.dart';
import 'package:untitled/TeamList.dart';

class AddTeam extends StatelessWidget {
  const AddTeam({super.key});

  void _showErrorBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ErrorBottomSheet(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Team Member'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TeamList()),
              );
            },
            icon: Icon(Icons.list),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('The number of our team members is:'),
            Text(context.watch<Teams>().teamList.length.toString()),
            ElevatedButton(
              onPressed: () {
                final teams = context.read<Teams>();
                if (teams.teamList.length >= 3) {
                  _showErrorBottomSheet(context);
                  return;
                }

                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return AddBottomSheet(teams: teams);
                  },
                );
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddBottomSheet extends StatefulWidget {
  final Teams teams;

  const AddBottomSheet({super.key, required this.teams});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  final _studentNoController = TextEditingController();
  final _studentNameController = TextEditingController();

  @override
  void dispose() {
    _studentNameController.dispose();
    _studentNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 8),
              Text('Student No:'),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _studentNoController,
                  decoration: InputDecoration(isDense: true),
                ),
              ),
              Text('Name:'),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _studentNameController,
                  decoration: InputDecoration(isDense: true),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final studentNo = int.tryParse(_studentNoController.text.trim());
              final studentName = _studentNameController.text.trim();

              if (studentNo == null || studentName.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter valid details')),
                );
                return;
              }

              widget.teams.addTeamList(studentNo, studentName);
              Navigator.pop(context);
            },
            child: Text('Enter'),
          ),
        ],
      ),
    );
  }
}

class ErrorBottomSheet extends StatelessWidget {
  const ErrorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The team is already full',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
