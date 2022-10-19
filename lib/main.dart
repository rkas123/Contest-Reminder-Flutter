import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './helper/hex_color.dart' as hexcolor;

import './screens/upcoming_contests.dart';
import './screens/notif_contests.dart';
import './screens/tabs_screen.dart';
import './screens/auth_screen.dart';

import './providers/contests.dart';
import './providers/notifs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//COLOR Palettes
//B7C4CF, EEE3CB, D7C0AE, 967E76
//222831, 393E46, 00ADB5, EEEEEE
//112D4E, 3F72AF, DBE2EF, F9F7F7  --> currently using

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Contests()),
        ChangeNotifierProvider(create: (ctx) => NotifContest())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: hexcolor.HexColor('112D4E'),
          backgroundColor: hexcolor.HexColor('112D4E'),
          canvasColor: hexcolor.HexColor('3F72AF'),
          accentColor: hexcolor.HexColor('DBE2EF'),
        ),
        routes: {
          UpcomingContests.routeName: (ctx) => const UpcomingContests(),
          NotifContestScreen.routeName: (ctx) => const NotifContestScreen(),
          TabsScreen.routeName: (ctx) => const TabsScreen(),
          AuthScreen.routeName: (ctx) => const AuthScreen(),
        },

        //Set up a stream builder to handle the auth state
        //This changes the screen rendered whenever the auth state changes
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return const TabsScreen();
            }
            return const AuthScreen();
          },
        ),
      ),
    );
  }
}
