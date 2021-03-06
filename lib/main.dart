import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sparkhub_game/constants/style.dart';
import 'package:sparkhub_game/models/wcmodels/Constants.dart';
import 'package:sparkhub_game/screens/home.dart';
import 'package:sparkhub_game/screens/login.dart';
import 'package:sparkhub_game/screens/matching_levels.dart';
import 'package:sparkhub_game/screens/memory_game_home_screen.dart';
import 'package:sparkhub_game/screens/memory_game_levels_screen.dart';
import 'package:sparkhub_game/screens/wcscreens/home_page.dart';
import 'package:sparkhub_game/providers/wordconnect_provider.dart';
import 'package:sparkhub_game/Admins/admin_wc.dart';
import 'package:sparkhub_game/Admins/admin_home.dart';
//import 'package:sparkhub_game/Admins/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Admins/memory_game_admin_screen.dart';
import 'auth/login.dart';
import 'providers/memory_game_provider.dart';
import 'providers/matching_providers.dart';

bool? islogin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemoryGameProvider()),
        ChangeNotifierProvider(create: (_) => MatchingProviders()),
        ChangeNotifierProvider(create: (_) => WordConnectProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /* return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(title: 'Provider Demo', home: Home_Screen()),
    );*/
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/home': (context) => const MyHomePage(
              title: '',
            ),
        '/match': (context) => const LevelsPagematch(),
        '/MemoryGameLevelsPage': (context) => const LevelsPage(),
        '/memoeryGameHomeScreen': (context) => const MemoryGameHomeScreen(),
        '/wchome': (context) => HomePage(),
        '/admin_memoryGame': (context) => const MemoryGameAdminScreen(),
        '/admin_wordconnect': (context) => const AdminWc(),
      },
      home: AnimatedSplashScreen(
        duration: 1500,
        splash: Image.asset(
          "assets/logo.png",
        ),
        nextScreen: islogin == false
            ? Login()
            : MyHomePage(
                title: '',
              ),
        // nextScreen: LoginScreen(),
        // nextScreen:  HomePage(),
        //nextScreen: AdminWc(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        backgroundColor: kBackground,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
