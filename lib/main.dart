//import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:jewelio/screens/explore_page.dart';
//import 'firebase/firebase_options.dart';
//import 'screens/login_screen.dart';

//void main() async {
//WidgetsFlutterBinding.ensureInitialized();
//await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//runApp(const MyApp());
//}

//class MyApp extends StatelessWidget {
//const MyApp({super.key});

//@override
//Widget build(BuildContext context) {
//return MaterialApp(
//title: 'Jewelio',
//debugShowCheckedModeBanner: false,
//home: LoginScreen(), // Make sure you have LoginScreen implemented
//);
//}
//}

// Optional: If you want to keep a demo home page
//class MyHomePage extends StatefulWidget {
//const MyHomePage({super.key, required this.title});

//final String title;

//@override
//State<MyHomePage> createState() => _MyHomePageState();
//}

//class _MyHomePageState extends State<MyHomePage> {
//int _counter = 0;

//void _incrementCounter() {
//setState(() {
//_counter++;
//});
//}

//@override
//Widget build(BuildContext context) {
//return Scaffold(
//appBar: AppBar(
//title: Text(widget.title),
//backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//),
//body: Center(
//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//const Text('You have pushed the button this many times:'),
//Text(
//'$_counter',
//style: Theme.of(context).textTheme.headlineMedium,
//),
//],
//),
//),
//floatingActionButton: FloatingActionButton(
//onPressed: _incrementCounter,
//tooltip: 'Increment',
//child: const Icon(Icons.add),
//),
//);
//}
//}

import 'package:flutter/material.dart';
import 'screens/explore_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExplorePage(),
    );
  }
}
