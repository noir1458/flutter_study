import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Teams with ChangeNotifier {
  List<List<dynamic>> teamList = [];

  addTeamList(int num, String Name) {
    if (teamList.length >= 3) {
      return;
    }
    teamList.add([num,Name]);
    notifyListeners();
  }

  reorderTeamMember(oldIndex,newIndex) {
    if (oldIndex<newIndex) {
      newIndex -= 1;
    }
    teamList.insert(newIndex, teamList.removeAt(oldIndex));
    notifyListeners();
  }

  removeTeamMember(int i){
    teamList.removeAt(i);
    notifyListeners();
  }

  void removeTeamMemberById(dynamic id) {
    teamList.removeWhere((item) => item[0] == id);
    notifyListeners();
  }
}