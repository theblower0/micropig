import 'package:flutter/material.dart';
import 'package:micropig/models/user.dart';
import 'package:micropig/screens/authenticate/authenticate.dart';
import 'package:micropig/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
