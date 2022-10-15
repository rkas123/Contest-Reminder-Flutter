import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/contests.dart';

import '../widgets/upcoming_contest.dart';
import '../widgets/loader.dart';

//SCREEN INFO
//This screen renders the list of Upcoming Contests
//Before rendering, we make an API call and after receiving data, we render it.
class UpcomingContests extends StatefulWidget {
  static const routeName = 'upcoming-contest';
  const UpcomingContests({Key? key}) : super(key: key);

  @override
  State<UpcomingContests> createState() => _UpcomingContestsState();
}

class _UpcomingContestsState extends State<UpcomingContests> {
  //Initial loader will be used to fetch data when the widget becomes a part of widget tree
  var _initalLoadingCompleted = false;

  Future<void> _refreshContest(BuildContext context) async {
    return Provider.of<Contests>(
      context,
      listen: false,
    ).fetchListandUpdate();
  }

  @override
  void didChangeDependencies() {
    //check whether inital loading has happended or not
    //This check is needed because, didChangeDependencies runs multiple times

    //NOTE: We can't use async await here, because didChangeDependencies is an inbuilt function
    //Can not convert it to an async function
    //Forced to used .then() and .catch(error)
    if (!_initalLoadingCompleted) {
      Provider.of<Contests>(
        context,
        listen: false,
      ).tabSwitch().then((_) {
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
      // appBar: AppBar(
      //   title: const Text('Upcoming Contest'),
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),

      //render custom loader while inital loading
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
