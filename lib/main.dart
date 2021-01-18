import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:micropig/models/user.dart';
import 'package:micropig/screens/splash.dart';
import 'package:micropig/screens/welcome.dart';
import 'package:micropig/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserClass>.value(
      value: AuthService().user,
      child: MaterialApp(
          home: Scaffold(
        body: PageView(
          children: [
            Splash(),
            Welcome(),
          ],
        ),
      )),
    );
  }
}
