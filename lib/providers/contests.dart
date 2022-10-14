import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/contest.dart';

class Contests with ChangeNotifier {
  //List of contests
  //Data fetched from API is modified and stored in '_list'
  List<Contest> _list = [];

  //returns a copy of contests
  //Don't return the reference to the contests as changes in listeners can manipulate the provider state
  List<Contest> get list {
    return [..._list];
  }

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
          end: ele['end'],
          start: ele['start'],
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
}
