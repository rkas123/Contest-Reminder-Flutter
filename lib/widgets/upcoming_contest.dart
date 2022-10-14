import 'package:flutter/material.dart';

import '../models/contest.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 2,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Text(
                widget.contest.event,
                textAlign: TextAlign.center,
              ),
              const Divider(),
              Text('${widget.contest.start} to ${widget.contest.end}'),
            ],
          ),
        ),
      ),
    );
  }
}
