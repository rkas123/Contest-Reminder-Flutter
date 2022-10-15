import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/contest.dart';

import '../helper/date_helper.dart';

import '../widgets/dialog.dart' as helperDialog;

import '../providers/contests.dart';
import '../providers/notifs.dart';

class UpcomingContestItem extends StatefulWidget {
  final Contest contest;
  const UpcomingContestItem({required this.contest, Key? key})
      : super(key: key);

  @override
  State<UpcomingContestItem> createState() => _UpcomingContestItemState();
}

class _UpcomingContestItemState extends State<UpcomingContestItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        switch (direction) {
          case DismissDirection.endToStart:
            {
              Provider.of<NotifContest>(context, listen: false)
                  .addContest(widget.contest);
              Provider.of<Contests>(context, listen: false)
                  .delete(widget.contest.id);
              Fluttertoast.showToast(msg: 'Added');

              break;
            }
          case DismissDirection.startToEnd:
            {
              Provider.of<Contests>(context, listen: false)
                  .delete(widget.contest.id);
              Fluttertoast.showToast(msg: 'Deleted');
              break;
            }
          default:
            {
              // do nothing
            }
        }
      },
      confirmDismiss: (direction) {
        switch (direction) {
          case DismissDirection.endToStart:
            {
              return showDialog(
                context: context,
                builder: (ctx) => helperDialog.Dialog(
                  title: 'Confirming...',
                  content:
                      'You will receive a notification for this contest on ${widget.contest.start}',
                ),
              );
            }
          case DismissDirection.startToEnd:
            {
              return showDialog(
                context: context,
                builder: (ctx) => const helperDialog.Dialog(
                  title: 'Confirm Delete',
                  content: 'Are you sure you want to delete this contest?',
                ),
              );
            }
          default:
            {
              return Future.value(true);
            }
        }
      },
      key: ValueKey(widget.contest.id),
      background: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Swipe to Delete',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 18,
            ),
          ),
          Text(
            'Swipe to get Notified',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 2,
        ),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Text(
                  widget.contest.event,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 2,
                ),
                Column(
                  children: [
                    Text(
                      DateHelper.getDayString(widget.contest.start),
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Start Time',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Text(
                          DateHelper.getTimeString(widget.contest.start),
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('End Time',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).accentColor,
                            )),
                        Text(DateHelper.getTimeString(widget.contest.end),
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).accentColor,
                            )),
                      ],
                    ),
                    FlatButton(
                      onPressed: () async {
                        final url = widget.contest.href;

                        if (await canLaunchUrlString(url)) {
                          await launchUrlString(url);
                        }
                      },
                      child: const Text(
                        'Link',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
