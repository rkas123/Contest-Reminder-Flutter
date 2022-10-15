import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/contest.dart';

class Contests with ChangeNotifier {
  //List of contests
  //Data fetched from API is modified and stored in '_list'
  List<Contest> _list = [];

  //Boolean to check if we have called API atleast once
  bool fetchedOnce = false;

  //returns a copy of contests
  //Don't return the reference to the contests as changes in listeners can manipulate the provider state
  List<Contest> get list {
    return [..._list];
  }

  //Fetches a list of upcoming contests
  //Should run on page reload and intial render
  Future<void> fetchListandUpdate() async {
    // TODO Add file for global constants and import from there
    final url = Uri.parse('https://codeforces-compar.herokuapp.com/list');
    try {
      final data = await http.get(url);
      final contestsData = json.decode(data.body)['data'].toList();

      List<Contest> updatedList = [];
      contestsData.forEach((ele) {
        updatedList.add(Contest(
          duration: ele['duration'],
          end: DateTime.parse(ele['end']),
          start: DateTime.parse(ele['start']),
          href: ele['href'],
          id: ele['id'],
          iconurl: ele['resource']['icon'],
          event: ele['event'],
        ));
      });

      _list = updatedList;
      notifyListeners();
    } catch (error) {
      // TODO Add error handling
      print(error);
    }
  }

  //Called when switch to UpcomingContest tab and also on the initial render.
  Future<void> tabSwitch() async {
    if (fetchedOnce) {
      return;
    }
    await fetchListandUpdate();
    fetchedOnce = true;
  }

  // Remove a contest from the state's list of contests.
  void delete(int id) {
    _list.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
