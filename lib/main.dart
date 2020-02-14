import 'package:flutter/material.dart';
import 'package:restofood_api/ui/screens/dashboard_screen.dart';
import 'package:restofood_api/ui/screens/home_screen.dart';
import 'package:restofood_api/ui/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Restofood",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orange
      ),
      home: LoginScreen(),
      routes: {
        "/dashboard": (context) => DashboardScreen()
      },
    );
  }
}