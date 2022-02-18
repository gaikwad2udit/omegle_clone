import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webui/auth_screen.dart';
import 'package:webui/constants.dart';
import 'package:webui/controllers/menucontroller.dart';

import 'package:webui/screens/main/mainscreen.dart';
import 'package:webui/screens/navigator_screen.dart';
import 'package:webui/services/buttonstate.dart';
import 'package:webui/services/firebaseServices.dart';
import 'package:webui/services/states.dart';
import 'package:webui/waiting_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        //name: 'webui',
        options: FirebaseOptions(
      measurementId: "G-ZHDGQDNSDV",
      apiKey: "AIzaSyBRWkt1VZJbH6MW5aCTH8pnPJxzOg799BI",
      appId: "1:559208957066:web:1c16724b718d5226e05973",
      messagingSenderId: "559208957066",
      projectId: "stangers-1abe1",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData.dark().copyWith(
  //       scaffoldBackgroundColor: bgColor,
  //       textTheme: GoogleFonts.poppinsTextTheme(
  //           Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
  //       canvasColor: secondaryColor,
  //     ),
  //     home: MultiProvider(
  //       providers: [
  //         ChangeNotifierProvider(
  //           create: (context) => menucontroller(),
  //         )
  //       ],
  //       child: mainscreen(),
  //     ),
  //     routes: {
  //       nv_screen.routename: (_) => nv_screen(),
  //     },
  //   );
  // }

  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => menucontroller(),
          ),
          ChangeNotifierProvider(
            create: (context) => states(),
          ),
          ChangeNotifierProvider(
            create: (context) => firebaseServices(),
          ),
          ChangeNotifierProvider(
            create: (context) => buttonstate(),
          )
        ],
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(
                home: waitaing_screen(),
              );
            }
            if (snapshot.hasData) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: bgColor,
                  textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context)
                      .textTheme
                      .apply(bodyColor: Colors.white)),
                  canvasColor: secondaryColor,
                ),
                home: mainscreen(),
                // initialRoute: mainscreen.routename,
                // routes: {
                //   mainscreen.routename: (_) => mainscreen(),
                //   nv_screen.routename: (_) => nv_screen(),
                // },
              );
            } else {
              return MaterialApp(
                home: auth_screen(),
              );
            }
          },
        ));
  }
}
