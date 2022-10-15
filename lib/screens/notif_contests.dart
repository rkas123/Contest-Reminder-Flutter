import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notifs.dart';

import '../widgets/notif_contest.dart';

class NotifContestScreen extends StatelessWidget {
  static const routeName = '/notif-contests';
  const NotifContestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifContests = Provider.of<NotifContest>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_rounded,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => NotifContestItem(
          contest: notifContests.list[index],
        ),
        itemCount: notifContests.list.length,
      ),
    );
  }
}
