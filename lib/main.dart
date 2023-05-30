import 'package:elive/signup/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage/mainhomepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool isLogin = sp.getBool("is_login") ?? false;
  await Future.delayed(const Duration(seconds: 3));
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elive',
      home: isLogin ? const MainHomePage() : const Signup(),
    ),
  );
}
