import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/contests.dart';
import '../providers/auth_uid.dart';

import '../widgets/upcoming_contest.dart';
import '../widgets/loader.dart';
import '../widgets/dialog.dart' as dialog;

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

  //Boolean to track username is fetched or not
  var _getUsername = false;

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

    //Fetch the username from Firestore database
    if (!_getUsername) {
      final authListner = Provider.of<AuthUID>(context, listen: false);

      //Already fetched before rendering this widget
      if (authListner.fetchedOnce) {
        setState(() {
          _getUsername = true;
        });
        return;
      }

      //Uid will be set as TabScreen is rendered only when authentication has happended
      //REVERTED! instead of using the AuthUID provider, extract uid from FirebaseAuth instance
      final userCreds = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('users')
          .doc(userCreds!.uid)
          .get()
          .then((value) {
        final dat = value.data() as Map<String, dynamic>;
        authListner.setUsername(dat['username']);
        authListner.setFetchedOnce(true);
        setState(() {
          _getUsername = true;
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
        backgroundColor: Theme.of(context).canvasColor,
        //Display the username in the appbar
        title: Consumer<AuthUID>(
          builder: (ctx, authState, _) => (authState.fetchedOnce)
              ? Text('Welcome ${authState.username}')
              : const Text('Finding your name...'),
        ),
        actions: [
          DropdownButton(
              underline: Container(),
              icon: Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  top: 8,
                ),
                child: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).accentColor,
                ),
              ),
              items: [
                //Logout button
                //The change of page is managed by StreamBuilder in main.dart
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  showDialog(
                    context: context,
                    builder: (context) => const dialog.Dialog(
                        title: 'Logging Out!',
                        content: 'Are you sure you want to logout?'),
                  ).then((res) {
                    //Show a dialog
                    //Confirm user's intentions and then sign out
                    if (res) {
                      FirebaseAuth.instance.signOut();
                      final authListener =
                          Provider.of<AuthUID>(context, listen: false);
                      //Reflect appropriate changes in AuthUID Provider state
                      authListener.setFetchedOnce(false);
                      authListener.setUid('');
                      authListener.setUsername('');
                    }
                  });
                }
              })
        ],
      ),

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
