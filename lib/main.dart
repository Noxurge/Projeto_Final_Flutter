import 'package:flutter/material.dart';
import 'package:projeto_final/pages/city_page.dart';
import 'package:projeto_final/pages/client_page.dart';
import 'package:projeto_final/pages/home.dart';
import 'package:projeto_final/pages/list_city.dart';
import 'package:projeto_final/pages/list_client.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/city_page': (context) => const City_Register(),
        '/client_page': (context) => const Client_Register(),
        '/list_city': (context) => const City_Search(),
        '/list_client': (context) => const Client_Search()
      },
    );
  }
}
