import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers/notifs.dart';

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
      color: Theme.of(context).canvasColor,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                widget.contest.event,
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).accentColor,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: (!_expanded)
                    ? Icon(
                        Icons.expand_more,
                        color: Theme.of(context).accentColor,
                      )
                    : Icon(
                        Icons.expand_less,
                        color: Theme.of(context).accentColor,
                      ),
              ),
            ),
            if (_expanded)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Divider(
                      thickness: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Start Time   ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(
                                    DateHelper.getTimeString(
                                        widget.contest.start),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('End Time   ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).accentColor,
                                      )),
                                  Text(
                                      DateHelper.getTimeString(
                                          widget.contest.end),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).accentColor,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Provider.of<NotifContest>(context, listen: false)
                                .delete(widget.contest.id);
                            Fluttertoast.showToast(msg: 'Removed');
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 40,
                            color: Color.fromARGB(255, 238, 114, 105),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
