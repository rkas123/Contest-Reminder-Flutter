import 'package:flutter/material.dart';

import '../models/contest.dart';

import '../helper/date_helper.dart';

class NotifContestItem extends StatefulWidget {
  final Contest contest;
  const NotifContestItem({
    required this.contest,
    Key? key,
  }) : super(key: key);

  @override
  State<NotifContestItem> createState() => _NotifContestItemState();
}

class _NotifContestItemState extends State<NotifContestItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.contest.event,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: (!_expanded)
                  ? const Icon(Icons.expand_more)
                  : const Icon(Icons.expand_less),
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Column(
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
                ],
              ),
            ),
        ],
      ),
    );
  }
}
