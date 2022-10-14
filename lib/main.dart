import 'package:contest_app/screens/upcoming_contests.dart';
import 'package:flutter/material.dart';
import './helper/hex_color.dart' as hexcolor;

void main() => runApp(MyApp());

//COLOR Palettes
//B7C4CF,EEE3CB,D7C0AE,967E76
//222831, 393E46, 00ADB5, EEEEEE
//112D4E, 3F72AF, DBE2EF, F9F7F7  --> currently using
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: hexcolor.HexColor('3F72AF'),
        backgroundColor: hexcolor.HexColor('DBE2EF'),
      ),
      routes: {
        '/': (ctx) => UpcomingContests(),
        UpcomingContests.routeName: (ctx) => UpcomingContests(),
      },
    );
  }
}
