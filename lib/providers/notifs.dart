import 'package:flutter/foundation.dart';

import '../models/contest.dart';

class NotifContest with ChangeNotifier {
  //Stores the list of <Contest> user wants to be notified for.
  List<Contest> _list = [];

  //Getter for list of <Contest>
  //Returns a copy, preventing modification by listeners.
  List<Contest> get list {
    return [..._list];
  }

  //Add a <Contest> to he list <Contest> user wants to be notified for.
  void addContest(Contest contest) {
    //We want them most recently added contest on the top
    //TODO Sort by starting time in ascending order.
    _list.insert(0, contest);
    notifyListeners();
  }

  //Deletes a <Contest> from id, from the list of <Contest>
  void delete(int id) {
    _list.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  //Delete a <Contest> from index
  void deleteFromIndex(int index) {
    _list.removeAt(index);
    notifyListeners();
  }

  //Clear the list of <Contest> user wants to be notified for.
  void clearList() {
    _list.clear();
    notifyListeners();
  }
}
