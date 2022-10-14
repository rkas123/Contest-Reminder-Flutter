import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/contests.dart';

class UpcomingContests extends StatelessWidget {
  static const routeName = 'upcoming-contest';
  const UpcomingContests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Upcoming Contest'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Consumer<Contests>(
          builder: (ctx, contests, _) => FlatButton(
            onPressed: contests.fetchListandUpdate,
            child: const Text(
              'Fetch Data',
            ),
          ),
        ),
      ),
    );
  }
}
