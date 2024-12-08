import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Team.dart';

class TeamList extends StatelessWidget {
  const TeamList({super.key});

  @override
  Widget build(BuildContext context) {
    final teamList = context.watch<Teams>().teamList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Team Member List'),
      ),
      body: ReorderableListView(
        children: [
          for (int i = 0; i < teamList.length; i++)
            Dismissible(
              key: ValueKey(teamList[i][0]), // 아이템의 고유한 키 사용
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                context.read<Teams>().removeTeamMemberById(teamList[i][0]);
              },
              child: ListTile(
                title: Text('${teamList[i][1]} (${teamList[i][0].toString()})'),
              ),
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) newIndex -= 1;
          context.read<Teams>().reorderTeamMember(oldIndex, newIndex);
        },
      ),
    );
  }
}
