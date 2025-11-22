import 'package:flutter/material.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // <-- harus const

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        primaryColor: const Color(0xFFA47449),
        scaffoldBackgroundColor: const Color(0xFFF8EEDC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFA47449),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const MainPage(), // <-- pastikan MainPage juga const
    );
  }
}
