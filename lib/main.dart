import 'package:flapp/maths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'march.dart';

// ##### TODO colours for dark and light!!! TODO
void main() => runApp(ProviderScope(child: const MainApp()));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ## Routing
      initialRoute: 'algebra',
      routes: march,

      // ## Theme
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.lightBlueAccent,
        ),
      ),
      //themeMode: ThemeMode.light,
      themeMode: ThemeMode.system,

      // ## Content
      home: Scaffold(
        body: MathsPage(),
      ),
    );
  }
}
