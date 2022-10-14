import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/contests.dart';

import '../widgets/upcoming_contest.dart';
import '../widgets/loader.dart';

class UpcomingContests extends StatefulWidget {
  static const routeName = 'upcoming-contest';
  const UpcomingContests({Key? key}) : super(key: key);

  @override
  State<UpcomingContests> createState() => _UpcomingContestsState();
}

class _UpcomingContestsState extends State<UpcomingContests> {
  var _initalLoadingCompleted = false;

  Future<void> _refreshContest(BuildContext context) async {
    return Provider.of<Contests>(
      context,
      listen: false,
    ).fetchListandUpdate();
  }

  @override
  void didChangeDependencies() {
    if (!_initalLoadingCompleted) {
      Provider.of<Contests>(
        context,
        listen: false,
      ).fetchListandUpdate().then((_) {
        print('done fetching');
        setState(() {
          _initalLoadingCompleted = true;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Upcoming Contest'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: (!_initalLoadingCompleted)
          ? const CustomLoader(text: 'Fetching data...')
          : Consumer<Contests>(
              builder: (ctx, contests, _) => RefreshIndicator(
                onRefresh: () => _refreshContest(ctx),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemBuilder: (ctx, index) =>
                        UpcomingContestItem(contest: contests.list[index]),
                    itemCount: contests.list.length,
                  ),
                ),
              ),
            ),
    );
  }
}
