//This file defines the schema of a contest.
//All the fields that will be rendered are part of it
//ID-field will not be rendered but is necessary for unique identifation
//Data returned from API has some extra fields too

class Contest {
  final int duration;
  final String end;
  final String start;
  final String href;
  final String iconurl;
  final int id;
  final String event;

  Contest({
    required this.duration,
    required this.end,
    required this.start,
    required this.href,
    required this.iconurl,
    required this.id,
    required this.event,
  });
}
